import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class RecentActivityTile extends StatelessWidget {

  final String title;
  final String subtitle;
  final String time;

  final String status;
  final Color statusColor;

  final IconData icon;
  final Color iconColor;

  const RecentActivityTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: AppColors.cardBackground,

        borderRadius: BorderRadius.circular(24),

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

          /// ICON CONTAINER
          Container(
            width: 58,
            height: 58,

            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),

              borderRadius: BorderRadius.circular(18),
            ),

            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),

          const SizedBox(width: 18),

          /// TEXT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                /// TOP ROW
                Row(
                  children: [

                    Expanded(
                      child: Text(
                        title,
                        style:
                            AppTextStyles.cardTitle.copyWith(
                          fontSize: 17,
                        ),
                      ),
                    ),

                    /// STATUS BADGE
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color:
                            statusColor.withOpacity(0.12),

                        borderRadius:
                            BorderRadius.circular(30),
                      ),

                      child: Text(
                        status,
                        style:
                            AppTextStyles.bodySmall.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// SUBTITLE
                Text(
                  subtitle,
                  style:
                      AppTextStyles.bodySmall.copyWith(
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 14),

                /// TIME ROW
                Row(
                  children: [

                    const Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: AppColors.secondaryText,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      time,
                      style:
                          AppTextStyles.bodySmall.copyWith(
                        color:
                            AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}