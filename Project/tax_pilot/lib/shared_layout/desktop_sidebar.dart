import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

class DesktopSidebar extends StatelessWidget {

  final int currentIndex;
  final Function(int) onItemSelected;

  const DesktopSidebar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

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

            /// LOGO SECTION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),

              child: Row(
                children: [

                  Container(
                    width: 58,
                    height: 58,

                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),

                    child: const Icon(
                      Icons.auto_graph_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Text(
                        'TaxPilot',
                        style:
                            AppTextStyles.heading3,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Finance Workspace',
                        style:
                            AppTextStyles.bodySmall,
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
                    const EdgeInsets.symmetric(
                  horizontal: 18,
                ),

                children: [

                  _sidebarItem(
                    context: context,
                    index: 0,
                    title: 'Dashboard',
                    icon:
                        Icons.dashboard_rounded,
                  ),

                  _sidebarItem(
                    context: context,
                    index: 1,
                    title:
                        'Finance Overview',
                    icon:
                        Icons.account_balance_wallet_rounded,
                  ),

                  _sidebarItem(
                    context: context,
                    index: 2,
                    title:
                        'AI Assistant',
                    icon:
                        Icons.auto_awesome,
                  ),

                  _sidebarItem(
                    context: context,
                    index: 3,
                    title: 'Reports',
                    icon:
                        Icons.analytics_outlined,
                  ),

                  _sidebarItem(
                    context: context,
                    index: 4,
                    title: 'Profile',
                    icon:
                        Icons.person_outline_rounded,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =======================================================
  // SIDEBAR ITEM
  // =======================================================

  Widget _sidebarItem({
    required BuildContext context,
    required int index,
    required String title,
    required IconData icon,
  }) {

    final bool isSelected =
        currentIndex == index;

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 14,
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(20),

        onTap: () {

          onItemSelected(index);
        },

        child: AnimatedContainer(
          duration:
              const Duration(
                  milliseconds: 250),

          padding:
              const EdgeInsets.symmetric(
            horizontal: 18,
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
            ],
          ),
        ),
      ),
    );
  }
}