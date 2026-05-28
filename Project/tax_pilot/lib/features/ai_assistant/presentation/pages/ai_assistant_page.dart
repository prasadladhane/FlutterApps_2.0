import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class AiAssistantPage extends StatelessWidget {
  const AiAssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      body: SafeArea(
        child: Column(
          children: [

            /// TOP HEADER
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              child: Row(
                children: [

                  /// AI ICON
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// TITLE
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        'TaxPilot AI',
                        style: AppTextStyles.heading3,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Your smart financial assistant',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// HISTORY BUTTON
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.border,
                      ),
                    ),
                    child: const Icon(
                      Icons.history,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),

            /// CHAT AREA
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [

                  /// AI MESSAGE
                  _aiMessage(
                    'Hello Prasad 👋\n\n'
                    'I can help you with:\n'
                    '• Tax estimation\n'
                    '• Expense tracking\n'
                    '• Financial insights\n'
                    '• GST calculations\n'
                    '• Investment suggestions\n'
                    '• Budget planning',
                  ),

                  const SizedBox(height: 20),

                  /// USER MESSAGE
                  _userMessage(
                    'How much tax can I save this year?',
                  ),

                  const SizedBox(height: 20),

                  /// AI REPLY
                  _aiMessage(
                    'Based on your current financial activity, '
                    'you may reduce taxable income using '
                    'Section 80C and health insurance deductions.',
                  ),

                  const SizedBox(height: 20),

                  /// SUGGESTION CARDS
                  Text(
                    'Suggested Questions',
                    style: AppTextStyles.cardTitle,
                  ),

                  const SizedBox(height: 16),

                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [

                      _suggestionChip(
                        'Estimate my tax',
                      ),

                      _suggestionChip(
                        'Track expenses',
                      ),

                      _suggestionChip(
                        'GST help',
                      ),

                      _suggestionChip(
                        'Investment advice',
                      ),

                      _suggestionChip(
                        'Budget planning',
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),

            /// INPUT FIELD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.sidebarBackground,
                border: Border(
                  top: BorderSide(
                    color: AppColors.border,
                  ),
                ),
              ),
              child: Row(
                children: [

                  /// TEXT FIELD
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textFieldFill,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.textFieldBorder,
                        ),
                      ),
                      child: const TextField(
                        style: TextStyle(
                          color: AppColors.primaryText,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Ask TaxPilot AI...',
                          hintStyle: TextStyle(
                            color: AppColors.hintText,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// SEND BUTTON
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
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

  Widget _aiMessage(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 500,
        ),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Text(
          text,
          style: AppTextStyles.bodyMedium,
        ),
      ),
    );
  }

  Widget _userMessage(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _suggestionChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Text(
        title,
        style: AppTextStyles.bodySmall,
      ),
    );
  }
}