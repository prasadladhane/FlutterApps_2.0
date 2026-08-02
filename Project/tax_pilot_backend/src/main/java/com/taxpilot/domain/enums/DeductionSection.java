package com.taxpilot.domain.enums;

public enum DeductionSection {
    _80C,
    _80CCD1B,
    _80D,
    _80E,
    _80G,
    _80TTA,
    _80TTB,
    _24B,
    HRA,
    LTA,
    standard_deduction,
    other;

    // PostgreSQL stores as '80C', '80D' etc.
    // Converter maps _80C <-> 80C
    public String toDbValue() {
        if (this.name().startsWith("_")) {
            return this.name().substring(1);
        }
        return this.name();
    }

    public static DeductionSection fromDbValue(String value) {
        if (value == null) return null;
        try {
            return DeductionSection.valueOf("_" + value);
        } catch (IllegalArgumentException e) {
            return DeductionSection.valueOf(value);
        }
    }
}
