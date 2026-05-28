import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

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

              /// SMALL TITLE
              Text(
                'Welcome Back 👋',
                style: AppTextStyles.bodySmall,
              ),

              const SizedBox(height: 8),

              /// MAIN TITLE
              Text(
                'Financial Dashboard',
                style: AppTextStyles.heading2,
              ),

              const SizedBox(height: 10),

              /// SUBTITLE
              Text(
                'Monitor your finances, taxes, '
                'expenses and AI insights in one place.',
                style: AppTextStyles.bodySmall.copyWith(
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 20),

        /// RIGHT SECTION
        Row(
          children: [

            /// SEARCH BUTTON
            _headerActionButton(
              icon: Icons.search_rounded,
            ),

            const SizedBox(width: 14),

            /// NOTIFICATION BUTTON
            Stack(
              children: [

                _headerActionButton(
                  icon: Icons.notifications_none_rounded,
                ),

                /// NOTIFICATION DOT
                Positioned(
                  right: 8,
                  top: 8,

                  child: Container(
                    width: 10,
                    height: 10,

                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 14),

            /// PROFILE
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(18),

                border: Border.all(
                  color: AppColors.border,
                ),
              ),

              child: Row(
                children: [

                  /// AVATAR
                  Container(
                    width: 42,
                    height: 42,

                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),

                    child: const Center(
                      child: Icon(
                        Icons.person,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// USER INFO
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Prasad',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        'Premium User',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // =========================================================
  // HEADER ACTION BUTTON
  // =========================================================

  Widget _headerActionButton({
    required IconData icon,
  }) {

    return Container(
      width: 52,
      height: 52,

      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Icon(
        icon,
        color: AppColors.primaryText,
      ),
    );
  }
}