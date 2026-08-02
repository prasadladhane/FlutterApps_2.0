package com.taxpilot.domain.enums;

public enum TaxRegime {
    new_regime, old_regime;

    // PostgreSQL stores as 'new' / 'old' — converter handles mapping
}
