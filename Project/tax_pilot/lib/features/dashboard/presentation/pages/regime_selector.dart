import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class RegimeSelector extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const RegimeSelector({
    super.key,
    required this.title,
    required this.subtitle,
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

        width: double.infinity,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 22,
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

        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // =====================================
            // TEXT CONTENT
            // =====================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  // TITLE

                  Text(
                    title,

                    style:
                        AppTextStyles
                            .bodyLarge
                            .copyWith(
                      color: isSelected
                          ? AppColors
                              .primary
                          : const Color
                              .fromRGBO(
                              15,
                              23,
                              42,
                              1,
                            ),

                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  const SizedBox(
                      height: 10),

                  // SUBTITLE

                  Text(
                    subtitle,

                    style:
                        AppTextStyles
                            .bodySmall
                            .copyWith(
                      color:
                          const Color
                              .fromRGBO(
                        100,
                        116,
                        139,
                        1,
                      ),

                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 18),

            // =====================================
            // RADIO INDICATOR
            // =====================================

            Container(
              width: 22,
              height: 22,

              margin:
                  const EdgeInsets.only(
                top: 2,
              ),

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
          ],
        ),
      ),
    );
  }
}