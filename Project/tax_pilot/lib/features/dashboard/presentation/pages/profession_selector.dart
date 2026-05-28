import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ProfessionSelector extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const ProfessionSelector({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 180),

        width: 250,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 22,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
                  .withValues(alpha: 0.08)
              : Colors.white,

          borderRadius:
              BorderRadius.circular(16),

          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : const Color.fromRGBO(
                    226,
                    232,
                    240,
                    1,
                  ),
          ),

          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.primary
                    .withValues(alpha: 0.08),

                blurRadius: 18,

                offset: const Offset(
                  0,
                  8,
                ),
              ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // =====================================
            // ICON
            // =====================================

            Container(
              width: 48,
              height: 48,

              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                        .withValues(
                        alpha: 0.12,
                      )
                    : const Color.fromRGBO(
                        248,
                        250,
                        252,
                        1,
                      ),

                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),

              child: Icon(
                icon,

                color: isSelected
                    ? AppColors.primary
                    : const Color.fromRGBO(
                        100,
                        116,
                        139,
                        1,
                      ),

                size: 24,
              ),
            ),

            const SizedBox(height: 22),

            // =====================================
            // TITLE
            // =====================================

            Text(
              title,

              style:
                  AppTextStyles.bodyLarge
                      .copyWith(
                color: isSelected
                    ? AppColors.primary
                    : const Color.fromRGBO(
                        15,
                        23,
                        42,
                        1,
                      ),

                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            // =====================================
            // SUBTITLE
            // =====================================

            Text(
              'Optimised tax guidance for your profession.',

              style:
                  AppTextStyles.bodySmall
                      .copyWith(
                color:
                    const Color.fromRGBO(
                  100,
                  116,
                  139,
                  1,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // =====================================
            // SELECTED INDICATOR
            // =====================================

            Row(
              children: [

                Container(
                  width: 20,
                  height: 20,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : const Color
                              .fromRGBO(
                              203,
                              213,
                              225,
                              1,
                            ),

                      width: 2,
                    ),
                  ),

                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 10,
                            height: 10,

                            decoration:
                                const BoxDecoration(
                              shape:
                                  BoxShape.circle,

                              color:
                                  AppColors
                                      .primary,
                            ),
                          ),
                        )
                      : null,
                ),

                const SizedBox(width: 10),

                Text(
                  isSelected
                      ? 'Selected'
                      : 'Select',

                  style:
                      AppTextStyles.bodySmall
                          .copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : const Color
                            .fromRGBO(
                            100,
                            116,
                            139,
                            1,
                          ),

                    fontWeight:
                        FontWeight.w600,
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