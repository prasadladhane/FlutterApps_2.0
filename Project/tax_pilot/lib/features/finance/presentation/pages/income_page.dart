import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../dashboard/presentation/widgets/dashboard_container.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_title.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

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

                  /// LEFT SECTION
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Income Manager',
                        style:
                            AppTextStyles.heading2,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Track salary, freelance and business income efficiently.',
                        style:
                            AppTextStyles.bodySmall,
                      ),
                    ],
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
                      children: [

                        const Icon(
                          Icons.download_rounded,
                          color:
                              AppColors.primary,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          'Export',
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

              /// INCOME OVERVIEW
              DashboardSectionTitle(
                title: 'Income Overview',
                subtitle:
                    'Analyze your earnings and financial growth.',
              ),

              const SizedBox(height: 24),

              /// ANALYTICS ROW
              Row(
                children: [

                  Expanded(
                    child: _analyticsCard(
                      title: 'Total Income',
                      value: '₹85,000',
                      growth: '+18%',
                      icon:
                          Icons.trending_up_rounded,
                      iconColor:
                          AppColors.chartGreen,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: _analyticsCard(
                      title: 'Freelance Earnings',
                      value: '₹42,000',
                      growth: '+12%',
                      icon:
                          Icons.work_outline_rounded,
                      iconColor:
                          AppColors.chartBlue,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: _analyticsCard(
                      title: 'Pending Payments',
                      value: '₹18,500',
                      growth: '+4%',
                      icon:
                          Icons.pending_actions_rounded,
                      iconColor:
                          AppColors.warning,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              /// RECENT INCOME SECTION
              DashboardSectionTitle(
                title: 'Recent Income',
                subtitle:
                    'Latest income transactions and earnings.',
                actionText: 'View All',
                onActionTap: () {},
              ),

              const SizedBox(height: 24),

              /// INCOME LIST
              Column(
                children: [

                  _incomeTile(
                    title:
                        'UI Design Project',
                    category:
                        'Freelance Client',
                    amount:
                        '+ ₹15,000',
                    date:
                        'Today',

                    icon:
                        Icons.design_services_outlined,

                    iconColor:
                        AppColors.chartGreen,
                  ),

                  const SizedBox(height: 18),

                  _incomeTile(
                    title:
                        'Mobile App Development',
                    category:
                        'Contract Work',
                    amount:
                        '+ ₹28,000',
                    date:
                        'Yesterday',

                    icon:
                        Icons.phone_android_rounded,

                    iconColor:
                        AppColors.primary,
                  ),

                  const SizedBox(height: 18),

                  _incomeTile(
                    title:
                        'Affiliate Revenue',
                    category:
                        'Passive Income',
                    amount:
                        '+ ₹4,200',
                    date:
                        '2 days ago',

                    icon:
                        Icons.currency_rupee_rounded,

                    iconColor:
                        AppColors.chartPurple,
                  ),

                  const SizedBox(height: 18),

                  _incomeTile(
                    title:
                        'Consultation Session',
                    category:
                        'Client Meeting',
                    amount:
                        '+ ₹7,500',
                    date:
                        'This Week',

                    icon:
                        Icons.support_agent_rounded,

                    iconColor:
                        AppColors.taxHighlight,
                  ),
                ],
              ),

              const SizedBox(height: 36),

              /// AI INSIGHTS
              DashboardSectionTitle(
                title: 'AI Income Insights',
                subtitle:
                    'AI-powered analysis of your earnings.',
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
                            .withOpacity(0.12),

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
                            'AI Recommendation',
                            style:
                                AppTextStyles
                                    .cardTitle,
                          ),

                          const SizedBox(
                              height: 8),

                          Text(
                            'Your freelance earnings increased by 18% this month. '
                            'Consider separating taxable and non-taxable income categories.',
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
            CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [

              Container(
                padding:
                    const EdgeInsets.all(14),

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
  // INCOME TILE
  // =========================================================

  Widget _incomeTile({
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
                  category,
                  style:
                      AppTextStyles
                          .bodySmall,
                ),
              ],
            ),
          ),

          /// RIGHT CONTENT
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [

              Text(
                amount,
                style:
                    AppTextStyles
                        .bodyMedium
                        .copyWith(
                  color:
                      AppColors.success,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                date,
                style:
                    AppTextStyles
                        .bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}