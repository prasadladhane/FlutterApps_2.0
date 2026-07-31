# TaxPilot — Database Layer

PostgreSQL schema, seed data, and tax calculation logic for FY 2024-25.

---

## File Structure

```
database/
├── 01_schema.sql      # Tables, enums, indexes, triggers
├── 02_seed.sql        # Reference data + sample user
├── 03_tax_queries.sql # Tax functions, regime comparison, advance tax
└── README.md          # This file
```

---

## Prerequisites

- PostgreSQL 14+
- `uuid-ossp` and `pgcrypto` extensions (both in `01_schema.sql` via `CREATE EXTENSION IF NOT EXISTS`)
- A database created and ready (see setup below)

---

## Setup

### 1. Create the database

```sql
CREATE DATABASE tax_pilot;
```

### 2. Run the files in order

```bash
psql -U <your_user> -d tax_pilot -f database/01_schema.sql
psql -U <your_user> -d tax_pilot -f database/02_seed.sql
psql -U <your_user> -d tax_pilot -f database/03_tax_queries.sql
```

Or from inside `psql`:

```sql
\c tax_pilot
\i database/01_schema.sql
\i database/02_seed.sql
\i database/03_tax_queries.sql
```

### 3. Verify the setup

```sql
-- Check tables were created
\dt

-- Run a quick sanity check on the slab tax function
SELECT
    calculate_slab_tax(625000, 'new', '2024-25', 'individual') AS new_slab_tax,
    calculate_slab_tax(1026000, 'old', '2024-25', 'individual') AS old_slab_tax;
-- Expected: 16250.00 | 157200.00

-- Full dual-regime compute for the sample user
SELECT * FROM compute_tax_for_user('a0000000-0000-0000-0000-000000000001', '2024-25');

-- Regime recommendation
SELECT * FROM compare_regimes('a0000000-0000-0000-0000-000000000001', '2024-25');
```

---

## Schema Overview

### Core Tables (9)

| Table | Purpose |
|---|---|
| `users` | User profile, profession type, preferred regime |
| `income_entries` | Individual income transactions with TDS |
| `expense_entries` | Business/professional expenses |
| `deductions` | User-declared Chapter VI-A deductions (80C, 80D, etc.) |
| `tax_estimates` | Computed tax snapshot, both regimes, auto-refreshed |
| `advance_tax_schedule` | Quarterly installments (Jun/Sep/Dec/Mar) |
| `ai_chat_history` | Gemini AI conversation log per session |
| `notifications` | Push/in-app notifications with scheduling |
| `reports` | Generated PDF reports with JSONB data snapshot |

### Reference Tables (3)

| Table | Purpose |
|---|---|
| `tax_slabs` | Slab rates per regime, FY, taxpayer type — no hardcoding in app |
| `surcharge_rates` | Surcharge brackets per regime and FY |
| `deduction_limits` | Max allowable amount per section per FY |

---

## Tax Logic Overview

### Functions in `03_tax_queries.sql`

| Function | What it does |
|---|---|
| `calculate_slab_tax(income, regime, fy, type)` | Applies progressive slab rates, returns base tax |
| `calculate_surcharge(income, tax, regime, fy)` | Looks up surcharge rate from reference table |
| `apply_87a_rebate(income, tax, regime)` | Applies Section 87A rebate (₹25K new / ₹12.5K old) |
| `compute_tax_for_user(user_id, fy)` | Full computation, returns one row per regime with all breakdowns |
| `compare_regimes(user_id, fy)` | Picks the better regime, returns saving and recommendation text |
| `calculate_advance_tax_schedule(user_id, fy)` | Calculates installment amounts and upserts into `advance_tax_schedule` |
| `refresh_tax_estimate(user_id, fy)` | Upserts `tax_estimates` row with latest computed values |
| `get_monthly_income_breakdown(user_id, fy)` | Monthly aggregation for the dashboard chart |
| `check_44ada_eligibility(user_id, fy)` | 44ADA check with reasoning text |
| `get_dashboard_summary(user_id, fy)` | Single-call summary for the Flutter home screen |

