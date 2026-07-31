-- =============================================================================
-- TaxPilot Seed Data
-- Phase 1: Reference Data + Sample User
-- FY 2024-25
-- =============================================================================

-- =============================================================================
-- TAX SLABS — NEW REGIME (FY 2024-25)
-- Budget 2024 revised slabs effective FY 2024-25
-- Standard deduction: ₹75,000 (increased from ₹50,000)
-- Rebate u/s 87A: Up to ₹25,000 for income ≤ ₹7,00,000
-- =============================================================================

INSERT INTO tax_slabs (regime, financial_year, slab_order, income_from, income_to, rate_percent, taxpayer_type) VALUES
-- New Regime — Individual (same for all age groups under new regime)
('new', '2024-25', 1,         0.00,   300000.00,  0.00, 'individual'),
('new', '2024-25', 2,    300001.00,   700000.00,  5.00, 'individual'),
('new', '2024-25', 3,    700001.00,  1000000.00, 10.00, 'individual'),
('new', '2024-25', 4,   1000001.00,  1200000.00, 15.00, 'individual'),
('new', '2024-25', 5,   1200001.00,  1500000.00, 20.00, 'individual'),
('new', '2024-25', 6,   1500001.00,        NULL, 30.00, 'individual');

-- =============================================================================
-- TAX SLABS — OLD REGIME (FY 2024-25)
-- =============================================================================

INSERT INTO tax_slabs (regime, financial_year, slab_order, income_from, income_to, rate_percent, taxpayer_type) VALUES
-- Old Regime — Individual (below 60)
('old', '2024-25', 1,        0.00,   250000.00,  0.00, 'individual'),
('old', '2024-25', 2,   250001.00,   500000.00,  5.00, 'individual'),
('old', '2024-25', 3,   500001.00,  1000000.00, 20.00, 'individual'),
('old', '2024-25', 4,  1000001.00,        NULL, 30.00, 'individual'),

-- Old Regime — Senior Citizen (60–79)
('old', '2024-25', 1,        0.00,   300000.00,  0.00, 'senior'),
('old', '2024-25', 2,   300001.00,   500000.00,  5.00, 'senior'),
('old', '2024-25', 3,   500001.00,  1000000.00, 20.00, 'senior'),
('old', '2024-25', 4,  1000001.00,        NULL, 30.00, 'senior'),

-- Old Regime — Super Senior Citizen (80+)
('old', '2024-25', 1,        0.00,   500000.00,  0.00, 'super_senior'),
('old', '2024-25', 2,   500001.00,  1000000.00, 20.00, 'super_senior'),
('old', '2024-25', 3,  1000001.00,        NULL, 30.00, 'super_senior');

-- =============================================================================
-- SURCHARGE RATES (FY 2024-25)
-- Applied on tax amount, not income
-- New regime: surcharge capped at 25% for income > ₹5Cr
-- Old regime: standard surcharge progression
-- =============================================================================

INSERT INTO surcharge_rates (regime, financial_year, income_from, income_to, rate_percent) VALUES
-- New Regime
('new', '2024-25',         0.00,  5000000.00,  0.00),   -- up to 50L: nil
('new', '2024-25',   5000001.00, 10000000.00, 10.00),   -- 50L–1Cr: 10%
('new', '2024-25',  10000001.00, 20000000.00, 15.00),   -- 1Cr–2Cr: 15%
('new', '2024-25',  20000001.00, 50000000.00, 25.00),   -- 2Cr–5Cr: 25% (capped)
('new', '2024-25',  50000001.00,        NULL, 25.00),   -- >5Cr: 25% (capped)

-- Old Regime
('old', '2024-25',         0.00,  5000000.00,  0.00),   -- up to 50L: nil
('old', '2024-25',   5000001.00, 10000000.00, 10.00),   -- 50L–1Cr: 10%
('old', '2024-25',  10000001.00, 20000000.00, 15.00),   -- 1Cr–2Cr: 15%
('old', '2024-25',  20000001.00, 50000000.00, 25.00),   -- 2Cr–5Cr: 25%
('old', '2024-25',  50000001.00,        NULL, 37.00);   -- >5Cr: 37% (old regime only)

