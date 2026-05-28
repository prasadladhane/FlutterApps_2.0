import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import 'app_drawer.dart';
import 'desktop_sidebar.dart';
import 'mobile_bottom_navbar.dart';

class ResponsiveScaffold extends StatelessWidget {

  final Widget body;
  final String? title;
  final bool showDrawer;

  const ResponsiveScaffold({
    super.key,
    required this.body,
    this.title,
    this.showDrawer = true,
  });

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

        appBar: title != null
            ? AppBar(
                backgroundColor:
                    AppColors
                        .scaffoldBackground,

                elevation: 0,

                centerTitle: false,

                title: Text(
                  title!,
                ),

                actions: [

                  IconButton(
                    onPressed: () {},

                    icon: const Icon(
                      Icons.notifications_none_rounded,
                    ),
                  ),
                ],
              )
            : null,

        drawer:
            showDrawer
                ? const AppDrawer()
                : null,

        body: SafeArea(
          child: body,
        ),

        bottomNavigationBar:
            const MobileBottomNavbar(),
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

            /// SIDEBAR
            const DesktopSidebar(),

            /// MAIN CONTENT
            Expanded(
              child: SafeArea(
                child: body,
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
          const DesktopSidebar(),

          /// MAIN CONTENT
          Expanded(
            child: SafeArea(
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}