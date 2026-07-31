-- =============================================================================
-- TaxPilot Tax Calculation Queries
-- Phase 2: Tax Logic, Regime Comparison, 44ADA, Advance Tax
-- FY 2024-25
-- All queries are written as reusable functions or parameterized CTEs.
-- =============================================================================

-- =============================================================================
-- SECTION 1: HELPER FUNCTION — Calculate tax on a given income for a regime
-- =============================================================================

CREATE OR REPLACE FUNCTION calculate_slab_tax(
    p_taxable_income  NUMERIC,
    p_regime          tax_regime,
    p_financial_year  VARCHAR,
    p_taxpayer_type   VARCHAR DEFAULT 'individual'
)
RETURNS NUMERIC AS $$
DECLARE
    v_tax       NUMERIC := 0;
    v_prev_to   NUMERIC := 0;
    v_slab      RECORD;
    v_slab_top  NUMERIC;
    v_slab_income NUMERIC;
BEGIN
    IF p_taxable_income <= 0 THEN
        RETURN 0;
    END IF;

    FOR v_slab IN
        SELECT income_from, income_to, rate_percent
        FROM   tax_slabs
        WHERE  regime         = p_regime
          AND  financial_year = p_financial_year
          AND  taxpayer_type  = p_taxpayer_type
        ORDER  BY slab_order
    LOOP
        v_slab_top    := COALESCE(v_slab.income_to, p_taxable_income);
        v_slab_income := LEAST(p_taxable_income, v_slab_top) - v_slab.income_from;

        IF v_slab_income > 0 THEN
            v_tax := v_tax + (v_slab_income * v_slab.rate_percent / 100);
        END IF;

        EXIT WHEN p_taxable_income <= v_slab_top;
    END LOOP;

    RETURN ROUND(v_tax, 2);
END;
$$ LANGUAGE plpgsql STABLE;

-- =============================================================================
-- SECTION 2: HELPER FUNCTION — Calculate surcharge
-- =============================================================================

CREATE OR REPLACE FUNCTION calculate_surcharge(
    p_gross_income    NUMERIC,
    p_base_tax        NUMERIC,
    p_regime          tax_regime,
    p_financial_year  VARCHAR
)
RETURNS NUMERIC AS $$
DECLARE
    v_rate  NUMERIC := 0;
BEGIN
    SELECT rate_percent INTO v_rate
    FROM   surcharge_rates
    WHERE  regime         = p_regime
      AND  financial_year = p_financial_year
      AND  p_gross_income > income_from
      AND  (income_to IS NULL OR p_gross_income <= income_to)
    LIMIT 1;

    RETURN ROUND(p_base_tax * COALESCE(v_rate, 0) / 100, 2);
END;
$$ LANGUAGE plpgsql STABLE;

-- =============================================================================
-- SECTION 3: HELPER FUNCTION — Apply Section 87A rebate
-- New regime: rebate up to ₹25,000 for taxable income ≤ ₹7,00,000
-- Old regime: rebate up to ₹12,500 for taxable income ≤ ₹5,00,000
-- =============================================================================

CREATE OR REPLACE FUNCTION apply_87a_rebate(
    p_taxable_income  NUMERIC,
    p_base_tax        NUMERIC,
    p_regime          tax_regime
)
RETURNS NUMERIC AS $$
DECLARE
    v_rebate_limit      NUMERIC;
    v_income_threshold  NUMERIC;
BEGIN
    IF p_regime = 'new' THEN
        v_rebate_limit     := 25000;
        v_income_threshold := 700000;
    ELSE
        v_rebate_limit     := 12500;
        v_income_threshold := 500000;
    END IF;

    IF p_taxable_income <= v_income_threshold THEN
        -- Rebate = min(base_tax, rebate_limit) — tax cannot go below 0
        RETURN GREATEST(p_base_tax - LEAST(p_base_tax, v_rebate_limit), 0);
    END IF;

    RETURN p_base_tax;
END;
$$ LANGUAGE plpgsql STABLE;

-- =============================================================================
-- SECTION 4: CORE FUNCTION — Full tax computation for a user (both regimes)
-- Returns one row per regime with complete breakdown
-- =============================================================================

