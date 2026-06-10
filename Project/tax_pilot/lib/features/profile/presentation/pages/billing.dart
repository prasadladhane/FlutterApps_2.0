import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../dashboard/presentation/widgets/dashboard_container.dart';

class SubscriptionBillingPage
    extends StatelessWidget {

  const SubscriptionBillingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          AppColors.scaffoldBackground,

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(
            AppSpacing.lg,
          ),

          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(
                maxWidth: 1150,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [

                  // =====================================================
                  // HEADER
                  // =====================================================

                  Row(
                    children: [

                      Container(
                        width: 58,
                        height: 58,

                        decoration:
                            BoxDecoration(
                          color:
                              AppColors
                                  .primary
                                  .withOpacity(
                            0.12,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),

                        child: const Icon(
                          Icons
                              .workspace_premium_outlined,
                          color:
                              AppColors
                                  .primary,
                          size: 28,
                        ),
                      ),

                      const SizedBox(
                        width: 18,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [

                            Text(
                              'Subscription & Billing',
                              style:
                                  AppTextStyles
                                      .heading2,
                            ),

                            const SizedBox(
                              height: 6,
                            ),

                            Text(
                              'Manage your TaxPilot subscription, billing history and premium services.',
                              style:
                                  AppTextStyles
                                      .bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 32,
                  ),

                  // =====================================================
                  // CURRENT PLAN CARD
                  // =====================================================

                  DashboardContainer(
                    child: LayoutBuilder(
                      builder:
                          (
                            context,
                            constraints,
                          ) {

                        final bool isMobile =
                            constraints
                                    .maxWidth <
                                750;

                        return isMobile

                            ? Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [

                                  _planInfo(),

                                  const SizedBox(
                                    height:
                                        28,
                                  ),

                                  _actionButtons(),
                                ],
                              )

                            : Row(
                                children: [

                                  Expanded(
                                    flex: 3,
                                    child:
                                        _planInfo(),
                                  ),

                                  const SizedBox(
                                    width:
                                        30,
                                  ),

                                  Expanded(
                                    flex: 2,
                                    child:
                                        _planStats(),
                                  ),
                                ],
                              );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 32,
                  ),

                  // =====================================================
                  // FEATURES GRID
                  // =====================================================

                  Text(
                    'Premium Features',
                    style:
                        AppTextStyles
                            .heading3,
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  LayoutBuilder(
                    builder:
                        (
                          context,
                          constraints,
                        ) {

                      int crossAxisCount =
                          3;

                      if (constraints
                              .maxWidth <
                          1000) {
                        crossAxisCount =
                            2;
                      }

                      if (constraints
                              .maxWidth <
                          650) {
                        crossAxisCount =
                            1;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),
                        itemCount: 6,

                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              crossAxisCount,
                          crossAxisSpacing:
                              20,
                          mainAxisSpacing:
                              20,
                          childAspectRatio:
                              1.4,
                        ),

                        itemBuilder:
                            (
                              context,
                              index,
                            ) {

                          final items = [

                            {
                              'title':
                                  'AI Tax Assistant',
                              'subtitle':
                                  'Unlimited Gemini AI tax guidance.',
                              'icon':
                                  Icons
                                      .psychology_outlined,
                              'color':
                                  AppColors
                                      .chartPurple,
                            },

                            {
                              'title':
                                  'GST Tracking',
                              'subtitle':
                                  'Live GST threshold monitoring.',
                              'icon':
                                  Icons
                                      .receipt_long_outlined,
                              'color':
                                  AppColors
                                      .taxHighlight,
                            },

                            {
                              'title':
                                  'PDF Reports',
                              'subtitle':
                                  'Download professional tax reports.',
                              'icon':
                                  Icons
                                      .picture_as_pdf_outlined,
                              'color':
                                  AppColors
                                      .error,
                            },

                            {
                              'title':
                                  'Advance Tax Alerts',
                              'subtitle':
                                  'Smart reminders before deadlines.',
                              'icon':
                                  Icons
                                      .notifications_active_outlined,
                              'color':
                                  AppColors
                                      .warning,
                            },

                            {
                              'title':
                                  'CA Connect',
                              'subtitle':
                                  'Connect with tax experts anytime.',
                              'icon':
                                  Icons
                                      .support_agent_outlined,
                              'color':
                                  AppColors
                                      .info,
                            },

                            {
                              'title':
                                  'Cloud Backup',
                              'subtitle':
                                  'Secure encrypted financial storage.',
                              'icon':
                                  Icons
                                      .cloud_done_outlined,
                              'color':
                                  AppColors
                                      .success,
                            },
                          ];

                          final item =
                              items[index];

                          return _featureCard(
                            title:
                                item['title']
                                    as String,
                            subtitle:
                                item['subtitle']
                                    as String,
                            icon:
                                item['icon']
                                    as IconData,
                            color:
                                item['color']
                                    as Color,
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(
                    height: 32,
                  ),

                  // =====================================================
                  // BILLING HISTORY
                  // =====================================================

                  Text(
                    'Recent Billing',
                    style:
                        AppTextStyles
                            .heading3,
                  ),

                  const SizedBox(
                    height: 22,
                  ),

                  DashboardContainer(
                    child: Column(
                      children: [

                        _billingRow(
                          title:
                              'TaxPilot Pro',
                          date:
                              'June 2026',
                          amount:
                              '₹199',
                          status:
                              'Paid',
                          color:
                              AppColors
                                  .success,
                        ),

                        const Divider(),

                        _billingRow(
                          title:
                              'TaxPilot Pro',
                          date:
                              'May 2026',
                          amount:
                              '₹199',
                          status:
                              'Paid',
                          color:
                              AppColors
                                  .success,
                        ),

                        const Divider(),

                        _billingRow(
                          title:
                              'CA Connect Add-on',
                          date:
                              'April 2026',
                          amount:
                              '₹499',
                          status:
                              'Completed',
                          color:
                              AppColors
                                  .primary,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // PLAN INFO
  // =========================================================

  Widget _planInfo() {

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),

          decoration: BoxDecoration(
            color:
                AppColors
                    .gstHighlight
                    .withOpacity(
              0.12,
            ),

            borderRadius:
                BorderRadius.circular(
              30,
            ),
          ),

          child: Text(
            'CURRENT PLAN',
            style:
                AppTextStyles.bodySmall
                    .copyWith(
              color:
                  AppColors
                      .gstHighlight,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'TaxPilot Pro',
          style:
              AppTextStyles.heading2,
        ),

        const SizedBox(height: 12),

        Text(
          'Advanced AI-powered tax management built for Indian freelancers.',
          style:
              AppTextStyles.bodyMedium,
        ),

        const SizedBox(height: 24),

        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [

            _chip(
              'AI Chat',
              AppColors.primary,
            ),

            _chip(
              'GST Tracking',
              AppColors.taxHighlight,
            ),

            _chip(
              'PDF Reports',
              AppColors.error,
            ),
          ],
        ),

        const SizedBox(height: 28),

        _actionButtons(),
      ],
    );
  }

  // =========================================================
  // PLAN STATS
  // =========================================================

  Widget _planStats() {

    return Column(
      children: [

        _statCard(
          title: 'Monthly Plan',
          value: '₹199',
          color: AppColors.primary,
        ),

        const SizedBox(height: 18),

        _statCard(
          title: 'Renewal Date',
          value: '24 Jun',
          color:
              AppColors.taxHighlight,
        ),

        const SizedBox(height: 18),

        _statCard(
          title: 'Status',
          value: 'Active',
          color: AppColors.success,
        ),
      ],
    );
  }

  // =========================================================
  // FEATURE CARD
  // =========================================================

  Widget _featureCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {

    return DashboardContainer(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [

          Container(
            width: 56,
            height: 56,

            decoration: BoxDecoration(
              color:
                  color.withOpacity(
                0.12,
              ),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            title,
            style:
                AppTextStyles.cardTitle,
          ),

          const SizedBox(height: 8),

          Text(
            subtitle,
            style:
                AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BILLING ROW
  // =========================================================

  Widget _billingRow({
    required String title,
    required String date,
    required String amount,
    required String status,
    required Color color,
  }) {

    return Row(
      children: [

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
                date,
                style:
                    AppTextStyles
                        .bodySmall,
              ),
            ],
          ),
        ),

        Text(
          amount,
          style:
              AppTextStyles.bodyLarge,
        ),

        const SizedBox(width: 18),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),

          decoration: BoxDecoration(
            color:
                color.withOpacity(
              0.12,
            ),

            borderRadius:
                BorderRadius.circular(
              30,
            ),
          ),

          child: Text(
            status,
            style:
                AppTextStyles.bodySmall
                    .copyWith(
              color: color,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // ACTION BUTTONS
  // =========================================================

  Widget _actionButtons() {

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 16,
          ),

          decoration: BoxDecoration(
            color:
                AppColors.primary,

            borderRadius:
                BorderRadius.circular(
              18,
            ),
          ),

          child: Row(
            mainAxisSize:
                MainAxisSize.min,
            children: [

              const Icon(
                Icons
                    .workspace_premium_outlined,
                color:
                    AppColors.whiteText,
              ),

              const SizedBox(
                width: 10,
              ),

              Text(
                'Manage Plan',
                style:
                    AppTextStyles
                        .bodyMedium
                        .copyWith(
                  color:
                      AppColors
                          .whiteText,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 16,
          ),

          decoration: BoxDecoration(
            color:
                AppColors
                    .secondaryCardBackground,

            borderRadius:
                BorderRadius.circular(
              18,
            ),
          ),

          child: Row(
            mainAxisSize:
                MainAxisSize.min,
            children: [

              const Icon(
                Icons
                    .download_outlined,
                color:
                    AppColors
                        .primaryText,
              ),

              const SizedBox(
                width: 10,
              ),

              Text(
                'Invoices',
                style:
                    AppTextStyles
                        .bodyMedium
                        .copyWith(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================
  // STAT CARD
  // =========================================================

  Widget _statCard({
    required String title,
    required String value,
    required Color color,
  }) {

    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color:
            color.withOpacity(
          0.08,
        ),

        borderRadius:
            BorderRadius.circular(
          22,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style:
                AppTextStyles.bodySmall,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style:
                AppTextStyles.heading3
                    .copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CHIP
  // =========================================================

  Widget _chip(
    String title,
    Color color,
  ) {

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color:
            color.withOpacity(
          0.12,
        ),

        borderRadius:
            BorderRadius.circular(
          30,
        ),
      ),

      child: Text(
        title,
        style:
            AppTextStyles.bodySmall
                .copyWith(
          color: color,
          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }
}