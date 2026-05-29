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

class TabletSidebar extends StatelessWidget {

  final int currentIndex;
  final Function(int) onItemSelected;

  const TabletSidebar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 110,

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

            /// TOP LOGO
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 30,
              ),

              child: Container(
                width: 60,
                height: 60,

                decoration: BoxDecoration(
                  color: AppColors.primary,

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: const Icon(
                  Icons.auto_graph_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),

            /// NAVIGATION
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 14,
                ),

                children: [

                  _sidebarItem(
                    context: context,
                    icon:
                        Icons.dashboard_rounded,
                    title: 'Home',
                    page:
                        const DashboardPage(),
                    isSelected: true,
                  ),

                  _sidebarItem(
                    context: context,
                    icon:
                        Icons.account_balance_wallet_rounded,
                    title: 'Finance',
                    page:
                        const FinanceOverviewPage(),
                  ),

                  _sidebarItem(
                    context: context,
                    icon:
                        Icons.auto_awesome,
                    title: 'AI',
                    page:
                        const AiAssistantPage(),
                  ),

                  _sidebarItem(
                    context: context,
                    icon:
                        Icons.analytics_outlined,
                    title: 'Reports',
                    page:
                        const ReportsPage(),
                  ),

                  _sidebarItem(
                    context: context,
                    icon:
                        Icons.receipt_long_outlined,
                    title: 'Tax',
                    page:
                        const TaxCalculatorPage(),
                  ),

                  _sidebarItem(
                    context: context,
                    icon:
                        Icons.upload_file_rounded,
                    title: 'Uploads',
                    page:
                        const UploadBillsPage(),
                  ),

                  _sidebarItem(
                    context: context,
                    icon:
                        Icons.person_outline_rounded,
                    title: 'Profile',
                    page:
                        const ProfilePage(),
                  ),
                ],
              ),
            ),

            /// BOTTOM PROFILE
            Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 22,
              ),

              child: Column(
                children: [

                  Container(
                    width: 56,
                    height: 56,

                    decoration: BoxDecoration(
                      color: AppColors.primary
                          .withValues(alpha: 0.12),

                      shape: BoxShape.circle,
                    ),

                    child: const Center(
                      child: Text(
                        'P',
                        style: TextStyle(
                          color:
                              AppColors.primary,
                          fontWeight:
                              FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Prasad',
                    style:
                        AppTextStyles.bodySmall,
                    overflow:
                        TextOverflow.ellipsis,
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
    required IconData icon,
    required String title,
    required Widget page,
    bool isSelected = false,
  }) {

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 18,
      ),

      child: GestureDetector(
        onTap: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },

        child: AnimatedContainer(
          duration:
              const Duration(
                  milliseconds: 250),

          padding:
              const EdgeInsets.symmetric(
            vertical: 16,
          ),

          decoration:
              BoxDecoration(
            color: isSelected
                ? AppColors.primary
                    .withValues(alpha: 0.14)
                : Colors.transparent,

            borderRadius:
                BorderRadius.circular(
                    20),

            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                      .withValues(alpha: 0.25)
                  : Colors.transparent,
            ),
          ),

          child: Column(
            children: [

              Icon(
                icon,
                color: isSelected
                    ? AppColors.primary
                    : AppColors
                        .secondaryText,
                size: 28,
              ),

              const SizedBox(height: 10),

              Text(
                title,
                style:
                    AppTextStyles.bodySmall
                        .copyWith(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors
                          .secondaryText,

                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}