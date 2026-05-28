import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

import '../features/ai_assistant/presentation/pages/ai_assistant_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/finance/presentation/pages/finance_overview_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/reports/presentation/pages/reports_page.dart';

class MobileBottomNavbar extends StatefulWidget {
  const MobileBottomNavbar({super.key});

  @override
  State<MobileBottomNavbar> createState() =>
      _MobileBottomNavbarState();
}

class _MobileBottomNavbarState
    extends State<MobileBottomNavbar> {

  int currentIndex = 0;

  final List<Widget> pages = [

    const DashboardPage(),

    const FinanceOverviewPage(),

    const AiAssistantPage(),

    const ReportsPage(),

    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(16),

      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),

      decoration: BoxDecoration(
        color: AppColors.cardBackground,

        borderRadius:
            BorderRadius.circular(28),

        border: Border.all(
          color: AppColors.border,
        ),

        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [

          _navItem(
            index: 0,
            icon:
                Icons.dashboard_rounded,
            title: 'Home',
          ),

          _navItem(
            index: 1,
            icon:
                Icons.account_balance_wallet_rounded,
            title: 'Finance',
          ),

          _navItem(
            index: 2,
            icon:
                Icons.auto_awesome,
            title: 'AI',
          ),

          _navItem(
            index: 3,
            icon:
                Icons.analytics_outlined,
            title: 'Reports',
          ),

          _navItem(
            index: 4,
            icon:
                Icons.person_outline_rounded,
            title: 'Profile',
          ),
        ],
      ),
    );
  }

  // =========================================================
  // NAV ITEM
  // =========================================================

  Widget _navItem({
    required int index,
    required IconData icon,
    required String title,
  }) {

    final bool isSelected =
        currentIndex == index;

    return GestureDetector(
      onTap: () {

        setState(() {
          currentIndex = index;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                pages[index],
          ),
        );
      },

      child: AnimatedContainer(
        duration:
            const Duration(
                milliseconds: 250),

        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),

        decoration:
            BoxDecoration(
          color: isSelected
              ? AppColors.primary
                  .withOpacity(0.14)
              : Colors.transparent,

          borderRadius:
              BorderRadius.circular(
                  18),
        ),

        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [

            Icon(
              icon,
              color: isSelected
                  ? AppColors.primary
                  : AppColors
                      .secondaryText,
              size: 24,
            ),

            const SizedBox(height: 6),

            Text(
              title,
              style:
                  AppTextStyles
                      .bodySmall
                      .copyWith(
                color: isSelected
                    ? AppColors
                        .primary
                    : AppColors
                        .secondaryText,

                fontWeight:
                    isSelected
                        ? FontWeight
                            .w600
                        : FontWeight
                            .w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}