CREATE OR REPLACE FUNCTION compute_tax_for_user(
    p_user_id        UUID,
    p_financial_year VARCHAR DEFAULT '2024-25'
)
RETURNS TABLE (
    regime                    tax_regime,
    gross_income              NUMERIC,
    is_44ada_eligible         BOOLEAN,
    qualifying_receipts_44ada NUMERIC,
    presumptive_income_44ada  NUMERIC,
    effective_income          NUMERIC,   -- gross or presumptive, depending on path chosen
    standard_deduction        NUMERIC,
    chapter_via_deductions    NUMERIC,
    total_deductions          NUMERIC,
    taxable_income            NUMERIC,
    slab_tax                  NUMERIC,
    rebate_87a                NUMERIC,
    tax_after_rebate          NUMERIC,
    surcharge                 NUMERIC,
    cess                      NUMERIC,
    total_tax                 NUMERIC,
    tds_paid                  NUMERIC,
    advance_tax_paid          NUMERIC,
    net_payable               NUMERIC    -- negative = refund
) AS $$
DECLARE
    v_user              RECORD;
    v_taxpayer_type     VARCHAR;
    v_gross_income      NUMERIC;
    v_consulting_income NUMERIC;
    v_is_44ada          BOOLEAN;
    v_presumptive       NUMERIC;
    v_total_tds         NUMERIC;
    v_advance_paid      NUMERIC;
    v_deductions_old    NUMERIC;
    v_std_deduction_old NUMERIC := 50000;
    v_std_deduction_new NUMERIC := 75000;
BEGIN
    -- Load user profile
    SELECT * INTO v_user FROM users
    WHERE id = p_user_id AND financial_year = p_financial_year;

    -- Determine taxpayer type for slab lookup
    v_taxpayer_type := CASE
        WHEN v_user.is_super_senior THEN 'super_senior'
        WHEN v_user.is_senior_citizen THEN 'senior'
        ELSE 'individual'
    END;

    -- Gross income: sum all income entries for the FY
    SELECT COALESCE(SUM(amount), 0) INTO v_gross_income
    FROM income_entries
    WHERE user_id = p_user_id AND financial_year = p_financial_year;

    -- TDS already deducted
    SELECT COALESCE(SUM(tds_deducted), 0) INTO v_total_tds
    FROM income_entries
    WHERE user_id = p_user_id AND financial_year = p_financial_year;

    -- Advance tax paid so far
    SELECT COALESCE(SUM(amount_paid), 0) INTO v_advance_paid
    FROM advance_tax_schedule
    WHERE user_id = p_user_id AND financial_year = p_financial_year;

    -- 44ADA: consulting/professional receipts only (not interest, rental, etc.)
    SELECT COALESCE(SUM(amount), 0) INTO v_consulting_income
    FROM income_entries
    WHERE user_id       = p_user_id
      AND financial_year = p_financial_year
      AND category       IN ('consulting', 'freelance');

    -- 44ADA eligible: profession type is consultant/professional AND receipts ≤ ₹75,00,000
    v_is_44ada := (
        v_user.profession_type IN ('consultant', 'professional_44ADA')
        AND v_consulting_income <= 7500000
    );

    v_presumptive := CASE WHEN v_is_44ada THEN ROUND(v_consulting_income * 0.5, 2) ELSE NULL END;

    -- Old regime Chapter VI-A deductions (capped at their limits)
    SELECT COALESCE(SUM(
        LEAST(d.amount, COALESCE(dl.max_amount, d.amount))
    ), 0)
    INTO v_deductions_old
    FROM deductions d
    JOIN deduction_limits dl
      ON dl.section = d.section AND dl.financial_year = p_financial_year
    WHERE d.user_id        = p_user_id
      AND d.financial_year = p_financial_year;

    -- ----------------------------------------------------------------
    -- Emit NEW REGIME row
    -- ----------------------------------------------------------------
    regime                    := 'new';
    gross_income              := v_gross_income;
    is_44ada_eligible         := v_is_44ada;
    qualifying_receipts_44ada := CASE WHEN v_is_44ada THEN v_consulting_income ELSE NULL END;
    presumptive_income_44ada  := v_presumptive;

    -- Under new regime with 44ADA: use presumptive income + other non-professional income
    effective_income := CASE
        WHEN v_is_44ada THEN
            v_presumptive + (v_gross_income - v_consulting_income)
        ELSE
            v_gross_income
    END;

    standard_deduction     := v_std_deduction_new;
    chapter_via_deductions := 0;   -- new regime: no Chapter VI-A deductions (except NPS employer 80CCD2)
    total_deductions       := v_std_deduction_new;
    taxable_income         := GREATEST(effective_income - total_deductions, 0);
    slab_tax               := calculate_slab_tax(taxable_income, 'new', p_financial_year, 'individual');
    tax_after_rebate       := apply_87a_rebate(taxable_income, slab_tax, 'new');
    rebate_87a             := slab_tax - tax_after_rebate;
    surcharge              := calculate_surcharge(taxable_income, tax_after_rebate, 'new', p_financial_year);
    cess                   := ROUND((tax_after_rebate + surcharge) * 0.04, 2);
    total_tax              := tax_after_rebate + surcharge + cess;
    tds_paid               := v_total_tds;
    advance_tax_paid       := v_advance_paid;
    net_payable            := total_tax - v_total_tds - v_advance_paid;
    RETURN NEXT;

    -- ----------------------------------------------------------------
    -- Emit OLD REGIME row
    -- ----------------------------------------------------------------
    regime                    := 'old';
    gross_income              := v_gross_income;
    is_44ada_eligible         := v_is_44ada;
    qualifying_receipts_44ada := CASE WHEN v_is_44ada THEN v_consulting_income ELSE NULL END;
    presumptive_income_44ada  := v_presumptive;

    effective_income := CASE
        WHEN v_is_44ada THEN
            v_presumptive + (v_gross_income - v_consulting_income)
        ELSE
            v_gross_income
    END;

    standard_deduction     := v_std_deduction_old;
    chapter_via_deductions := v_deductions_old;
    total_deductions       := v_std_deduction_old + v_deductions_old;
    taxable_income         := GREATEST(effective_income - total_deductions, 0);
    slab_tax               := calculate_slab_tax(taxable_income, 'old', p_financial_year, v_taxpayer_type);
    tax_after_rebate       := apply_87a_rebate(taxable_income, slab_tax, 'old');
    rebate_87a             := slab_tax - tax_after_rebate;
    surcharge              := calculate_surcharge(taxable_income, tax_after_rebate, 'old', p_financial_year);
    cess                   := ROUND((tax_after_rebate + surcharge) * 0.04, 2);
    total_tax              := tax_after_rebate + surcharge + cess;
    tds_paid               := v_total_tds;
    advance_tax_paid       := v_advance_paid;
    net_payable            := total_tax - v_total_tds - v_advance_paid;
    RETURN NEXT;
