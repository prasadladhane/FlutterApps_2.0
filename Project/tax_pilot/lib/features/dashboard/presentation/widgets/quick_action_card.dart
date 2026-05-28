import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class QuickActionCard extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        padding: const EdgeInsets.all(22),

        decoration: BoxDecoration(
          color: AppColors.cardBackground,

          borderRadius: BorderRadius.circular(24),

          border: Border.all(
            color: AppColors.border,
          ),

          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TOP ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// ICON CONTAINER
                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.12),

                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 28,
                  ),
                ),

                /// ARROW ICON
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.secondaryText,
                ),
              ],
            ),

            const Spacer(),

            /// TITLE
            Text(
              title,
              style: AppTextStyles.cardTitle,
            ),

            const SizedBox(height: 8),

            /// SUBTITLE
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}