-- =============================================================================
-- DEDUCTION LIMITS (FY 2024-25)
-- applicable_regime = NULL means deduction exists only in old regime
-- (New regime allows almost no Chapter VI-A deductions)
-- =============================================================================

INSERT INTO deduction_limits (section, financial_year, max_amount, description, applicable_regime) VALUES
('80C',            '2024-25', 150000.00,
 'LIC, PPF, ELSS, EPF, tuition fees, home loan principal, NSC, etc.',
 NULL),  -- old regime only

('80CCD1B',        '2024-25',  50000.00,
 'Additional NPS contribution over 80C limit',
 NULL),  -- old regime only

('80D',            '2024-25',  25000.00,
 'Health insurance premium (self + family). ₹50,000 for senior citizens.',
 NULL),

('80E',            '2024-25',       NULL,
 'Education loan interest — no upper limit, 8 years',
 NULL),

('80G',            '2024-25',       NULL,
 'Donations — 50% or 100% deduction depending on fund. No upper limit for certain funds.',
 NULL),

('80TTA',          '2024-25',  10000.00,
 'Interest on savings account (non-senior citizens)',
 NULL),

('80TTB',          '2024-25',  50000.00,
 'Interest on deposits for senior citizens (replaces 80TTA)',
 NULL),

('24B',            '2024-25', 200000.00,
 'Home loan interest for self-occupied property',
 NULL),

('HRA',            '2024-25',       NULL,
 'House Rent Allowance — calculated as min of: actual HRA, 50%/40% of salary, rent paid minus 10% salary',
 NULL),

('LTA',            '2024-25',       NULL,
 'Leave Travel Allowance — twice in a block of 4 years',
 NULL),

('standard_deduction', '2024-25', 75000.00,
 'Standard deduction for salaried/pensioners. ₹75,000 in new regime (Budget 2024), ₹50,000 in old.',
 ARRAY['new', 'old']::tax_regime[]);  -- available in both, but different amounts

-- =============================================================================
-- SAMPLE USER (for dev/testing)
-- firebase_uid is a placeholder — replace with real Firebase UID during testing
-- =============================================================================

INSERT INTO users (
    id,
    firebase_uid,
    email,
    full_name,
    pan_number,
    date_of_birth,
    phone_number,
    profession_type,
    preferred_regime,
    financial_year,
    is_senior_citizen,
    is_super_senior,
    annual_income_estimate,
    profile_complete
) VALUES (
    'a0000000-0000-0000-0000-000000000001',
    'firebase_test_uid_001',
    'arjun.sharma@example.com',
    'Arjun Sharma',
    'ABCDE1234F',          -- dummy PAN
    '1990-04-15',
    '9876543210',
    'consultant',          -- 44ADA eligible profession
    'new',
    '2024-25',
    FALSE,
    FALSE,
    1200000.00,            -- ₹12L estimated annual income
    TRUE
);

-- =============================================================================
-- SAMPLE INCOME ENTRIES for Arjun (FY 2024-25)
-- Consultant with multiple clients — tests 44ADA eligibility
-- Total professional receipts: ₹14,00,000 — above ₹75L limit? No, well below.
-- 44ADA eligible: presumptive income = 50% = ₹7,00,000
-- =============================================================================

