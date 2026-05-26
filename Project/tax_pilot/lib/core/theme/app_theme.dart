// import 'package:flutter/material.dart';

// import '../constants/app_colors.dart';
// import '../constants/app_text_styles.dart';

// class AppTheme {
//   AppTheme._();

//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,

//     brightness: Brightness.dark,

//     scaffoldBackgroundColor: AppColors.scaffoldBackground,

//     primaryColor: AppColors.primary,

//     fontFamily: 'Inter',

//     splashColor: Colors.transparent,

//     highlightColor: Colors.transparent,

//     hoverColor: Colors.transparent,

//     dividerColor: AppColors.divider,

//     colorScheme: const ColorScheme.dark(
//       primary: AppColors.primary,
//       secondary: AppColors.primaryLight,
//       surface: AppColors.cardBackground,
//       error: AppColors.error,
//     ),

//     appBarTheme: const AppBarTheme(
//       backgroundColor: AppColors.scaffoldBackground,
//       elevation: 0,
//       centerTitle: false,
//       iconTheme: IconThemeData(
//         color: AppColors.whiteText,
//       ),
//     ),

//     cardTheme: CardThemeData(
//       color: AppColors.cardBackground,
//       elevation: 0,
//       shadowColor: AppColors.shadow,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(18),
//         side: const BorderSide(
//           color: AppColors.border,
//           width: 1,
//         ),
//       ),
//     ),

//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: AppColors.textFieldFill,

//       contentPadding: const EdgeInsets.symmetric(
//         horizontal: 18,
//         vertical: 18,
//       ),

//       hintStyle: AppTextStyles.textFieldHint,

//       labelStyle: AppTextStyles.textFieldLabel,

//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(
//           color: AppColors.textFieldBorder,
//           width: 1,
//         ),
//       ),

//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(
//           color: AppColors.textFieldBorder,
//           width: 1,
//         ),
//       ),

//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(
//           color: AppColors.focusedBorder,
//           width: 1.4,
//         ),
//       ),

//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(
//           color: AppColors.error,
//           width: 1,
//         ),
//       ),

//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(14),
//         borderSide: const BorderSide(
//           color: AppColors.error,
//           width: 1.2,
//         ),
//       ),
//     ),

//     textTheme: TextTheme(
//       displayLarge: AppTextStyles.displayLarge,
//       displayMedium: AppTextStyles.displayMedium,

//       headlineLarge: AppTextStyles.heading1,
//       headlineMedium: AppTextStyles.heading2,
//       headlineSmall: AppTextStyles.heading3,

//       bodyLarge: AppTextStyles.bodyLarge,
//       bodyMedium: AppTextStyles.bodyMedium,
//       bodySmall: AppTextStyles.bodySmall,
//     ),

//     iconTheme: const IconThemeData(
//       color: AppColors.secondaryText,
//       size: 22,
//     ),

//     scrollbarTheme: ScrollbarThemeData(
//       thumbColor: WidgetStateProperty.all(
//         AppColors.secondaryCardBackground,
//       ),
//       radius: const Radius.circular(10),
//     ),
//   );
// }


import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,

    scaffoldBackgroundColor:
        AppColors.scaffoldBackground,

    primaryColor: AppColors.primary,

    fontFamily: 'Inter',

    splashColor: Colors.transparent,

    highlightColor: Colors.transparent,

    hoverColor: Colors.transparent,

    dividerColor: AppColors.divider,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      surface: AppColors.cardBackground,
      error: AppColors.error,
    ),

    // =====================================================
    // APP BAR
    // =====================================================

    appBarTheme: const AppBarTheme(
      backgroundColor:
          AppColors.scaffoldBackground,

      elevation: 0,

      scrolledUnderElevation: 0,

      centerTitle: false,

      iconTheme: IconThemeData(
        color: AppColors.whiteText,
      ),
    ),

    // =====================================================
    // CARD THEME
    // =====================================================

    cardTheme: CardThemeData(
      color: AppColors.cardBackground,

      elevation: 0,

      shadowColor: AppColors.shadow,

      margin: EdgeInsets.zero,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),

        side: const BorderSide(
          color: AppColors.border,
          width: 1,
        ),
      ),
    ),

    // =====================================================
    // INPUT FIELD THEME
    // =====================================================

    inputDecorationTheme: InputDecorationTheme(
      filled: true,

      fillColor: AppColors.textFieldFill,

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      hintStyle:
          AppTextStyles.textFieldHint,

      labelStyle:
          AppTextStyles.textFieldLabel,

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),

        borderSide: const BorderSide(
          color: AppColors.textFieldBorder,
          width: 1,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),

        borderSide: const BorderSide(
          color: AppColors.textFieldBorder,
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),

        borderSide: const BorderSide(
          color: AppColors.focusedBorder,
          width: 1.2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),

        borderSide: const BorderSide(
          color: AppColors.error,
          width: 1,
        ),
      ),

      focusedErrorBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),

        borderSide: const BorderSide(
          color: AppColors.error,
          width: 1.2,
        ),
      ),
    ),

    // =====================================================
    // TEXT THEME
    // =====================================================

    textTheme: TextTheme(
      displayLarge:
          AppTextStyles.displayLarge,

      displayMedium:
          AppTextStyles.displayMedium,

      headlineLarge:
          AppTextStyles.heading1,

      headlineMedium:
          AppTextStyles.heading2,

      headlineSmall:
          AppTextStyles.heading3,

      bodyLarge:
          AppTextStyles.bodyLarge,

      bodyMedium:
          AppTextStyles.bodyMedium,

      bodySmall:
          AppTextStyles.bodySmall,
    ),

    // =====================================================
    // ICONS
    // =====================================================

    iconTheme: const IconThemeData(
      color: AppColors.secondaryText,
      size: 20,
    ),

    // =====================================================
    // DIVIDERS
    // =====================================================

    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    // =====================================================
    // SCROLLBAR
    // =====================================================

    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(
        AppColors.secondaryCardBackground,
      ),

      radius: const Radius.circular(8),

      thickness:
          WidgetStateProperty.all(6),
    ),
  );
}