END;
$$ LANGUAGE plpgsql STABLE;

-- =============================================================================
-- SECTION 5: FUNCTION — Regime comparison with recommendation
-- Returns the better regime and how much is saved
-- =============================================================================

CREATE OR REPLACE FUNCTION compare_regimes(
    p_user_id        UUID,
    p_financial_year VARCHAR DEFAULT '2024-25'
)
RETURNS TABLE (
    recommended_regime      tax_regime,
    tax_new_regime          NUMERIC,
    tax_old_regime          NUMERIC,
    saving_by_switching     NUMERIC,
    current_regime          tax_regime,
    action_required         BOOLEAN,
    summary                 TEXT
) AS $$
DECLARE
    v_new_tax  NUMERIC;
    v_old_tax  NUMERIC;
    v_current  tax_regime;
    v_saving   NUMERIC;
    v_best     tax_regime;
BEGIN
    -- Get current preferred regime
    SELECT preferred_regime INTO v_current FROM users WHERE id = p_user_id;

    -- Pull total_tax for each regime from compute function
    SELECT t.total_tax INTO v_new_tax
    FROM compute_tax_for_user(p_user_id, p_financial_year) t
    WHERE t.regime = 'new';

    SELECT t.total_tax INTO v_old_tax
    FROM compute_tax_for_user(p_user_id, p_financial_year) t
    WHERE t.regime = 'old';

    v_best := CASE WHEN v_new_tax <= v_old_tax THEN 'new' ELSE 'old' END;
    v_saving := ABS(v_new_tax - v_old_tax);

    recommended_regime  := v_best;
    tax_new_regime      := v_new_tax;
    tax_old_regime      := v_old_tax;
    saving_by_switching := v_saving;
    current_regime      := v_current;
    action_required     := (v_current != v_best);
    summary := CASE
        WHEN v_current = v_best THEN
            'You are already on the optimal regime. No change needed.'
        WHEN v_best = 'new' THEN
            'Switching to New Regime saves ₹' || TO_CHAR(v_saving, 'FM99,99,99,999') || ' this year.'
        ELSE
            'Switching to Old Regime saves ₹' || TO_CHAR(v_saving, 'FM99,99,99,999') ||
            ' due to your deductions exceeding the standard benefit.'
    END;
    RETURN NEXT;
