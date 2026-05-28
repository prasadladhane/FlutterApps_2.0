import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ProfileAvatar extends StatelessWidget {

  final String userName;
  final String? imageUrl;
  final bool isPremium;
  final VoidCallback? onTap;

  const ProfileAvatar({
    super.key,
    required this.userName,
    this.imageUrl,
    this.isPremium = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: AppColors.cardBackground,

          borderRadius: BorderRadius.circular(20),

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
          mainAxisSize: MainAxisSize.min,
          children: [

            /// AVATAR
            Stack(
              children: [

                Container(
                  width: 52,
                  height: 52,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: AppColors.primary.withOpacity(0.15),

                    image: imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),

                  child: imageUrl == null
                      ? Center(
                          child: Text(
                            userName.isNotEmpty
                                ? userName[0].toUpperCase()
                                : 'U',

                            style:
                                AppTextStyles.heading3.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      : null,
                ),

                /// ONLINE INDICATOR
                Positioned(
                  right: 2,
                  bottom: 2,

                  child: Container(
                    width: 14,
                    height: 14,

                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,

                      border: Border.all(
                        color: AppColors.cardBackground,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 14),

            /// USER INFO
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// USER NAME
                Text(
                  userName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                /// ACCOUNT TYPE
                Row(
                  children: [

                    Icon(
                      isPremium
                          ? Icons.workspace_premium_rounded
                          : Icons.person_outline_rounded,

                      size: 16,

                      color: isPremium
                          ? AppColors.gstHighlight
                          : AppColors.secondaryText,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      isPremium
                          ? 'Premium User'
                          : 'Standard User',

                      style: AppTextStyles.bodySmall.copyWith(
                        color: isPremium
                            ? AppColors.gstHighlight
                            : AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(width: 12),

            /// DROPDOWN ICON
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.secondaryText,
            ),
          ],
        ),
      ),
    );
  }
}