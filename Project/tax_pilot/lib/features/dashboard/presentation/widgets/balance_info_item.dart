import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class BalanceInfoItem extends StatelessWidget {

  final String title;
  final String amount;
  final IconData icon;
  final Color iconColor;

  const BalanceInfoItem({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: AppColors.secondaryCardBackground,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: AppColors.border,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TOP ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// TITLE
                Text(
                  title,
                  style: AppTextStyles.bodySmall,
                ),

                /// ICON
                Container(
                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// AMOUNT
            Text(
              amount,
              style: AppTextStyles.heading3.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            /// MINI STATUS
            Row(
              children: [

                Icon(
                  Icons.trending_up_rounded,
                  color: AppColors.success,
                  size: 16,
                ),

                const SizedBox(width: 6),

                Text(
                  '+8.2%',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}