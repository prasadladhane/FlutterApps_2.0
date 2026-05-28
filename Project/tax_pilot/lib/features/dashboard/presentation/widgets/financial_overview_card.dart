import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'balance_info_item.dart';
import 'dashboard_container.dart';

class FinancialOverviewCard extends StatelessWidget {
  const FinancialOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {

    return DashboardContainer(
      padding: const EdgeInsets.all(28),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TOP SECTION
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              /// LEFT CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// TITLE
                    Text(
                      'Financial Overview',
                      style: AppTextStyles.heading3,
                    ),

                    const SizedBox(height: 8),

                    /// SUBTITLE
                    Text(
                      'Track your financial performance, '
                      'income, expenses and tax insights.',
                      style: AppTextStyles.bodySmall.copyWith(
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              /// MONTH SELECTOR
              Container(
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
                  children: [

                    Text(
                      'This Month',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(width: 8),

                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.secondaryText,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          /// TOTAL BALANCE CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),

            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primaryDark,
                ],

                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),

              borderRadius: BorderRadius.circular(28),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// LABEL
                Text(
                  'Total Balance',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 12),

                /// BALANCE
                Text(
                  '₹2,45,000',
                  style: AppTextStyles.heading1.copyWith(
                    color: Colors.white,
                    fontSize: 38,
                  ),
                ),

                const SizedBox(height: 14),

                /// STATUS
                Row(
                  children: [

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),

                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Row(
                        children: [

                          const Icon(
                            Icons.trending_up_rounded,
                            color: Colors.white,
                            size: 18,
                          ),

                          const SizedBox(width: 6),

                          Text(
                            '+18.4%',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    Text(
                      'Compared to last month',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),

          /// SUMMARY ITEMS
          Row(
            children: [

              Expanded(
                child: BalanceInfoItem(
                  title: 'Income',
                  amount: '₹85,000',
                  icon: Icons.trending_up_rounded,
                  iconColor: AppColors.chartGreen,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: BalanceInfoItem(
                  title: 'Expenses',
                  amount: '₹35,000',
                  icon: Icons.account_balance_wallet_outlined,
                  iconColor: AppColors.chartOrange,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: BalanceInfoItem(
                  title: 'Estimated Tax',
                  amount: '₹12,000',
                  icon: Icons.receipt_long_outlined,
                  iconColor: AppColors.taxHighlight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}