INSERT INTO income_entries (user_id, financial_year, entry_date, amount, category, description, client_name, invoice_number, tds_deducted) VALUES
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-04-10', 200000.00, 'consulting', 'Strategy consulting — Q1', 'TechCorp Pvt Ltd',    'INV-2024-001', 20000.00),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-05-15', 150000.00, 'consulting', 'Digital audit project',   'FinServ Ltd',         'INV-2024-002', 15000.00),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-06-20', 180000.00, 'consulting', 'Product roadmap review',  'StartupXYZ',          'INV-2024-003',  0.00),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-07-05', 200000.00, 'consulting', 'Strategy consulting — Q2', 'TechCorp Pvt Ltd',   'INV-2024-004', 20000.00),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-08-12', 120000.00, 'consulting', 'Compliance consulting',   'LegalEase Inc',       'INV-2024-005', 12000.00),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-09-18', 175000.00, 'consulting', 'Market research project',  'DataViz Co',         'INV-2024-006',  0.00),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-10-22', 200000.00, 'consulting', 'Strategy consulting — Q3', 'TechCorp Pvt Ltd',   'INV-2024-007', 20000.00),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-11-08', 100000.00, 'consulting', 'Process optimization',    'ManufactCo',          'INV-2024-008', 10000.00),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-12-15', 150000.00, 'consulting', 'Year-end advisory',       'FinServ Ltd',         'INV-2024-009', 15000.00),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2025-01-20', 125000.00, 'consulting', 'Q4 strategy session',     'StartupXYZ',          'INV-2024-010',  0.00),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2025-02-10', 200000.00, 'consulting', 'Strategy consulting — Q4', 'TechCorp Pvt Ltd',   'INV-2024-011', 20000.00),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2025-03-25', 100000.00, 'interest',   'FD interest income',       NULL,                  NULL,           10000.00);
-- Total professional receipts: ₹14,00,000 | Total TDS: ₹1,42,000

-- =============================================================================
-- SAMPLE EXPENSE ENTRIES for Arjun (FY 2024-25)
-- =============================================================================

INSERT INTO expense_entries (user_id, financial_year, entry_date, amount, category, description, is_tax_deductible, vendor_name) VALUES
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-04-01',  18000.00, 'software_subscription', 'Annual SaaS tools (Notion, Figma, Zoom)', TRUE, 'Various'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-04-01',  24000.00, 'rent',                  'Home office — monthly share',             TRUE, 'Self'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-05-10',  15000.00, 'travel',                'Client visit — Mumbai',                   TRUE, 'Air India'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-06-15',   8000.00, 'training',              'Online course — financial modelling',     TRUE, 'Coursera'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-07-01',  24000.00, 'rent',                  'Home office — monthly share',             TRUE, 'Self'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-08-20',  12000.00, 'marketing',             'LinkedIn Premium + ads',                  TRUE, 'LinkedIn'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-09-05',   6000.00, 'internet',              'Broadband — 6 months',                    TRUE, 'Airtel'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-10-01',  24000.00, 'rent',                  'Home office — monthly share',             TRUE, 'Self'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-11-12',  20000.00, 'travel',                'Client visit — Bangalore + Delhi',        TRUE, 'IndiGo'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2024-12-20',   5000.00, 'office_supplies',       'Stationery and peripherals',              TRUE, 'Amazon'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2025-01-01',  24000.00, 'rent',                  'Home office — monthly share',             TRUE, 'Self'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2025-02-14',  35000.00, 'professional_expense',  'CA fees for tax filing',                  TRUE, 'CA Mehta & Co'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '2025-03-01',  24000.00, 'rent',                  'Home office — monthly share',             TRUE, 'Self');
-- Total deductible expenses: ₹2,39,000

-- =============================================================================
-- SAMPLE DEDUCTIONS (Old Regime declarations) for Arjun
-- =============================================================================

INSERT INTO deductions (user_id, financial_year, section, amount, description) VALUES
('a0000000-0000-0000-0000-000000000001', '2024-25', '80C',     150000.00, 'PPF ₹60,000 + ELSS ₹50,000 + LIC premium ₹40,000'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '80CCD1B',  50000.00, 'NPS Tier 1 additional contribution'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '80D',      25000.00, 'Health insurance — self + spouse + parents'),
('a0000000-0000-0000-0000-000000000001', '2024-25', '80TTA',    10000.00, 'Savings account interest');

-- =============================================================================
-- ADVANCE TAX SCHEDULE for Arjun (FY 2024-25)
-- Based on estimated total tax ~₹1,80,000 (new regime on ₹7L presumptive)
-- Installment amounts calculated at 15/45/75/100% of annual liability
-- =============================================================================

