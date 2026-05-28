import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';

class DashboardShimmerLoader extends StatelessWidget {
  const DashboardShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {

    return Shimmer.fromColors(
      baseColor: AppColors.secondaryCardBackground,
      highlightColor: AppColors.glassEffect,

      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER SHIMMER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    _shimmerBox(
                      width: 120,
                      height: 16,
                      radius: 10,
                    ),

                    const SizedBox(height: 14),

                    _shimmerBox(
                      width: 220,
                      height: 28,
                      radius: 12,
                    ),
                  ],
                ),

                _shimmerCircle(54),
              ],
            ),

            const SizedBox(height: 32),

            /// MAIN CARD SHIMMER
            _shimmerBox(
              width: double.infinity,
              height: 220,
              radius: 28,
            ),

            const SizedBox(height: 32),

            /// SECTION TITLE
            _shimmerBox(
              width: 180,
              height: 22,
              radius: 12,
            ),

            const SizedBox(height: 22),

            /// QUICK ACTION GRID
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              itemCount: 4,

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: 1.15,
              ),

              itemBuilder: (context, index) {

                return _shimmerBox(
                  width: double.infinity,
                  height: 150,
                  radius: 24,
                );
              },
            ),

            const SizedBox(height: 32),

            /// AI CARD SHIMMER
            _shimmerBox(
              width: double.infinity,
              height: 180,
              radius: 24,
            ),

            const SizedBox(height: 32),

            /// RECENT ACTIVITY TITLE
            _shimmerBox(
              width: 190,
              height: 22,
              radius: 12,
            ),

            const SizedBox(height: 22),

            /// ACTIVITY LIST
            Column(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),

                  child: _shimmerBox(
                    width: double.infinity,
                    height: 90,
                    radius: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // SHIMMER BOX
  // =========================================================

  Widget _shimmerBox({
    required double width,
    required double height,
    required double radius,
  }) {

    return Container(
      width: width,
      height: height,

      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  // =========================================================
  // SHIMMER CIRCLE
  // =========================================================

  Widget _shimmerCircle(double size) {

    return Container(
      width: size,
      height: size,

      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        shape: BoxShape.circle,
      ),
    );
  }
}