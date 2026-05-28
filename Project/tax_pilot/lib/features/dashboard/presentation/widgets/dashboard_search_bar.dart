import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DashboardSearchBar extends StatelessWidget {

  final TextEditingController? controller;
  final VoidCallback? onFilterTap;

  const DashboardSearchBar({
    super.key,
    this.controller,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 64,

      decoration: BoxDecoration(
        color: AppColors.cardBackground,

        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: AppColors.border,
        ),

        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [

          /// SEARCH ICON
          const Padding(
            padding: EdgeInsets.only(
              left: 18,
            ),

            child: Icon(
              Icons.search_rounded,
              color: AppColors.secondaryText,
              size: 24,
            ),
          ),

          /// TEXT FIELD
          Expanded(
            child: TextField(
              controller: controller,

              style: AppTextStyles.bodyMedium,

              cursorColor: AppColors.primary,

              decoration: InputDecoration(
                hintText:
                    'Search transactions, invoices, reports...',

                hintStyle: AppTextStyles.bodySmall,

                border: InputBorder.none,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
              ),
            ),
          ),

          /// DIVIDER
          Container(
            width: 1,
            height: 28,
            color: AppColors.divider,
          ),

          /// FILTER BUTTON
          GestureDetector(
            onTap: onFilterTap,

            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),

              child: Row(
                children: [

                  const Icon(
                    Icons.tune_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    'Filters',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}