END;
$$ LANGUAGE plpgsql STABLE;

-- =============================================================================
-- SECTION 6: FUNCTION — Advance tax schedule calculation
-- Computes installment amounts from projected annual tax liability
-- and upserts into advance_tax_schedule
-- =============================================================================

CREATE OR REPLACE FUNCTION calculate_advance_tax_schedule(
    p_user_id        UUID,
    p_financial_year VARCHAR DEFAULT '2024-25'
)
RETURNS TABLE (
    installment         advance_tax_installment,
    due_date            DATE,
    cumulative_percent  SMALLINT,
    cumulative_amount   NUMERIC,
    installment_amount  NUMERIC,
    already_paid        NUMERIC,
    balance_due         NUMERIC,
    status              payment_status
) AS $$
DECLARE
    v_annual_tax     NUMERIC;
    v_regime         tax_regime;
    v_prev_cumul     NUMERIC := 0;
    v_paid           NUMERIC;
    rec              RECORD;
BEGIN
    -- Use user's preferred regime for schedule
    SELECT preferred_regime INTO v_regime FROM users WHERE id = p_user_id;

    -- Get annual tax liability under chosen regime
    SELECT t.total_tax INTO v_annual_tax
    FROM compute_tax_for_user(p_user_id, p_financial_year) t
    WHERE t.regime = v_regime;

    -- Advance tax only applies if annual tax > ₹10,000
    IF v_annual_tax <= 10000 THEN
        RETURN;
    END IF;

    -- Loop through the 4 installments
    FOR rec IN
        SELECT * FROM (VALUES
            ('jun_15'::advance_tax_installment, '2024-06-15'::DATE, 15::SMALLINT),
            ('sep_15'::advance_tax_installment, '2024-09-15'::DATE, 45::SMALLINT),
            ('dec_15'::advance_tax_installment, '2024-12-15'::DATE, 75::SMALLINT),
            ('mar_15'::advance_tax_installment, '2025-03-15'::DATE, 100::SMALLINT)
        ) AS t(inst, ddate, pct)
    LOOP
        installment        := rec.inst;
        due_date           := rec.ddate;
        cumulative_percent := rec.pct;
        cumulative_amount  := ROUND(v_annual_tax * rec.pct / 100, 0);
        installment_amount := cumulative_amount - v_prev_cumul;

        -- How much has been paid for this installment already
        SELECT COALESCE(s.amount_paid, 0) INTO v_paid
        FROM advance_tax_schedule s
        WHERE s.user_id        = p_user_id
          AND s.financial_year = p_financial_year
          AND s.installment    = rec.inst;

        already_paid   := COALESCE(v_paid, 0);
        balance_due    := GREATEST(installment_amount - already_paid, 0);
        status := CASE
            WHEN already_paid >= installment_amount   THEN 'paid'::payment_status
            WHEN rec.ddate < CURRENT_DATE             THEN 'overdue'::payment_status
            ELSE 'pending'::payment_status
        END;

        -- Upsert the row in the table so the schedule stays current
        INSERT INTO advance_tax_schedule (
            user_id, financial_year, installment, due_date,
            cumulative_percent, estimated_amount, status
        ) VALUES (
            p_user_id, p_financial_year, rec.inst, rec.ddate,
            rec.pct, installment_amount, status
        )
        ON CONFLICT (user_id, financial_year, installment)
        DO UPDATE SET
            estimated_amount = EXCLUDED.estimated_amount,
            status = CASE
                WHEN advance_tax_schedule.amount_paid >= EXCLUDED.estimated_amount THEN 'paid'
                WHEN EXCLUDED.due_date < CURRENT_DATE THEN 'overdue'
                ELSE 'pending'
            END::payment_status,
            updated_at = NOW();

        v_prev_cumul := cumulative_amount;
        RETURN NEXT;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- =============================================================================
