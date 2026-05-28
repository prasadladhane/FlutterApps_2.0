import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class EmptyDashboardState extends StatelessWidget {

  final VoidCallback? onAddIncome;
  final VoidCallback? onUploadBills;

  const EmptyDashboardState({
    super.key,
    this.onAddIncome,
    this.onUploadBills,
  });

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),

        padding: const EdgeInsets.all(36),

        decoration: BoxDecoration(
          color: AppColors.cardBackground,

          borderRadius: BorderRadius.circular(32),

          border: Border.all(
            color: AppColors.border,
          ),

          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 14,
              offset: Offset(0, 8),
            ),
          ],
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// ICON CONTAINER
            Container(
              width: 110,
              height: 110,

              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),

              child: const Center(
                child: Icon(
                  Icons.dashboard_customize_rounded,
                  size: 52,
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// TITLE
            Text(
              'Your Dashboard Is Empty',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading3,
            ),

            const SizedBox(height: 14),

            /// SUBTITLE
            Text(
              'Start managing your finances by adding income, '
              'tracking expenses or uploading invoices to '
              'unlock smart AI insights and analytics.',
              textAlign: TextAlign.center,

              style: AppTextStyles.bodySmall.copyWith(
                height: 1.7,
              ),
            ),

            const SizedBox(height: 34),

            /// ACTION BUTTONS
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [

                /// ADD INCOME
                _primaryButton(
                  title: 'Add Income',
                  icon: Icons.add_chart_rounded,
                  onTap: onAddIncome,
                ),

                /// UPLOAD BILLS
                _secondaryButton(
                  title: 'Upload Bills',
                  icon: Icons.upload_file_rounded,
                  onTap: onUploadBills,
                ),
              ],
            ),

            const SizedBox(height: 34),

            /// FEATURE HIGHLIGHTS
            Wrap(
              spacing: 14,
              runSpacing: 14,
              alignment: WrapAlignment.center,
              children: [

                _featureChip(
                  icon: Icons.auto_awesome,
                  title: 'AI Insights',
                ),

                _featureChip(
                  icon: Icons.analytics_outlined,
                  title: 'Smart Analytics',
                ),

                _featureChip(
                  icon: Icons.receipt_long_outlined,
                  title: 'Tax Tracking',
                ),

                _featureChip(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Expense Manager',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // PRIMARY BUTTON
  // =========================================================

  Widget _primaryButton({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
  }) {

    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 16,
        ),

        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(18),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),

            const SizedBox(width: 10),

            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // SECONDARY BUTTON
  // =========================================================

  Widget _secondaryButton({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
  }) {

    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 16,
        ),

        decoration: BoxDecoration(
          color: AppColors.secondaryCardBackground,

          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: AppColors.border,
          ),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Icon(
              icon,
              color: AppColors.primary,
              size: 22,
            ),

            const SizedBox(width: 10),

            Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // FEATURE CHIP
  // =========================================================

  Widget _featureChip({
    required IconData icon,
    required String title,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),

      decoration: BoxDecoration(
        color: AppColors.secondaryCardBackground,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            color: AppColors.primary,
            size: 18,
          ),

          const SizedBox(width: 8),

          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}