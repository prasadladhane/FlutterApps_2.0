import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DashboardSectionTitle extends StatelessWidget {

  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onActionTap;

  const DashboardSectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// LEFT SECTION
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TITLE
              Text(
                title,
                style: AppTextStyles.heading3,
              ),

              /// SUBTITLE
              if (subtitle != null) ...[

                const SizedBox(height: 6),

                Text(
                  subtitle!,
                  style: AppTextStyles.bodySmall.copyWith(
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),

        /// ACTION BUTTON
        if (actionText != null)
          GestureDetector(
            onTap: onActionTap,

            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),

                borderRadius: BorderRadius.circular(14),

                border: Border.all(
                  color: AppColors.primary.withOpacity(0.25),
                ),
              ),

              child: Row(
                children: [

                  Text(
                    actionText!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 6),

                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}