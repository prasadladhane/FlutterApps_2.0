import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class GreetingText extends StatelessWidget {

  final String userName;

  const GreetingText({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {

    final hour = DateTime.now().hour;

    String greeting;

    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// GREETING
        Text(
          '$greeting 👋',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.secondaryText,
          ),
        ),

        const SizedBox(height: 8),

        /// USER NAME
        Text(
          userName,
          style: AppTextStyles.heading2,
        ),

        const SizedBox(height: 10),

        /// SUBTITLE
        Text(
          'Track your finances, taxes and AI insights seamlessly.',
          style: AppTextStyles.bodySmall.copyWith(
            height: 1.5,
          ),
        ),
      ],
    );
  }
}