-- SECTION 7: FUNCTION — Refresh tax_estimates table
-- Called whenever income/expense/deduction rows change
-- =============================================================================

CREATE OR REPLACE FUNCTION refresh_tax_estimate(
    p_user_id        UUID,
    p_financial_year VARCHAR DEFAULT '2024-25'
)
RETURNS VOID AS $$
DECLARE
    v_new  RECORD;
    v_old  RECORD;
BEGIN
    -- Compute both regimes
    SELECT * INTO v_new FROM compute_tax_for_user(p_user_id, p_financial_year) WHERE regime = 'new';
    SELECT * INTO v_old FROM compute_tax_for_user(p_user_id, p_financial_year) WHERE regime = 'old';

    INSERT INTO tax_estimates (
        user_id, financial_year,
        gross_income, total_deductible_expenses, net_income,
        is_44ada_eligible, presumptive_income_44ada,
        total_deductions_old, taxable_income_old, tax_old_regime,
        surcharge_old, cess_old, total_tax_old,
        standard_deduction_new, taxable_income_new, tax_new_regime,
        surcharge_new, cess_new, total_tax_new,
        recommended_regime, tax_saving_by_switching,
        total_tds_paid, advance_tax_paid, net_tax_payable,
        computed_at
    ) VALUES (
        p_user_id, p_financial_year,
        v_new.gross_income, 0, v_new.effective_income,
        v_new.is_44ada_eligible, v_new.presumptive_income_44ada,
        v_old.total_deductions, v_old.taxable_income, v_old.tax_after_rebate,
        v_old.surcharge, v_old.cess, v_old.total_tax,
        v_new.standard_deduction, v_new.taxable_income, v_new.tax_after_rebate,
        v_new.surcharge, v_new.cess, v_new.total_tax,
        CASE WHEN v_new.total_tax <= v_old.total_tax THEN 'new' ELSE 'old' END,
        ABS(v_new.total_tax - v_old.total_tax),
        v_new.tds_paid, v_new.advance_tax_paid,
        LEAST(v_new.total_tax, v_old.total_tax) - v_new.tds_paid - v_new.advance_tax_paid,
        NOW()
    )
    ON CONFLICT (user_id, financial_year)
    DO UPDATE SET
        gross_income              = EXCLUDED.gross_income,
        net_income                = EXCLUDED.net_income,
        is_44ada_eligible         = EXCLUDED.is_44ada_eligible,
        presumptive_income_44ada  = EXCLUDED.presumptive_income_44ada,
        total_deductions_old      = EXCLUDED.total_deductions_old,
        taxable_income_old        = EXCLUDED.taxable_income_old,
        tax_old_regime            = EXCLUDED.tax_old_regime,
        surcharge_old             = EXCLUDED.surcharge_old,
        cess_old                  = EXCLUDED.cess_old,
        total_tax_old             = EXCLUDED.total_tax_old,
        standard_deduction_new    = EXCLUDED.standard_deduction_new,
        taxable_income_new        = EXCLUDED.taxable_income_new,
        tax_new_regime            = EXCLUDED.tax_new_regime,
        surcharge_new             = EXCLUDED.surcharge_new,
        cess_new                  = EXCLUDED.cess_new,
        total_tax_new             = EXCLUDED.total_tax_new,
        recommended_regime        = EXCLUDED.recommended_regime,
        tax_saving_by_switching   = EXCLUDED.tax_saving_by_switching,
        total_tds_paid            = EXCLUDED.total_tds_paid,
        advance_tax_paid          = EXCLUDED.advance_tax_paid,
        net_tax_payable           = EXCLUDED.net_tax_payable,
        computed_at               = NOW();
END;
$$ LANGUAGE plpgsql;

-- =============================================================================
-- SECTION 8: TRIGGERS — Auto-refresh estimate on data changes
-- =============================================================================

