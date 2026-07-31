-- =============================================================================
-- TaxPilot PostgreSQL Schema
-- Phase 1: Core Tables
-- FY 2024-25 | Indian Income Tax (New & Old Regime)
-- =============================================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =============================================================================
-- ENUMS
-- =============================================================================

CREATE TYPE tax_regime AS ENUM ('new', 'old');
CREATE TYPE profession_type AS ENUM (
    'salaried',
    'freelancer',
    'consultant',       -- eligible for 44ADA
    'business_owner',   -- eligible for 44AD
    'professional_44ADA' -- doctor, lawyer, architect, engineer, CA, etc.
);
CREATE TYPE income_category AS ENUM (
    'salary',
    'freelance',
    'consulting',
    'business',
    'capital_gains_stcg',
    'capital_gains_ltcg',
    'rental',
    'interest',
    'dividend',
    'other'
);
CREATE TYPE expense_category AS ENUM (
    'business_expense',
    'professional_expense',
    'travel',
    'office_supplies',
    'software_subscription',
    'internet',
    'phone',
    'training',
    'marketing',
    'rent',
    'utilities',
    'other'
);
CREATE TYPE deduction_section AS ENUM (
    '80C',
    '80CCD1B',  -- NPS additional
    '80D',      -- health insurance
    '80E',      -- education loan interest
    '80G',      -- donations
    '80TTA',    -- savings interest
    '80TTB',    -- senior citizen interest
    '24B',      -- home loan interest
    'HRA',
    'LTA',
    'standard_deduction',
    'other'
);
CREATE TYPE advance_tax_installment AS ENUM ('jun_15', 'sep_15', 'dec_15', 'mar_15');
CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'overdue');
CREATE TYPE notification_type AS ENUM (
    'advance_tax_due',
    'filing_deadline',
    'regime_suggestion',
    'deduction_reminder',
    'general'
);
CREATE TYPE report_type AS ENUM ('annual_summary', 'quarterly', 'tax_estimate', 'regime_comparison');
CREATE TYPE chat_role AS ENUM ('user', 'assistant');

-- =============================================================================
-- TABLE 1: users
-- =============================================================================

