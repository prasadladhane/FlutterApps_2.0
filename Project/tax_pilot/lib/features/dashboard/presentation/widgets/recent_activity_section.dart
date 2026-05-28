import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import 'dashboard_section_title.dart';
import 'recent_activity_tile.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// SECTION TITLE
        DashboardSectionTitle(
          title: 'Recent Activity',
          subtitle:
              'Monitor your latest financial and AI interactions.',
          actionText: 'View All',
          onActionTap: () {},
        ),

        const SizedBox(height: 24),

        /// ACTIVITIES LIST
        Column(
          children: [

            /// ACTIVITY 1
            RecentActivityTile(
              title: 'Invoice Uploaded',
              subtitle:
                  'Freelance project invoice uploaded successfully.',
              time: '2 min ago',

              icon:
                  Icons.upload_file_rounded,

              iconColor:
                  AppColors.primary,

              status: 'Processed',

              statusColor:
                  AppColors.success,
            ),

            const SizedBox(height: 18),

            /// ACTIVITY 2
            RecentActivityTile(
              title: 'Tax Report Generated',
              subtitle:
                  'Monthly financial report generated successfully.',
              time: '1 hour ago',

              icon:
                  Icons.analytics_outlined,

              iconColor:
                  AppColors.chartPurple,

              status: 'Completed',

              statusColor:
                  AppColors.success,
            ),

            const SizedBox(height: 18),

            /// ACTIVITY 3
            RecentActivityTile(
              title: 'Expense Added',
              subtitle:
                  'Office subscription expense added to records.',
              time: '3 hours ago',

              icon:
                  Icons.account_balance_wallet_outlined,

              iconColor:
                  AppColors.chartOrange,

              status: 'Updated',

              statusColor:
                  AppColors.info,
            ),

            const SizedBox(height: 18),

            /// ACTIVITY 4
            RecentActivityTile(
              title: 'AI Tax Insight',
              subtitle:
                  'TaxPilot AI suggested possible deduction savings.',
              time: 'Yesterday',

              icon:
                  Icons.auto_awesome,

              iconColor:
                  AppColors.taxHighlight,

              status: 'New',

              statusColor:
                  AppColors.warning,
            ),
          ],
        ),
      ],
    );
  }
}