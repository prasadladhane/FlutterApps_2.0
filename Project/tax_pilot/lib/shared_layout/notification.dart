import 'package:flutter/material.dart';
import 'package:tax_pilot/features/dashboard/presentation/widgets/dashboard_container.dart';
import 'package:tax_pilot/features/dashboard/presentation/widgets/dashboard_section_title.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';


class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> notifications = [

      {
        'title': 'Advance Tax Reminder',
        'subtitle':
            'Your next advance tax payment of ₹18,500 is due on 15 September.',
        'time': '2 mins ago',
        'icon': Icons.notifications_active_outlined,
        'iconColor': AppColors.warning,
        'status': 'Important',
        'statusColor': AppColors.warning,
      },

      {
        'title': 'AI Detected Deduction Opportunity',
        'subtitle':
            'You may save more tax by claiming software subscription expenses.',
        'time': '1 hour ago',
        'icon': Icons.auto_awesome,
        'iconColor': AppColors.primaryLight,
        'status': 'AI Insight',
        'statusColor': AppColors.primaryLight,
      },

      {
        'title': 'GST Threshold Alert',
        'subtitle':
            'Your annual income has crossed 70% of GST registration threshold.',
        'time': 'Today',
        'icon': Icons.warning_amber_rounded,
        'iconColor': AppColors.taxHighlight,
        'status': 'GST Alert',
        'statusColor': AppColors.taxHighlight,
      },

      {
        'title': 'Invoice Successfully Processed',
        'subtitle':
            'AI successfully extracted expense details from uploaded invoice.',
        'time': 'Yesterday',
        'icon': Icons.receipt_long_outlined,
        'iconColor': AppColors.success,
        'status': 'Completed',
        'statusColor': AppColors.success,
      },

      {
        'title': 'Tax Report Generated',
        'subtitle':
            'Your monthly tax summary PDF report is ready for download.',
        'time': '2 days ago',
        'icon': Icons.description_outlined,
        'iconColor': AppColors.chartBlue,
        'status': 'Report',
        'statusColor': AppColors.chartBlue,
      },
    ];

    return Scaffold(
      backgroundColor:
          AppColors.scaffoldBackground,

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(24),

          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(
                maxWidth: 1300,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  /// HEADER
                  LayoutBuilder(
                    builder:
                        (context, constraints) {

                      final bool isMobile =
                          constraints.maxWidth <
                              700;

                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,

                        alignment:
                            WrapAlignment
                                .spaceBetween,

                        crossAxisAlignment:
                            WrapCrossAlignment
                                .center,

                        children: [

                          /// LEFT SIDE
                          SizedBox(
                            width: isMobile
                                ? constraints
                                    .maxWidth
                                : constraints
                                        .maxWidth *
                                    0.65,

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [

                                Text(
                                  'Notifications',
                                  style:
                                      AppTextStyles
                                          .heading2,
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                Text(
                                  'Track tax alerts, AI insights and financial updates.',
                                  style:
                                      AppTextStyles
                                          .bodySmall,
                                ),
                              ],
                            ),
                          ),

                          /// MARK AS READ
                          Container(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),

                            decoration:
                                BoxDecoration(
                              color: AppColors
                                  .cardBackground,

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                18,
                              ),

                              border: Border.all(
                                color: AppColors
                                    .border,
                              ),
                            ),

                            child: Row(
                              mainAxisSize:
                                  MainAxisSize
                                      .min,
                              children: [

                                const Icon(
                                  Icons
                                      .done_all_rounded,
                                  color: AppColors
                                      .primary,
                                ),

                                const SizedBox(
                                  width: 10,
                                ),

                                Text(
                                  'Mark all as read',
                                  style:
                                      AppTextStyles
                                          .bodySmall
                                          .copyWith(
                                    color:
                                        AppColors
                                            .primary,
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 36),

                  /// OVERVIEW
                  DashboardSectionTitle(
                    title:
                        'Notification Overview',
                    subtitle:
                        'Monitor reminders, AI alerts and important updates.',
                  ),

                  const SizedBox(height: 24),

                  /// OVERVIEW CARDS
                  LayoutBuilder(
                    builder:
                        (context, constraints) {

                      int crossAxisCount =
                          1;

                      if (constraints
                              .maxWidth >=
                          1100) {

                        crossAxisCount = 4;

                      } else if (constraints
                              .maxWidth >=
                          700) {

                        crossAxisCount = 2;
                      }

                      return GridView.count(
                        shrinkWrap: true,

                        physics:
                            const NeverScrollableScrollPhysics(),

                        crossAxisCount:
                            crossAxisCount,

                        crossAxisSpacing:
                            18,

                        mainAxisSpacing:
                            18,

                        childAspectRatio:
                            1.28,

                        children: [

                          _overviewCard(
                            title:
                                'Unread Alerts',
                            value: '12',
                            icon: Icons
                                .notifications_active_outlined,
                            color:
                                AppColors.warning,
                          ),

                          _overviewCard(
                            title:
                                'AI Insights',
                            value: '8',
                            icon: Icons
                                .auto_awesome,
                            color: AppColors
                                .primaryLight,
                          ),

                          _overviewCard(
                            title:
                                'Tax Reminders',
                            value: '4',
                            icon: Icons
                                .account_balance_outlined,
                            color: AppColors
                                .taxHighlight,
                          ),

                          _overviewCard(
                            title:
                                'Completed Updates',
                            value: '36',
                            icon: Icons
                                .verified_outlined,
                            color:
                                AppColors.success,
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  /// RECENT NOTIFICATIONS
                  DashboardSectionTitle(
                    title:
                        'Recent Notifications',
                    subtitle:
                        'Latest system alerts and AI-generated insights.',
                    actionText:
                        'Clear All',
                    onActionTap: () {},
                  ),

                  const SizedBox(height: 24),

                  /// NOTIFICATION LIST
                  Column(
                    children:
                        notifications.map((item) {

                      return Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 18,
                        ),

                        child: _notificationTile(
                          title:
                              item['title'],
                          subtitle:
                              item['subtitle'],
                          time:
                              item['time'],
                          icon:
                              item['icon'],
                          iconColor:
                              item['iconColor'],
                          status:
                              item['status'],
                          statusColor:
                              item['statusColor'],
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // OVERVIEW CARD
  // =========================================================

  Widget _overviewCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {

    return DashboardContainer(
      child: SizedBox(
        height: double.infinity,

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

          children: [

            Container(
              padding:
                  const EdgeInsets.all(
                14,
              ),

              decoration: BoxDecoration(
                color:
                    color.withValues(
                  alpha: 0.12,
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

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  value,
                  style:
                      AppTextStyles
                          .heading3,
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  title,
                  style:
                      AppTextStyles
                          .bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // NOTIFICATION TILE
  // =========================================================

  Widget _notificationTile({
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required Color iconColor,
    required String status,
    required Color statusColor,
  }) {

    return DashboardContainer(
      child: LayoutBuilder(
        builder:
            (context, constraints) {

          final bool isMobile =
              constraints.maxWidth <
                  700;

          return isMobile

              /// MOBILE
              ? Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [

                    Row(
                      children: [

                        /// ICON
                        Container(
                          width: 58,
                          height: 58,

                          decoration:
                              BoxDecoration(
                            color: iconColor
                                .withValues(
                              alpha: 0.12,
                            ),

                            borderRadius:
                                BorderRadius
                                    .circular(
                              18,
                            ),
                          ),

                          child: Icon(
                            icon,
                            color:
                                iconColor,
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
                                title,

                                maxLines: 2,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    AppTextStyles
                                        .cardTitle,
                              ),

                              const SizedBox(
                                height: 6,
                              ),

                              Text(
                                time,
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
                      height: 18,
                    ),

                    Text(
                      subtitle,
                      style:
                          AppTextStyles
                              .bodyMedium,
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),

                      decoration:
                          BoxDecoration(
                        color: statusColor
                            .withValues(
                          alpha: 0.12,
                        ),

                        borderRadius:
                            BorderRadius
                                .circular(
                          30,
                        ),
                      ),

                      child: Text(
                        status,
                        style:
                            AppTextStyles
                                .bodySmall
                                .copyWith(
                          color:
                              statusColor,
                          fontWeight:
                              FontWeight
                                  .w600,
                        ),
                      ),
                    ),
                  ],
                )

              /// DESKTOP
              : Row(
                  children: [

                    /// ICON
                    Container(
                      width: 58,
                      height: 58,

                      decoration:
                          BoxDecoration(
                        color: iconColor
                            .withValues(
                          alpha: 0.12,
                        ),

                        borderRadius:
                            BorderRadius
                                .circular(
                          18,
                        ),
                      ),

                      child: Icon(
                        icon,
                        color:
                            iconColor,
                      ),
                    ),

                    const SizedBox(
                      width: 18,
                    ),

                    /// CONTENT
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

                          const SizedBox(
                            height: 8,
                          ),

                          Text(
                            subtitle,
                            style:
                                AppTextStyles
                                    .bodyMedium,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 20,
                    ),

                    /// RIGHT SIDE
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .end,
                      children: [

                        Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),

                          decoration:
                              BoxDecoration(
                            color: statusColor
                                .withValues(
                              alpha: 0.12,
                            ),

                            borderRadius:
                                BorderRadius
                                    .circular(
                              30,
                            ),
                          ),

                          child: Text(
                            status,
                            style:
                                AppTextStyles
                                    .bodySmall
                                    .copyWith(
                              color:
                                  statusColor,
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          time,
                          style:
                              AppTextStyles
                                  .bodySmall,
                        ),
                      ],
                    ),
                  ],
                );
        },
      ),
    );
  }
}