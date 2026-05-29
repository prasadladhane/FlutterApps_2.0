import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../dashboard/presentation/widgets/analytics_summary_card.dart';
import '../../../dashboard/presentation/widgets/dashboard_container.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_title.dart';

class FinanceOverviewPage extends StatelessWidget {
  const FinanceOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Wrap(
                alignment:
                    WrapAlignment.spaceBetween,
                children: [

                  /// LEFT CONTENT
                  SizedBox(
                    width:500,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                    
                        Text(
                          'Finance Overview',
                          style:
                              AppTextStyles.heading2,
                        ),
                    
                        const SizedBox(height: 8),
                    
                        Text(
                          'Complete overview of your financial health and analytics.',
                          style:
                              AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),

                  /// DATE FILTER
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
                          Icons.calendar_today_rounded,
                          size: 18,
                          color:
                              AppColors.primary,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          'This Month',
                          style:
                              AppTextStyles.bodySmall
                                  .copyWith(
                            color:
                                AppColors.primaryText,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              /// TOTAL BALANCE CARD
              DashboardContainer(
                padding: const EdgeInsets.all(30),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Total Financial Balance',
                      style:
                          AppTextStyles.bodySmall,
                    ),

                    const SizedBox(height: 14),

                    Text(
                      '₹2,45,000',
                      style:
                          AppTextStyles.heading3,
                    ),

                    const SizedBox(height: 18),

                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),

                          decoration: BoxDecoration(
                            color:
                                AppColors.success
                                    .withOpacity(
                                        0.12),

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        30),
                          ),

                          child: Row(
                            children: [

                              const Icon(
                                Icons
                                    .trending_up_rounded,
                                color:
                                    AppColors
                                        .success,
                                size: 18,
                              ),

                              const SizedBox(
                                  width: 6),

                              Text(
                                '+18.4%',
                                style:
                                    AppTextStyles
                                        .bodySmall
                                        .copyWith(
                                  color:
                                      AppColors
                                          .success,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        Text(
                          'Compared to previous month',
                          style:
                              AppTextStyles
                                  .bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// ANALYTICS SECTION
              DashboardSectionTitle(
                title: 'Financial Analytics',
                subtitle:
                    'Track your core financial metrics and performance.',
              ),

              const SizedBox(height: 24),

              /// ANALYTICS GRID
              LayoutBuilder(
                builder: (context, constraints) {

                 int crossAxisCount = 1;
                if (constraints.maxWidth > 1400) {
                  crossAxisCount = 4;
                } else if (constraints.maxWidth > 900) {
                  crossAxisCount = 3;
                } else if (constraints.maxWidth > 650) {
                  crossAxisCount = 2;
                }
                  return GridView.count(
                    shrinkWrap: true,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    crossAxisCount:
                        crossAxisCount,

                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,

                    childAspectRatio: 1.3,

                    children: [

                      AnalyticsSummaryCard(
                        title:
                            'Monthly Income',
                        value: '₹85,000',
                        growth: '+12%',
                        icon: Icons
                            .trending_up_rounded,
                        iconColor:
                            AppColors
                                .chartGreen,
                      ),

                      AnalyticsSummaryCard(
                        title:
                            'Monthly Expenses',
                        value: '₹35,000',
                        growth: '+8%',
                        icon: Icons
                            .account_balance_wallet_outlined,
                        iconColor:
                            AppColors
                                .chartOrange,
                      ),

                      AnalyticsSummaryCard(
                        title:
                            'Estimated Tax',
                        value: '₹12,000',
                        growth: '+5%',
                        icon: Icons
                            .receipt_long_outlined,
                        iconColor:
                            AppColors
                                .taxHighlight,
                      ),

                      AnalyticsSummaryCard(
                        title:
                            'Savings',
                        value: '₹38,000',
                        growth: '+21%',
                        icon: Icons
                            .savings_outlined,
                        iconColor:
                            AppColors
                                .chartPurple,
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 36),

              /// FINANCIAL INSIGHTS
              DashboardSectionTitle(
                title: 'AI Financial Insights',
                subtitle:
                    'AI-powered analysis of your financial activities.',
              ),

              const SizedBox(height: 24),

              DashboardContainer(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Container(
                          padding:
                              const EdgeInsets.all(
                                  14),

                          decoration: BoxDecoration(
                            color: AppColors
                                .primary
                                .withOpacity(
                                    0.12),

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        18),
                          ),

                          child: const Icon(
                            Icons.auto_awesome,
                            color:
                                AppColors.primary,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [

                              Text(
                                'AI Recommendation',
                                style:
                                    AppTextStyles
                                        .cardTitle,
                              ),

                              const SizedBox(
                                  height: 6),

                              Text(
                                'Your business expenses increased by 14%. '
                                'You may qualify for additional tax deductions.',
                                style:
                                    AppTextStyles
                                        .bodySmall
                                        .copyWith(
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// RECENT FINANCIAL ACTIVITY
              DashboardSectionTitle(
                title:
                    'Recent Financial Activity',
                subtitle:
                    'Latest updates from your financial ecosystem.',
                actionText: 'View All',
                onActionTap: () {},
              ),

              const SizedBox(height: 24),

              Column(
                children: [

                  _activityTile(
                    title:
                        'Freelance Payment Received',
                    subtitle:
                        'Payment successfully added to income records.',
                    amount: '+ ₹15,000',
                    amountColor:
                        AppColors.success,
                    icon:
                        Icons.payments_outlined,
                    iconColor:
                        AppColors.chartGreen,
                  ),

                  const SizedBox(height: 18),

                  _activityTile(
                    title:
                        'Expense Added',
                    subtitle:
                        'Workspace subscription recorded.',
                    amount: '- ₹2,499',
                    amountColor:
                        AppColors.error,
                    icon: Icons
                        .account_balance_wallet_outlined,
                    iconColor:
                        AppColors.chartOrange,
                  ),

                  const SizedBox(height: 18),

                  _activityTile(
                    title:
                        'Tax Insight Generated',
                    subtitle:
                        'AI identified possible savings opportunity.',
                    amount: 'AI',
                    amountColor:
                        AppColors.taxHighlight,
                    icon:
                        Icons.auto_awesome,
                    iconColor:
                        AppColors.taxHighlight,
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
  // ACTIVITY TILE
  // =========================================================

  Widget _activityTile({
    required String title,
    required String subtitle,
    required String amount,
    required Color amountColor,
    required IconData icon,
    required Color iconColor,
  }) {

    return DashboardContainer(
      child: Row(
        children: [

          /// ICON
          Container(
            width: 56,
            height: 56,

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

          const SizedBox(width: 18),

          /// TEXT
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
                  subtitle,
                  style:
                      AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),

          /// AMOUNT
          Text(
            amount,
            style:
                AppTextStyles.bodyMedium
                    .copyWith(
              color: amountColor,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}