### Triggers

| Trigger | Fires on | Action |
|---|---|---|
| `trg_income_refresh` | INSERT/UPDATE/DELETE on `income_entries` | Calls `refresh_tax_estimate` |
| `trg_expense_refresh` | INSERT/UPDATE/DELETE on `expense_entries` | Calls `refresh_tax_estimate` |
| `trg_deduction_refresh` | INSERT/UPDATE/DELETE on `deductions` | Calls `refresh_tax_estimate` |
| `set_updated_at_*` | UPDATE on most tables | Sets `updated_at = NOW()` |
| `check_advance_tax_overdue` | INSERT/UPDATE on `advance_tax_schedule` | Auto-sets status to `overdue` if past due date |

---

## Key Business Rules Encoded

### Section 44ADA (Presumptive Taxation)
- Applies to: `consultant`, `professional_44ADA` profession types
- Condition: professional receipts ≤ ₹75,00,000 in the FY
- Income declared: 50% of qualifying receipts
- Benefit: no need to maintain books of accounts

### New Regime (FY 2024-25, Budget 2024)
- Standard deduction: ₹75,000 (up from ₹50,000)
- Rebate u/s 87A: up to ₹25,000 for taxable income ≤ ₹7,00,000
- No Chapter VI-A deductions allowed (except employer NPS 80CCD2)
- Surcharge capped at 25% (no 37% bracket)

### Old Regime
- Standard deduction: ₹50,000
- Rebate u/s 87A: up to ₹12,500 for taxable income ≤ ₹5,00,000
- All Chapter VI-A deductions available (80C max ₹1.5L, 80D ₹25K, etc.)
- Surcharge goes up to 37% for income > ₹5Cr

### Advance Tax
- Applies only when annual tax liability > ₹10,000
- Schedule: 15% by Jun 15 | 45% by Sep 15 | 75% by Dec 15 | 100% by Mar 15
- Interest under 234B/234C applies for shortfall or delay
- `calculate_advance_tax_schedule()` recalculates amounts when tax estimate changes

### Health & Education Cess
- 4% on (tax + surcharge) — applied in all computations

---

## Sample Data

The seed file includes a fully populated sample user:

- **Name:** Arjun Sharma
- **Profession:** Consultant (44ADA eligible)
- **FY 2024-25 receipts:** ₹14,00,000 (12 invoices across 4 clients)
- **TDS deducted:** ₹1,42,000
- **Deductions declared:** ₹2,35,000 (80C + 80CCD1B + 80D + 80TTA)
- **Advance tax:** 3 of 4 installments paid; March installment overdue
- **Result:** New regime saves ~₹1,45,288 vs old regime

To reset the sample data:

```sql
DELETE FROM users WHERE id = 'a0000000-0000-0000-0000-000000000001';
-- Cascades to all related tables via ON DELETE CASCADE
```

---

## Adding a New Financial Year

1. Insert new rows into `tax_slabs` for the new FY
2. Insert new rows into `surcharge_rates` for the new FY
3. Update `deduction_limits` if limits changed
4. Update `users.financial_year` or add a new user row per FY as needed

No application code changes required — all logic reads from reference tables.

---

## Integration Notes for Java Spring Boot (Phase 3)

- Call `compute_tax_for_user(user_id, fy)` via JPA native query or JDBC to get tax breakdown
- Call `compare_regimes(user_id, fy)` for the regime recommendation card
- Call `get_dashboard_summary(user_id, fy)` for the home screen — one round trip
- `refresh_tax_estimate` fires automatically via triggers; no need to call it from the API layer
- `calculate_advance_tax_schedule` should be called once after onboarding and after each significant income change
- Store `firebase_uid` in `users` table; look up `users.id` (UUID) once at login and use it for all subsequent queries