CREATE OR REPLACE FUNCTION trigger_refresh_estimate()
RETURNS TRIGGER AS $$
BEGIN
    PERFORM refresh_tax_estimate(
        COALESCE(NEW.user_id, OLD.user_id),
        COALESCE(NEW.financial_year, OLD.financial_year)
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Income changes → recalculate
CREATE TRIGGER trg_income_refresh
    AFTER INSERT OR UPDATE OR DELETE ON income_entries
    FOR EACH ROW EXECUTE FUNCTION trigger_refresh_estimate();

-- Expense changes → recalculate
CREATE TRIGGER trg_expense_refresh
    AFTER INSERT OR UPDATE OR DELETE ON expense_entries
    FOR EACH ROW EXECUTE FUNCTION trigger_refresh_estimate();

-- Deduction changes → recalculate
CREATE TRIGGER trg_deduction_refresh
    AFTER INSERT OR UPDATE OR DELETE ON deductions
    FOR EACH ROW EXECUTE FUNCTION trigger_refresh_estimate();

-- =============================================================================
-- SECTION 9: QUERY — Monthly income breakdown (for dashboard chart)
-- =============================================================================

CREATE OR REPLACE FUNCTION get_monthly_income_breakdown(
    p_user_id        UUID,
    p_financial_year VARCHAR DEFAULT '2024-25'
)
RETURNS TABLE (
    month_label  VARCHAR,
    month_number SMALLINT,
    total_income NUMERIC,
    total_tds    NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        TO_CHAR(entry_date, 'Mon YYYY')     AS month_label,
        EXTRACT(MONTH FROM entry_date)::SMALLINT AS month_number,
        SUM(amount)                         AS total_income,
        SUM(tds_deducted)                   AS total_tds
    FROM income_entries
    WHERE user_id        = p_user_id
      AND financial_year = p_financial_year
    GROUP BY TO_CHAR(entry_date, 'Mon YYYY'), EXTRACT(MONTH FROM entry_date)
    ORDER BY MIN(entry_date);
END;
$$ LANGUAGE plpgsql STABLE;

-- =============================================================================
-- SECTION 10: QUERY — 44ADA eligibility check with detailed reasoning
-- =============================================================================

CREATE OR REPLACE FUNCTION check_44ada_eligibility(
    p_user_id        UUID,
    p_financial_year VARCHAR DEFAULT '2024-25'
)
RETURNS TABLE (
    is_eligible          BOOLEAN,
    profession_type      profession_type,
    qualifying_receipts  NUMERIC,
    receipt_limit        NUMERIC,
    presumptive_income   NUMERIC,
    effective_tax_rate   NUMERIC,
    reason               TEXT
) AS $$
DECLARE
    v_user       RECORD;
    v_receipts   NUMERIC;
BEGIN
    SELECT * INTO v_user FROM users WHERE id = p_user_id;

    SELECT COALESCE(SUM(amount), 0) INTO v_receipts
    FROM income_entries
    WHERE user_id        = p_user_id
      AND financial_year = p_financial_year
      AND category       IN ('consulting', 'freelance');

    is_eligible         := v_user.profession_type IN ('consultant', 'professional_44ADA')
                           AND v_receipts <= 7500000;
    profession_type     := v_user.profession_type;
    qualifying_receipts := v_receipts;
    receipt_limit       := 7500000;
    presumptive_income  := CASE WHEN is_eligible THEN ROUND(v_receipts * 0.5, 2) ELSE NULL END;
    effective_tax_rate  := CASE WHEN is_eligible AND v_receipts > 0
                                THEN ROUND(presumptive_income / v_receipts * 100, 2)
                                ELSE NULL END;
    reason := CASE
        WHEN NOT (v_user.profession_type IN ('consultant', 'professional_44ADA')) THEN
            'Profession type ' || v_user.profession_type || ' is not covered under Section 44ADA.'
        WHEN v_receipts > 7500000 THEN
            'Professional receipts ₹' || TO_CHAR(v_receipts, 'FM99,99,99,999') ||
            ' exceed the ₹75,00,000 limit for 44ADA.'
        ELSE
            'Eligible for Section 44ADA. Declare 50% of ₹' ||
            TO_CHAR(v_receipts, 'FM99,99,99,999') || ' = ₹' ||
            TO_CHAR(presumptive_income, 'FM99,99,99,999') || ' as presumptive income. ' ||
            'No need to maintain books of accounts.'
    END;
    RETURN NEXT;
END;
$$ LANGUAGE plpgsql STABLE;

-- =============================================================================
-- SECTION 11: QUERY — Dashboard summary (single call for the home screen)
-- =============================================================================

CREATE OR REPLACE FUNCTION get_dashboard_summary(
    p_user_id        UUID,
    p_financial_year VARCHAR DEFAULT '2024-25'
)
RETURNS TABLE (
    full_name              VARCHAR,
    preferred_regime       tax_regime,
    gross_income           NUMERIC,
    total_tds              NUMERIC,
    advance_tax_paid       NUMERIC,
    estimated_tax          NUMERIC,
    net_tax_payable        NUMERIC,
    recommended_regime     tax_regime,
    saving_by_switching    NUMERIC,
    is_44ada_eligible      BOOLEAN,
    presumptive_income     NUMERIC,
    next_installment       advance_tax_installment,
    next_due_date          DATE,
    next_installment_amount NUMERIC,
    days_until_due         INT
) AS $$
DECLARE
    v_tax_row   RECORD;
    v_compare   RECORD;
    v_next_inst RECORD;
BEGIN
    -- Pull the preferred regime computation
    SELECT u.full_name, u.preferred_regime INTO full_name, preferred_regime
    FROM users u WHERE u.id = p_user_id;

    SELECT * INTO v_tax_row
    FROM compute_tax_for_user(p_user_id, p_financial_year)
    WHERE regime = preferred_regime;

    SELECT * INTO v_compare FROM compare_regimes(p_user_id, p_financial_year);

    -- Next pending or overdue installment
    SELECT inst.installment, inst.due_date, inst.estimated_amount
    INTO v_next_inst
    FROM advance_tax_schedule inst
    WHERE inst.user_id        = p_user_id
      AND inst.financial_year = p_financial_year
      AND inst.status         IN ('pending', 'overdue')
    ORDER BY inst.due_date
    LIMIT 1;

    gross_income            := v_tax_row.gross_income;
    total_tds               := v_tax_row.tds_paid;
    advance_tax_paid        := v_tax_row.advance_tax_paid;
    estimated_tax           := v_tax_row.total_tax;
    net_tax_payable         := v_tax_row.net_payable;
    recommended_regime      := v_compare.recommended_regime;
    saving_by_switching     := CASE WHEN v_compare.action_required THEN v_compare.saving_by_switching ELSE 0 END;
    is_44ada_eligible       := v_tax_row.is_44ada_eligible;
    presumptive_income      := v_tax_row.presumptive_income_44ada;
    next_installment        := v_next_inst.installment;
    next_due_date           := v_next_inst.due_date;
    next_installment_amount := v_next_inst.estimated_amount;
    days_until_due          := (v_next_inst.due_date - CURRENT_DATE)::INT;
    RETURN NEXT;
END;
$$ LANGUAGE plpgsql STABLE;

-- =============================================================================
-- SECTION 12: VERIFICATION QUERIES
-- Run these after seeding to confirm the logic is correct
-- =============================================================================

-- 1. Full tax computation for Arjun (both regimes)
-- SELECT * FROM compute_tax_for_user('a0000000-0000-0000-0000-000000000001', '2024-25');

-- 2. Regime recommendation
-- SELECT * FROM compare_regimes('a0000000-0000-0000-0000-000000000001', '2024-25');

-- 3. 44ADA eligibility check
-- SELECT * FROM check_44ada_eligibility('a0000000-0000-0000-0000-000000000001', '2024-25');

-- 4. Advance tax schedule (recalculated from current liability)
-- SELECT * FROM calculate_advance_tax_schedule('a0000000-0000-0000-0000-000000000001', '2024-25');

-- 5. Monthly income breakdown for chart
-- SELECT * FROM get_monthly_income_breakdown('a0000000-0000-0000-0000-000000000001', '2024-25');

-- 6. Dashboard summary (single call)
-- SELECT * FROM get_dashboard_summary('a0000000-0000-0000-0000-000000000001', '2024-25');

-- 7. Quick sanity check on slab tax function
-- SELECT
--     calculate_slab_tax(625000, 'new', '2024-25', 'individual') AS new_slab_tax,   -- expect 16,250
--     calculate_slab_tax(1026000, 'old', '2024-25', 'individual') AS old_slab_tax;  -- expect 157,200
