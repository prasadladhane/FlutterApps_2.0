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

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor:
          AppColors.sidebarBackground,

      child: SafeArea(
        child: Column(
          children: [

            /// TOP BRAND SECTION
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(24),

              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        AppColors.border,
                  ),
                ),
              ),

              child: Row(
                children: [

                  /// LOGO
                  Container(
                    width: 54,
                    height: 54,

                    decoration:
                        BoxDecoration(
                      color:
                          AppColors.primary,

                      borderRadius:
                          BorderRadius.circular(
                              18),
                    ),

                    child: const Icon(
                      Icons.auto_graph_rounded,
                      color:
                          Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// APP NAME
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

            /// MENU ITEMS
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.all(
                        18),

                children: [

                  _drawerItem(
                    context: context,
                    title: 'Dashboard',
                    icon:
                        Icons.dashboard_rounded,
                    page:
                        const DashboardPage(),
                  ),

                  _drawerItem(
                    context: context,
                    title:
                        'Finance Overview',
                    icon:
                        Icons.account_balance_wallet_rounded,
                    page:
                        const FinanceOverviewPage(),
                  ),

                  _drawerItem(
                    context: context,
                    title:
                        'AI Assistant',
                    icon:
                        Icons.auto_awesome,
                    page:
                        const AiAssistantPage(),
                  ),

                  _drawerItem(
                    context: context,
                    title: 'Reports',
                    icon:
                        Icons.analytics_outlined,
                    page:
                        const ReportsPage(),
                  ),

                  _drawerItem(
                    context: context,
                    title:
                        'Tax Calculator',
                    icon:
                        Icons.receipt_long_outlined,
                    page:
                        const TaxCalculatorPage(),
                  ),

                  _drawerItem(
                    context: context,
                    title:
                        'Upload Bills',
                    icon:
                        Icons.upload_file_rounded,
                    page:
                        const UploadBillsPage(),
                  ),

                  _drawerItem(
                    context: context,
                    title: 'Profile',
                    icon:
                        Icons.person_outline_rounded,
                    page:
                        const ProfilePage(),
                  ),
                ],
              ),
            ),

            /// BOTTOM SECTION
            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color:
                        AppColors.border,
                  ),
                ),
              ),

              child: Row(
                children: [

                  /// SETTINGS BUTTON
                  Expanded(
                    child: _bottomButton(
                      title:
                          'Settings',
                      icon:
                          Icons.settings_outlined,
                      color:
                          AppColors.primary,
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// LOGOUT BUTTON
                  Expanded(
                    child: _bottomButton(
                      title:
                          'Logout',
                      icon:
                          Icons.logout_rounded,
                      color:
                          AppColors.error,
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
  // DRAWER ITEM
  // =========================================================

  Widget _drawerItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Widget page,
  }) {

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 14,
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(18),

        onTap: () {

          Navigator.pop(context);

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

          decoration: BoxDecoration(
            color:
                AppColors.cardBackground,

            borderRadius:
                BorderRadius.circular(
                    18),

            border: Border.all(
              color:
                  AppColors.border,
            ),
          ),

          child: Row(
            children: [

              Icon(
                icon,
                color:
                    AppColors.primary,
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  title,
                  style:
                      AppTextStyles
                          .bodyMedium
                          .copyWith(
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),
              ),

              const Icon(
                Icons
                    .arrow_forward_ios_rounded,
                size: 16,
                color:
                    AppColors.secondaryText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // BOTTOM BUTTON
  // =========================================================

  Widget _bottomButton({
    required String title,
    required IconData icon,
    required Color color,
  }) {

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),

      decoration: BoxDecoration(
        color:
            color.withOpacity(0.12),

        borderRadius:
            BorderRadius.circular(18),

        border: Border.all(
          color:
              color.withOpacity(0.25),
        ),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            color: color,
            size: 20,
          ),

          const SizedBox(width: 8),

          Text(
            title,
            style:
                AppTextStyles.bodySmall
                    .copyWith(
              color: color,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}