import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

import '../features/ai_assistant/presentation/pages/ai_assistant_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/finance/presentation/pages/finance_overview_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/reports/presentation/pages/reports_page.dart';
import '../features/tax/presentation/pages/tax_calculator_page.dart';
import '../features/uploads/presentation/pages/upload_bills_page.dart';

class DesktopSidebar extends StatelessWidget {
  const DesktopSidebar({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 290,

      decoration: const BoxDecoration(
        color: AppColors.sidebarBackground,

        border: Border(
          right: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),

      child: SafeArea(
        child: Column(
          children: [

            /// TOP LOGO SECTION
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(28),

              child: Row(
                children: [

                  /// LOGO
                  Container(
                    width: 58,
                    height: 58,

                    decoration:
                        BoxDecoration(
                      color:
                          AppColors.primary,

                      borderRadius:
                          BorderRadius.circular(
                              20),
                    ),

                    child: const Icon(
                      Icons.auto_graph_rounded,
                      color:
                          Colors.white,
                      size: 32,
                    ),
                  ),

                  const SizedBox(width: 18),

                  /// TITLE
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [

                      Text(
                        'TaxPilot',
                        style:
                            AppTextStyles
                                .heading3,
                      ),

                      const SizedBox(
                          height: 4),

                      Text(
                        'Finance Workspace',
                        style:
                            AppTextStyles
                                .bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// DIVIDER
            Container(
              height: 1,
              margin:
                  const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              color: AppColors.divider,
            ),

            const SizedBox(height: 24),

            /// MENU SECTION
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 18,
                ),

                children: [

                  _sidebarItem(
                    context: context,
                    title: 'Dashboard',
                    icon:
                        Icons.dashboard_rounded,
                    page:
                        const DashboardPage(),
                    isSelected: true,
                  ),

                  _sidebarItem(
                    context: context,
                    title:
                        'Finance Overview',
                    icon:
                        Icons.account_balance_wallet_rounded,
                    page:
                        const FinanceOverviewPage(),
                  ),

                  _sidebarItem(
                    context: context,
                    title:
                        'AI Assistant',
                    icon:
                        Icons.auto_awesome,
                    page:
                        const AiAssistantPage(),
                  ),

                  _sidebarItem(
                    context: context,
                    title: 'Reports',
                    icon:
                        Icons.analytics_outlined,
                    page:
                        const ReportsPage(),
                  ),

                  _sidebarItem(
                    context: context,
                    title:
                        'Tax Calculator',
                    icon:
                        Icons.receipt_long_outlined,
                    page:
                        const TaxCalculatorPage(),
                  ),

                  _sidebarItem(
                    context: context,
                    title:
                        'Upload Bills',
                    icon:
                        Icons.upload_file_rounded,
                    page:
                        const UploadBillsPage(),
                  ),

                  _sidebarItem(
                    context: context,
                    title:
                        'Profile',
                    icon:
                        Icons.person_outline_rounded,
                    page:
                        const ProfilePage(),
                  ),
                ],
              ),
            ),

            /// BOTTOM USER SECTION
            Container(
              margin:
                  const EdgeInsets.all(20),

              padding:
                  const EdgeInsets.all(18),

              decoration:
                  BoxDecoration(
                color:
                    AppColors.cardBackground,

                borderRadius:
                    BorderRadius.circular(
                        24),

                border: Border.all(
                  color:
                      AppColors.border,
                ),
              ),

              child: Row(
                children: [

                  /// AVATAR
                  Container(
                    width: 54,
                    height: 54,

                    decoration:
                        BoxDecoration(
                      color: AppColors
                          .primary
                          .withOpacity(
                              0.12),

                      shape:
                          BoxShape.circle,
                    ),

                    child: const Center(
                      child: Text(
                        'P',
                        style: TextStyle(
                          color:
                              AppColors
                                  .primary,
                          fontWeight:
                              FontWeight
                                  .w700,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// USER INFO
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [

                        Text(
                          'Prasad',
                          style:
                              AppTextStyles
                                  .bodyMedium
                                  .copyWith(
                            fontWeight:
                                FontWeight
                                    .w600,
                          ),
                        ),

                        const SizedBox(
                            height: 4),

                        Text(
                          'Premium User',
                          style:
                              AppTextStyles
                                  .bodySmall,
                        ),
                      ],
                    ),
                  ),

                  /// SETTINGS
                  Container(
                    padding:
                        const EdgeInsets
                            .all(10),

                    decoration:
                        BoxDecoration(
                      color: AppColors
                          .secondaryCardBackground,

                      borderRadius:
                          BorderRadius
                              .circular(
                                  14),
                    ),

                    child: const Icon(
                      Icons.settings_outlined,
                      color: AppColors
                          .secondaryText,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // SIDEBAR ITEM
  // =========================================================

  Widget _sidebarItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Widget page,
    bool isSelected = false,
  }) {

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 14,
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(20),

        onTap: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },

        child: Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),

          decoration:
              BoxDecoration(
            color: isSelected
                ? AppColors.primary
                    .withOpacity(0.14)
                : Colors.transparent,

            borderRadius:
                BorderRadius.circular(
                    20),

            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                      .withOpacity(0.25)
                  : Colors.transparent,
            ),
          ),

          child: Row(
            children: [

              Icon(
                icon,
                color: isSelected
                    ? AppColors.primary
                    : AppColors
                        .secondaryText,
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  title,
                  style:
                      AppTextStyles
                          .bodyMedium
                          .copyWith(
                    color: isSelected
                        ? AppColors
                            .primary
                        : AppColors
                            .primaryText,

                    fontWeight:
                        isSelected
                            ? FontWeight
                                .w600
                            : FontWeight
                                .w500,
                  ),
                ),
              ),

              if (isSelected)
                const Icon(
                  Icons
                      .arrow_forward_ios_rounded,
                  size: 16,
                  color:
                      AppColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}