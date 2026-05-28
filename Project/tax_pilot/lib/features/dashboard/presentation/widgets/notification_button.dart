import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class NotificationButton extends StatelessWidget {

  final int notificationCount;
  final VoidCallback? onTap;

  const NotificationButton({
    super.key,
    this.notificationCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Stack(
        clipBehavior: Clip.none,
        children: [

          /// MAIN BUTTON
          Container(
            width: 56,
            height: 56,

            decoration: BoxDecoration(
              color: AppColors.cardBackground,

              borderRadius: BorderRadius.circular(18),

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

            child: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.primaryText,
              size: 28,
            ),
          ),

          /// NOTIFICATION BADGE
          if (notificationCount > 0)
            Positioned(
              right: -2,
              top: -2,

              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 4,
                ),

                decoration: BoxDecoration(
                  color: AppColors.error,

                  borderRadius: BorderRadius.circular(20),

                  border: Border.all(
                    color: AppColors.scaffoldBackground,
                    width: 2,
                  ),
                ),

                constraints: const BoxConstraints(
                  minWidth: 22,
                  minHeight: 22,
                ),

                child: Center(
                  child: Text(
                    notificationCount > 99
                        ? '99+'
                        : notificationCount.toString(),

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}