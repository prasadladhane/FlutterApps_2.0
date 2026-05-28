import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class AIInsightCard extends StatelessWidget {
  const AIInsightCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),

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
            children: [

              /// AI ICON
              Container(
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: const Icon(
                  Icons.auto_awesome,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),

              const SizedBox(width: 16),

              /// TITLE + SUBTITLE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'AI Financial Insight',
                      style: AppTextStyles.cardTitle,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Smart recommendations powered by TaxPilot AI',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),

              /// REFRESH BUTTON
              Container(
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: AppColors.secondaryCardBackground,
                  borderRadius: BorderRadius.circular(14),
                ),

                child: const Icon(
                  Icons.refresh_rounded,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// INSIGHT CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: AppColors.secondaryCardBackground,
              borderRadius: BorderRadius.circular(20),

              border: Border.all(
                color: AppColors.divider,
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// INSIGHT TAG
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.taxHighlight.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Text(
                    'Tax Optimization',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.taxHighlight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                /// MAIN INSIGHT
                Text(
                  'Your expenses increased by 12% this month. '
                  'You may reduce taxable income by investing '
                  'under Section 80C before March.',
                  style: AppTextStyles.bodyMedium,
                ),

                const SizedBox(height: 20),

                /// ACTION BUTTONS
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [

                    _actionButton(
                      title: 'View Tax Report',
                      icon: Icons.analytics_outlined,
                    ),

                    _actionButton(
                      title: 'Ask AI',
                      icon: Icons.chat_bubble_outline_rounded,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ACTION BUTTON
  // =========================================================

  Widget _actionButton({
    required String title,
    required IconData icon,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),

      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: AppColors.primary.withOpacity(0.25),
        ),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            size: 18,
            color: AppColors.primary,
          ),

          const SizedBox(width: 10),

          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}