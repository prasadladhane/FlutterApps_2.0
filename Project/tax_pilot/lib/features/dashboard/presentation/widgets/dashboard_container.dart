import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class DashboardContainer extends StatelessWidget {

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const DashboardContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: margin,

      padding: padding ??
          const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: AppColors.cardBackground,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(
          color: AppColors.border,
        ),

        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),

      child: child,
    );
  }
}