INSERT INTO advance_tax_schedule (user_id, financial_year, installment, due_date, cumulative_percent, estimated_amount, amount_paid, status, paid_on) VALUES
('a0000000-0000-0000-0000-000000000001', '2024-25', 'jun_15', '2024-06-15', 15,  27000.00,  27000.00, 'paid',    '2024-06-12'),
('a0000000-0000-0000-0000-000000000001', '2024-25', 'sep_15', '2024-09-15', 45,  54000.00,  54000.00, 'paid',    '2024-09-10'),
('a0000000-0000-0000-0000-000000000001', '2024-25', 'dec_15', '2024-12-15', 75,  54000.00,  54000.00, 'paid',    '2024-12-14'),
('a0000000-0000-0000-0000-000000000001', '2024-25', 'mar_15', '2025-03-15', 100, 45000.00,   0.00,    'overdue', NULL);
-- Note: mar_15 overdue — triggers notification

-- =============================================================================
-- SAMPLE NOTIFICATIONS for Arjun
-- =============================================================================

INSERT INTO notifications (user_id, type, title, body, metadata, is_read, scheduled_for) VALUES
(
    'a0000000-0000-0000-0000-000000000001',
    'advance_tax_due',
    'Advance Tax Due — March 15',
    'Your final advance tax installment of ₹45,000 was due on March 15. Pay now to avoid interest under Section 234B/234C.',
    '{"installment": "mar_15", "amount": 45000, "due_date": "2025-03-15"}'::jsonb,
    FALSE,
    '2025-03-10 09:00:00+05:30'
),
(
    'a0000000-0000-0000-0000-000000000001',
    'regime_suggestion',
    'New Regime Saves You ₹18,200',
    'Based on your FY 2024-25 income and deductions, the New Regime is more beneficial. Switch now to save ₹18,200.',
    '{"recommended_regime": "new", "saving": 18200}'::jsonb,
    FALSE,
    NULL
),
(
    'a0000000-0000-0000-0000-000000000001',
    'filing_deadline',
    'ITR Filing Deadline — July 31',
    'The last date to file your Income Tax Return for FY 2024-25 (AY 2025-26) is July 31, 2025.',
    '{"deadline": "2025-07-31", "ay": "2025-26"}'::jsonb,
    FALSE,
    '2025-07-01 09:00:00+05:30'
);

-- =============================================================================
-- INITIAL TAX ESTIMATE SNAPSHOT for Arjun
-- New regime: presumptive income ₹7L, standard deduction ₹75K → taxable ₹6.25L
-- Old regime: gross ₹14L, deductions ₹2.35L, expenses ₹2.39L → taxable ~₹9.26L
-- =============================================================================

INSERT INTO tax_estimates (
    user_id, financial_year,
    gross_income, total_deductible_expenses, net_income,
    is_44ada_eligible, presumptive_income_44ada,
    total_deductions_old, taxable_income_old, tax_old_regime, surcharge_old, cess_old, total_tax_old,
    standard_deduction_new, taxable_income_new, tax_new_regime, surcharge_new, cess_new, total_tax_new,
    recommended_regime, tax_saving_by_switching,
    total_tds_paid, advance_tax_paid, net_tax_payable
) VALUES (
    'a0000000-0000-0000-0000-000000000001', '2024-25',
    1500000.00,     -- ₹15L gross (14L consulting + 1L FD interest) -- corrected: 14L consulting receipts + 1L FD interest
    239000.00,      -- ₹2.39L deductible expenses
    1261000.00,     -- net income
    TRUE,           -- 44ADA eligible (consultant, receipts < ₹75L)
    700000.00,      -- 50% of ₹14L professional receipts

    -- Old regime (net income ₹12.61L – deductions ₹2.35L = ₹10.26L taxable)
    235000.00,
    1026000.00,
    157200.00,      -- old regime tax on ₹10.26L
    0.00,
    6288.00,        -- 4% cess
    163488.00,

    -- New regime (presumptive ₹7L – std deduction ₹75K = ₹6.25L taxable)
    75000.00,
    625000.00,
    17500.00,       -- 5% on (6.25L - 3L) = 3.25L → ₹16,250; marginal relief adjusts ~ ₹17,500
    0.00,
    700.00,         -- 4% cess
    18200.00,

    'new',          -- new regime recommended
    145288.00,      -- saves ₹1,45,288 by switching to new regime

    142000.00,      -- TDS already deducted
    135000.00,      -- advance tax paid (3 of 4 installments)
    -- net payable under new regime: 18,200 - 1,42,000 TDS = refund
    -- but stored as 0 (refund case shown separately)
    0.00
);
