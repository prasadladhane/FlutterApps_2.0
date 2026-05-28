import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../ai_assistant/presentation/pages/ai_assistant_page.dart';
import '../../../finance/presentation/pages/expense_page.dart';
import '../../../finance/presentation/pages/income_page.dart';
import '../../../reports/presentation/pages/reports_page.dart';
import '../../../tax/presentation/pages/tax_calculator_page.dart';
import '../../../uploads/presentation/pages/upload_bills_page.dart';
import 'dashboard_section_title.dart';
import 'quick_action_card.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// SECTION TITLE
        DashboardSectionTitle(
          title: 'Quick Actions',
          subtitle:
              'Access your most important financial tools quickly.',
          actionText: 'View All',
          onActionTap: () {},
        ),

        const SizedBox(height: 24),

        /// RESPONSIVE GRID
        LayoutBuilder(
          builder: (context, constraints) {

            int crossAxisCount = 2;

            if (constraints.maxWidth > 1400) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 900) {
              crossAxisCount = 3;
            }

            return GridView(
              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,

                crossAxisSpacing: 20,
                mainAxisSpacing: 20,

                childAspectRatio: 1.25,
              ),

              children: [

                /// AI ASSISTANT
                QuickActionCard(
                  title: 'AI Assistant',
                  subtitle:
                      'Smart financial and tax guidance',
                  icon: Icons.auto_awesome,
                  iconColor: AppColors.primary,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const AiAssistantPage(),
                      ),
                    );
                  },
                ),

                /// INCOME
                QuickActionCard(
                  title: 'Income',
                  subtitle:
                      'Track salary, freelance and business income',
                  icon: Icons.trending_up_rounded,
                  iconColor: AppColors.chartGreen,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const IncomePage(),
                      ),
                    );
                  },
                ),

                /// EXPENSES
                QuickActionCard(
                  title: 'Expenses',
                  subtitle:
                      'Manage spending and financial records',
                  icon:
                      Icons.account_balance_wallet_outlined,
                  iconColor: AppColors.chartOrange,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ExpensePage(),
                      ),
                    );
                  },
                ),

                /// REPORTS
                QuickActionCard(
                  title: 'Reports',
                  subtitle:
                      'Analyze taxes, GST and analytics',
                  icon: Icons.analytics_outlined,
                  iconColor: AppColors.chartPurple,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ReportsPage(),
                      ),
                    );
                  },
                ),

                /// TAX CALCULATOR
                QuickActionCard(
                  title: 'Tax Calculator',
                  subtitle:
                      'Estimate tax liabilities and deductions',
                  icon: Icons.receipt_long_outlined,
                  iconColor: AppColors.taxHighlight,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const TaxCalculatorPage(),
                      ),
                    );
                  },
                ),

                /// UPLOAD BILLS
                QuickActionCard(
                  title: 'Upload Bills',
                  subtitle:
                      'Upload invoices and financial documents',
                  icon: Icons.upload_file_rounded,
                  iconColor: AppColors.info,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const UploadBillsPage(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}