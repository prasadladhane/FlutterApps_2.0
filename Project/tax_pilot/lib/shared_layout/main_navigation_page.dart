import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

import '../features/ai_assistant/presentation/pages/ai_assistant_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/finance/presentation/pages/finance_overview_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/reports/presentation/pages/reports_page.dart';

import 'app_drawer.dart';
import 'desktop_sidebar.dart';
import 'tablet_sidebar.dart';

class MainNavigationPage extends StatefulWidget {
  final int initialIndex;

 const MainNavigationPage({
  super.key,
  this.initialIndex = 0,
});

  @override
  State<MainNavigationPage> createState() =>
      _MainNavigationPageState();
}

class _MainNavigationPageState
    extends State<MainNavigationPage> {

  late int currentIndex;

  @override
void initState() {
  super.initState();
  currentIndex = widget.initialIndex;
}

  // =========================================================
  // ALL MAIN PAGES
  // =========================================================

  late final List<Widget> pages = [

    const DashboardPage(),

    const FinanceOverviewPage(),

    const AiAssistantPage(),

    const ReportsPage(),

    const ProfilePage(),
  ];

  // =========================================================
  // PAGE TITLES
  // =========================================================

  final List<String> pageTitles = [

    'Dashboard',
    'Finance',
    'AI Assistant',
    'Reports',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    /// =====================================================
    /// MOBILE LAYOUT
    /// =====================================================

    if (width < 768) {

      return Scaffold(
        backgroundColor:
            AppColors.scaffoldBackground,

        drawer: AppDrawer(
          currentIndex: currentIndex,
          onItemSelected: changePage,
        ),

        appBar: AppBar(
          backgroundColor:
              AppColors.scaffoldBackground,

          elevation: 0,

          title: Text(
            pageTitles[currentIndex],
          ),

          actions: [

            IconButton(
              onPressed: () {},

              icon: const Icon(
                Icons.notifications_none_rounded,
              ),
            ),

            const SizedBox(width: 6),
          ],
        ),

        body: SafeArea(
          child: pages[currentIndex],
        ),

        bottomNavigationBar:
            _mobileBottomNavbar(),
      );
    }

    /// =====================================================
    /// TABLET LAYOUT
    /// =====================================================

    if (width < 1200) {

      return Scaffold(
        backgroundColor:
            AppColors.scaffoldBackground,

        body: Row(
          children: [

            /// TABLET SIDEBAR
            TabletSidebar(
              currentIndex: currentIndex,
              onItemSelected: changePage,
            ),

            /// PAGE CONTENT
            Expanded(
              child: SafeArea(
                child: pages[currentIndex],
              ),
            ),
          ],
        ),
      );
    }

    /// =====================================================
    /// DESKTOP LAYOUT
    /// =====================================================

    return Scaffold(
      backgroundColor:
          AppColors.scaffoldBackground,

      body: Row(
        children: [

          /// DESKTOP SIDEBAR
          DesktopSidebar(
            currentIndex: currentIndex,
            onItemSelected: changePage,
          ),

          /// PAGE CONTENT
          Expanded(
            child: SafeArea(
              child: pages[currentIndex],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CHANGE PAGE
  // =========================================================

  void changePage(int index) {

    setState(() {
      currentIndex = index;
    });
  }

  // =========================================================
  // MOBILE NAVBAR
  // =========================================================

  Widget _mobileBottomNavbar() {

    return Container(
      margin: const EdgeInsets.all(16),

      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),

      decoration: BoxDecoration(
        color: AppColors.cardBackground,

        borderRadius:
            BorderRadius.circular(28),

        border: Border.all(
          color: AppColors.border,
        ),
      ),

      child: Row(
  children: [

    Expanded(
      child: _navItem(
        index: 0,
        icon: Icons.dashboard_rounded,
        title: 'Home',
      ),
    ),

    Expanded(
      child: _navItem(
        index: 1,
        icon: Icons.account_balance_wallet_rounded,
        title: 'Finance',
      ),
    ),

    Expanded(
      child: _navItem(
        index: 2,
        icon: Icons.auto_awesome,
        title: 'AI',
      ),
    ),

    Expanded(
      child: _navItem(
        index: 3,
        icon: Icons.analytics_outlined,
        title: 'Reports',
      ),
    ),

    Expanded(
      child: _navItem(
        index: 4,
        icon: Icons.person_outline_rounded,
        title: 'Profile',
      ),
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

        changePage(index);
      },

      child: AnimatedContainer(
        width: double.infinity,
        duration:
            const Duration(
                milliseconds: 250),

        padding:
            const EdgeInsets.symmetric(
          // horizontal: 14,
          vertical: 10,
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
            ),

            const SizedBox(height: 6),

            Text(
              title,

              style:
                  TextStyle(
                color: isSelected
                    ? AppColors.primary
                    : AppColors
                        .secondaryText,

                fontSize: 12,

                fontWeight:
                    isSelected
                        ? FontWeight.w600
                        : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}