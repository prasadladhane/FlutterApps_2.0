import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../dashboard/presentation/widgets/dashboard_container.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_title.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,

        onPressed: () {},

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// PAGE HEADER
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [

                  /// LEFT SIDE
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Expense Manager',
                        style:
                            AppTextStyles.heading2,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Track and manage your spending '
                        'efficiently with AI-powered insights.',
                        style:
                            AppTextStyles.bodySmall,
                      ),
                    ],
                  ),

                  /// FILTER BUTTON
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),

                    decoration: BoxDecoration(
                      color:
                          AppColors.cardBackground,

                      borderRadius:
                          BorderRadius.circular(18),

                      border: Border.all(
                        color: AppColors.border,
                      ),
                    ),

                    child: Row(
                      children: [

                        const Icon(
                          Icons.filter_alt_outlined,
                          color: AppColors.primary,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          'Filters',
                          style:
                              AppTextStyles.bodySmall
                                  .copyWith(
                            color:
                                AppColors.primary,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              /// EXPENSE OVERVIEW
              DashboardSectionTitle(
                title: 'Expense Overview',
                subtitle:
                    'Monitor your monthly spending analytics.',
              ),

              const SizedBox(height: 24),

              /// ANALYTICS CARDS
              Row(
                children: [

                  Expanded(
                    child: _analyticsCard(
                      title: 'Total Expenses',
                      value: '₹35,000',
                      growth: '+12%',
                      icon:
                          Icons.account_balance_wallet,
                      iconColor:
                          AppColors.chartOrange,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: _analyticsCard(
                      title: 'Tax Deductible',
                      value: '₹8,500',
                      growth: '+4%',
                      icon:
                          Icons.receipt_long_outlined,
                      iconColor:
                          AppColors.taxHighlight,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: _analyticsCard(
                      title: 'Pending Bills',
                      value: '6',
                      growth: '+2',
                      icon:
                          Icons.pending_actions_rounded,
                      iconColor:
                          AppColors.warning,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              /// RECENT EXPENSES
              DashboardSectionTitle(
                title: 'Recent Expenses',
                subtitle:
                    'Latest tracked financial expenses.',
                actionText: 'View All',
                onActionTap: () {},
              ),

              const SizedBox(height: 24),

              /// EXPENSE LIST
              Column(
                children: [

                  _expenseTile(
                    title: 'Adobe Subscription',
                    category: 'Software',
                    amount: '- ₹2,499',
                    date: 'Today',
                    icon: Icons.design_services_outlined,
                    iconColor: AppColors.primary,
                  ),

                  const SizedBox(height: 18),

                  _expenseTile(
                    title: 'Internet Bill',
                    category: 'Utilities',
                    amount: '- ₹1,200',
                    date: 'Yesterday',
                    icon: Icons.wifi_rounded,
                    iconColor: AppColors.chartBlue,
                  ),

                  const SizedBox(height: 18),

                  _expenseTile(
                    title: 'Laptop Repair',
                    category: 'Hardware',
                    amount: '- ₹4,500',
                    date: '2 days ago',
                    icon: Icons.laptop_mac_rounded,
                    iconColor: AppColors.chartOrange,
                  ),

                  const SizedBox(height: 18),

                  _expenseTile(
                    title: 'Office Rent',
                    category: 'Workspace',
                    amount: '- ₹12,000',
                    date: 'This Week',
                    icon: Icons.home_work_outlined,
                    iconColor: AppColors.chartPurple,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // ANALYTICS CARD
  // =========================================================

  Widget _analyticsCard({
    required String title,
    required String value,
    required String growth,
    required IconData icon,
    required Color iconColor,
  }) {

    return DashboardContainer(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [

              Container(
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color:
                      iconColor.withOpacity(0.12),

                  borderRadius:
                      BorderRadius.circular(18),
                ),

                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),

              Text(
                growth,
                style:
                    AppTextStyles.bodySmall.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Text(
            value,
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // EXPENSE TILE
  // =========================================================

  Widget _expenseTile({
    required String title,
    required String category,
    required String amount,
    required String date,
    required IconData icon,
    required Color iconColor,
  }) {

    return DashboardContainer(
      child: Row(
        children: [

          /// ICON
          Container(
            width: 58,
            height: 58,

            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),

              borderRadius:
                  BorderRadius.circular(18),
            ),

            child: Icon(
              icon,
              color: iconColor,
            ),
          ),

          const SizedBox(width: 18),

          /// TEXT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style:
                      AppTextStyles.cardTitle,
                ),

                const SizedBox(height: 6),

                Text(
                  category,
                  style:
                      AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),

          /// RIGHT SIDE
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [

              Text(
                amount,
                style:
                    AppTextStyles.bodyMedium
                        .copyWith(
                  color: AppColors.error,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                date,
                style:
                    AppTextStyles.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}