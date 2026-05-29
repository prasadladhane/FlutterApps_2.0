import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../dashboard/presentation/widgets/dashboard_container.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_title.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,

        onPressed: () {},

        child: const Icon(
          Icons.download_rounded,
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 16,
                runSpacing: 16,
                children: [

                  /// LEFT CONTENT
                  SizedBox(
                    width: 500,

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          'Financial Reports',
                          style:
                              AppTextStyles.heading2,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Generate and analyze financial, tax and AI-powered reports.',
                          style:
                              AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),

                  /// EXPORT BUTTON
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
                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        const Icon(
                          Icons.picture_as_pdf_outlined,
                          color:
                              AppColors.primary,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          'Export PDF',
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

              const SizedBox(height: 36),

              /// REPORT ANALYTICS
              DashboardSectionTitle(
                title: 'Report Analytics',
                subtitle:
                    'Overview of generated financial reports and insights.',
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

                    childAspectRatio:
                        constraints.maxWidth < 650
                            ? 1.05
                            : 1.25,

                    children: [
                      
                      _analyticsCard(
                        title:
                            'Reports Generated',
                        value: '48',
                        growth: '+12%',
                        icon:
                            Icons.analytics_outlined, 
                        iconColor:
                            AppColors.chartPurple,
                      ),

                      _analyticsCard(
                        title:
                            'Tax Reports',
                        value: '16',
                        growth: '+5%',
                        icon:
                            Icons.receipt_long_outlined,
                        iconColor:
                            AppColors.taxHighlight,
                      ),

                      _analyticsCard(
                        title:
                            'AI Insights',
                        value: '29',
                        growth: '+18%',
                        icon:
                            Icons.auto_awesome,
                        iconColor:
                            AppColors.primary,
                      ),

                      _analyticsCard(
                        title:
                            'Exports',
                        value: '74',
                        growth: '+9%',
                        icon:
                            Icons.download_rounded,
                        iconColor:
                            AppColors.chartGreen,
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 36),

              /// GENERATED REPORTS
              DashboardSectionTitle(
                title: 'Generated Reports',
                subtitle:
                    'Recent reports generated from your financial activity.',
                actionText: 'View All',
                onActionTap: () {},
              ),

              const SizedBox(height: 24),

              Column(
                children: [

                  _reportTile(
                    title:
                        'Monthly Financial Report',
                    subtitle:
                        'Complete overview of income and expenses.',
                    type:
                        'PDF',
                    generatedOn:
                        'Today',
                    icon:
                        Icons.picture_as_pdf_outlined,
                    iconColor:
                        AppColors.error,
                  ),

                  const SizedBox(height: 18),

                  _reportTile(
                    title:
                        'Tax Estimation Report',
                    subtitle:
                        'AI-generated tax optimization analysis.',
                    type:
                        'AI',
                    generatedOn:
                        'Yesterday',
                    icon:
                        Icons.receipt_long_outlined,
                    iconColor:
                        AppColors.taxHighlight,
                  ),

                  const SizedBox(height: 18),

                  _reportTile(
                    title:
                        'Expense Analytics',
                    subtitle:
                        'Category-wise expense breakdown and trends.',
                    type:
                        'Analytics',
                    generatedOn:
                        '2 days ago',
                    icon:
                        Icons.bar_chart_rounded,
                    iconColor:
                        AppColors.chartOrange,
                  ),

                  const SizedBox(height: 18),

                  _reportTile(
                    title:
                        'Freelance Income Summary',
                    subtitle:
                        'Summary of all client earnings and invoices.',
                    type:
                        'Finance',
                    generatedOn:
                        'This Week',
                    icon:
                        Icons.trending_up_rounded,
                    iconColor:
                        AppColors.chartGreen,
                  ),
                ],
              ),

              const SizedBox(height: 36),

              /// AI REPORT INSIGHTS
              DashboardSectionTitle(
                title: 'AI Report Insights',
                subtitle:
                    'Smart recommendations generated from your reports.',
              ),

              const SizedBox(height: 24),

              DashboardContainer(
                child: Row(
                  children: [

                    /// ICON
                    Container(
                      padding:
                          const EdgeInsets.all(
                              16),

                      decoration: BoxDecoration(
                        color: AppColors.primary
                            .withValues(alpha: 0.12),

                        borderRadius:
                            BorderRadius.circular(
                                18),
                      ),

                      child: const Icon(
                        Icons.auto_awesome,
                        color:
                            AppColors.primary,
                      ),
                    ),

                    const SizedBox(width: 18),

                    /// TEXT
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [

                          Text(
                            'AI Suggestion',
                            style:
                                AppTextStyles
                                    .cardTitle,
                          ),

                          const SizedBox(
                              height: 8),

                          Text(
                            'Your quarterly business expenses indicate possible '
                            'tax-saving opportunities under deductible categories.',
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
            CrossAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const SizedBox(height:14),
              Container(
                padding:
                    const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color:
                      iconColor.withValues(
                          alpha: 0.12),

                  borderRadius:
                      BorderRadius.circular(
                          18),
                ),

                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),

              Text(
                growth,
                style:
                    AppTextStyles.bodySmall
                        .copyWith(
                  color:
                      AppColors.success,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Text(
            value,
            style:
                AppTextStyles.heading3,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style:
                AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // REPORT TILE
  // =========================================================

  Widget _reportTile({
    required String title,
    required String subtitle,
    required String type,
    required String generatedOn,
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
              color:
                  iconColor.withOpacity(
                      0.12),

              borderRadius:
                  BorderRadius.circular(
                      18),
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
                  CrossAxisAlignment
                      .start,
              children: [

                Text(
                  title,
                  style:
                      AppTextStyles
                          .cardTitle,
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style:
                      AppTextStyles
                          .bodySmall,
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          /// RIGHT CONTENT
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color: AppColors.primary
                      .withOpacity(0.12),

                  borderRadius:
                      BorderRadius.circular(
                          30),
                ),

                child: Text(
                  type,
                  style:
                      AppTextStyles.bodySmall
                          .copyWith(
                    color:
                        AppColors.primary,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                generatedOn,
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
