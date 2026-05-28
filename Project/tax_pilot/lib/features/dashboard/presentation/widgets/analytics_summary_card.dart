import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class AnalyticsSummaryCard extends StatelessWidget {

  final String title;
  final String value;
  final String growth;
  final IconData icon;
  final Color iconColor;

  const AnalyticsSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.growth,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
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
            blurRadius: 12,
            offset: Offset(0, 6),
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

              /// ICON
              Container(
                padding: const EdgeInsets.all(14),

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

              /// GROWTH BADGE
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(30),
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.trending_up_rounded,
                      size: 16,
                      color: AppColors.success,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      growth,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// VALUE
          Text(
            value,
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: 8),

          /// TITLE
          Text(
            title,
            style: AppTextStyles.bodySmall,
          ),

          const SizedBox(height: 20),

          /// MINI PROGRESS BAR
          ClipRRect(
            borderRadius: BorderRadius.circular(20),

            child: LinearProgressIndicator(
              value: 0.72,
              minHeight: 7,

              backgroundColor: AppColors.secondaryCardBackground,

              valueColor: AlwaysStoppedAnimation(
                iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}