CREATE TABLE users (
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    firebase_uid        VARCHAR(128) UNIQUE NOT NULL,   -- Firebase Auth UID
    email               VARCHAR(255) UNIQUE NOT NULL,
    full_name           VARCHAR(255) NOT NULL,
    pan_number          VARCHAR(10),                    -- stored encrypted
    date_of_birth       DATE,
    phone_number        VARCHAR(15),
    profession_type     profession_type NOT NULL DEFAULT 'salaried',
    preferred_regime    tax_regime NOT NULL DEFAULT 'new',
    financial_year      VARCHAR(9) NOT NULL DEFAULT '2024-25',  -- e.g. "2024-25"
    is_senior_citizen   BOOLEAN NOT NULL DEFAULT FALSE,         -- age >= 60
    is_super_senior     BOOLEAN NOT NULL DEFAULT FALSE,         -- age >= 80
    annual_income_estimate NUMERIC(15, 2),                      -- rough estimate for onboarding
    profile_complete    BOOLEAN NOT NULL DEFAULT FALSE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_users_firebase_uid ON users(firebase_uid);
CREATE INDEX idx_users_email ON users(email);

-- =============================================================================
-- TABLE 2: income_entries
-- =============================================================================

CREATE TABLE income_entries (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    financial_year  VARCHAR(9) NOT NULL DEFAULT '2024-25',
    entry_date      DATE NOT NULL,
    amount          NUMERIC(15, 2) NOT NULL CHECK (amount > 0),
    category        income_category NOT NULL,
    description     TEXT,
    client_name     VARCHAR(255),    -- for freelance/consulting
    invoice_number  VARCHAR(100),    -- for freelance/consulting
    tds_deducted    NUMERIC(15, 2) NOT NULL DEFAULT 0 CHECK (tds_deducted >= 0),
    is_recurring    BOOLEAN NOT NULL DEFAULT FALSE,
    receipt_url     TEXT,            -- S3 / Firebase Storage URL
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_income_user_fy ON income_entries(user_id, financial_year);
CREATE INDEX idx_income_entry_date ON income_entries(user_id, entry_date DESC);
CREATE INDEX idx_income_category ON income_entries(user_id, category);

-- =============================================================================
-- TABLE 3: expense_entries
-- =============================================================================

CREATE TABLE expense_entries (
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id             UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    financial_year      VARCHAR(9) NOT NULL DEFAULT '2024-25',
    entry_date          DATE NOT NULL,
    amount              NUMERIC(15, 2) NOT NULL CHECK (amount > 0),
    category            expense_category NOT NULL,
    description         TEXT,
    is_tax_deductible   BOOLEAN NOT NULL DEFAULT TRUE,
    vendor_name         VARCHAR(255),
    receipt_url         TEXT,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_expense_user_fy ON expense_entries(user_id, financial_year);
CREATE INDEX idx_expense_entry_date ON expense_entries(user_id, entry_date DESC);
CREATE INDEX idx_expense_deductible ON expense_entries(user_id, is_tax_deductible);

-- =============================================================================
-- TABLE 4: deductions
-- (User-declared deductions — 80C, 80D, HRA, etc.)
-- =============================================================================

CREATE TABLE deductions (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    financial_year  VARCHAR(9) NOT NULL DEFAULT '2024-25',
    section         deduction_section NOT NULL,
    amount          NUMERIC(15, 2) NOT NULL CHECK (amount >= 0),
    description     TEXT,
    proof_url       TEXT,            -- document upload URL
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    -- Each section can only have one entry per user per FY
    -- (except 80G which can have multiple)
    UNIQUE (user_id, financial_year, section)
);

CREATE INDEX idx_deductions_user_fy ON deductions(user_id, financial_year);

-- =============================================================================
-- TABLE 5: tax_estimates
-- (Computed tax snapshots — recalculated on income/deduction changes)
-- =============================================================================

CREATE TABLE tax_estimates (
    id                          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id                     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    financial_year              VARCHAR(9) NOT NULL DEFAULT '2024-25',
    computed_at                 TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    -- Gross figures
    gross_income                NUMERIC(15, 2) NOT NULL DEFAULT 0,
    total_deductible_expenses   NUMERIC(15, 2) NOT NULL DEFAULT 0,
    net_income                  NUMERIC(15, 2) NOT NULL DEFAULT 0,

    -- 44ADA presumptive
    is_44ada_eligible           BOOLEAN NOT NULL DEFAULT FALSE,
    presumptive_income_44ada    NUMERIC(15, 2),   -- 50% of qualifying receipts

    -- Old regime
    total_deductions_old        NUMERIC(15, 2) NOT NULL DEFAULT 0,
    taxable_income_old          NUMERIC(15, 2) NOT NULL DEFAULT 0,
    tax_old_regime              NUMERIC(15, 2) NOT NULL DEFAULT 0,
    surcharge_old               NUMERIC(15, 2) NOT NULL DEFAULT 0,
    cess_old                    NUMERIC(15, 2) NOT NULL DEFAULT 0,
    total_tax_old               NUMERIC(15, 2) NOT NULL DEFAULT 0,

    -- New regime
    standard_deduction_new      NUMERIC(15, 2) NOT NULL DEFAULT 75000,
    taxable_income_new          NUMERIC(15, 2) NOT NULL DEFAULT 0,
    tax_new_regime              NUMERIC(15, 2) NOT NULL DEFAULT 0,
    surcharge_new               NUMERIC(15, 2) NOT NULL DEFAULT 0,
    cess_new                    NUMERIC(15, 2) NOT NULL DEFAULT 0,
    total_tax_new               NUMERIC(15, 2) NOT NULL DEFAULT 0,

    -- Recommendation
    recommended_regime          tax_regime,
    tax_saving_by_switching     NUMERIC(15, 2),   -- how much saved vs current choice

    -- TDS already paid
    total_tds_paid              NUMERIC(15, 2) NOT NULL DEFAULT 0,
    advance_tax_paid            NUMERIC(15, 2) NOT NULL DEFAULT 0,
    net_tax_payable             NUMERIC(15, 2) NOT NULL DEFAULT 0,

    UNIQUE (user_id, financial_year)  -- one live estimate per user per FY
);

CREATE INDEX idx_tax_estimates_user_fy ON tax_estimates(user_id, financial_year);

-- =============================================================================
-- TABLE 6: advance_tax_schedule
-- (Per-user advance tax installments with amounts and status)
-- =============================================================================

CREATE TABLE advance_tax_schedule (
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id             UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    financial_year      VARCHAR(9) NOT NULL DEFAULT '2024-25',
    installment         advance_tax_installment NOT NULL,
    due_date            DATE NOT NULL,
    cumulative_percent  SMALLINT NOT NULL,   -- 15, 45, 75, 100
    estimated_amount    NUMERIC(15, 2) NOT NULL DEFAULT 0,
    amount_paid         NUMERIC(15, 2) NOT NULL DEFAULT 0,
    status              payment_status NOT NULL DEFAULT 'pending',
    paid_on             DATE,
    challan_number      VARCHAR(100),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE (user_id, financial_year, installment)
);

CREATE INDEX idx_advance_tax_user_fy ON advance_tax_schedule(user_id, financial_year);
CREATE INDEX idx_advance_tax_status ON advance_tax_schedule(status, due_date);

-- =============================================================================
-- TABLE 7: ai_chat_history
-- =============================================================================

CREATE TABLE ai_chat_history (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    session_id      UUID NOT NULL DEFAULT uuid_generate_v4(),  -- groups messages in one chat session
    role            chat_role NOT NULL,
    message         TEXT NOT NULL,
    context_data    JSONB,           -- snapshot of financial context sent to Gemini
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_chat_user_session ON ai_chat_history(user_id, session_id, created_at DESC);
CREATE INDEX idx_chat_user_recent ON ai_chat_history(user_id, created_at DESC);

-- =============================================================================
-- TABLE 8: notifications
-- =============================================================================

CREATE TABLE notifications (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type            notification_type NOT NULL,
    title           VARCHAR(255) NOT NULL,
    body            TEXT NOT NULL,
    metadata        JSONB,           -- e.g. { "installment": "sep_15", "amount": 15000 }
    is_read         BOOLEAN NOT NULL DEFAULT FALSE,
    scheduled_for   TIMESTAMPTZ,     -- for future-dated notifications
    sent_at         TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_notifications_user_unread ON notifications(user_id, is_read, created_at DESC);
CREATE INDEX idx_notifications_scheduled ON notifications(scheduled_for) WHERE sent_at IS NULL;

-- =============================================================================
-- TABLE 9: reports
-- =============================================================================

CREATE TABLE reports (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    financial_year  VARCHAR(9) NOT NULL DEFAULT '2024-25',
    report_type     report_type NOT NULL,
    title           VARCHAR(255) NOT NULL,
    generated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    pdf_url         TEXT,            -- Firebase Storage / S3 URL
    report_data     JSONB NOT NULL,  -- full snapshot of data used to generate report
    is_favorite     BOOLEAN NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_reports_user_fy ON reports(user_id, financial_year, generated_at DESC);

-- =============================================================================
-- REFERENCE TABLE: tax_slabs
-- (Parameterized — no hardcoding in application code)
-- =============================================================================

CREATE TABLE tax_slabs (
    id              SERIAL PRIMARY KEY,
    regime          tax_regime NOT NULL,
    financial_year  VARCHAR(9) NOT NULL,
    slab_order      SMALLINT NOT NULL,
    income_from     NUMERIC(15, 2) NOT NULL,
    income_to       NUMERIC(15, 2),              -- NULL means no upper limit
    rate_percent    NUMERIC(5, 2) NOT NULL,
    taxpayer_type   VARCHAR(50) NOT NULL DEFAULT 'individual',  -- individual / senior / super_senior

    UNIQUE (regime, financial_year, slab_order, taxpayer_type)
);

-- =============================================================================
-- REFERENCE TABLE: surcharge_rates
-- =============================================================================

CREATE TABLE surcharge_rates (
    id              SERIAL PRIMARY KEY,
    regime          tax_regime NOT NULL,
    financial_year  VARCHAR(9) NOT NULL,
    income_from     NUMERIC(15, 2) NOT NULL,
    income_to       NUMERIC(15, 2),
    rate_percent    NUMERIC(5, 2) NOT NULL,

    UNIQUE (regime, financial_year, income_from)
);

-- =============================================================================
-- REFERENCE TABLE: deduction_limits
-- (Max allowed per section per FY)
-- =============================================================================

CREATE TABLE deduction_limits (
    id              SERIAL PRIMARY KEY,
    section         deduction_section NOT NULL,
    financial_year  VARCHAR(9) NOT NULL,
    max_amount      NUMERIC(15, 2),     -- NULL = no limit (e.g. 80G proportional)
    description     TEXT,
    applicable_regime tax_regime[],     -- NULL = both regimes; array if regime-specific

    UNIQUE (section, financial_year)
);

-- =============================================================================
-- AUTO-UPDATE updated_at TRIGGER
-- =============================================================================

CREATE OR REPLACE FUNCTION trigger_set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at_users
    BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

CREATE TRIGGER set_updated_at_income
    BEFORE UPDATE ON income_entries
    FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

CREATE TRIGGER set_updated_at_expense
    BEFORE UPDATE ON expense_entries
    FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

CREATE TRIGGER set_updated_at_deductions
    BEFORE UPDATE ON deductions
    FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

CREATE TRIGGER set_updated_at_advance_tax
    BEFORE UPDATE ON advance_tax_schedule
    FOR EACH ROW EXECUTE FUNCTION trigger_set_updated_at();

-- =============================================================================
-- TRIGGER: auto-mark advance tax as overdue
-- =============================================================================

CREATE OR REPLACE FUNCTION trigger_check_advance_tax_overdue()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'pending' AND NEW.due_date < CURRENT_DATE THEN
        NEW.status = 'overdue';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_advance_tax_overdue
    BEFORE INSERT OR UPDATE ON advance_tax_schedule
    FOR EACH ROW EXECUTE FUNCTION trigger_check_advance_tax_overdue();
