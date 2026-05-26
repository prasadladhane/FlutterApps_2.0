import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class PrimaryButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final double? width;
  final double height;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.onTap,
    this.width,
    this.height = 56,
    this.isLoading = false,
    this.padding,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),

          width: widget.width,

          height: widget.height,

          alignment: Alignment.center,

          padding: widget.padding,

          decoration: BoxDecoration(
            color: widget.isLoading
                ? AppColors.buttonDisabled
                : isHovered
                    ? AppColors.buttonHover
                    : AppColors.buttonBackground,

            borderRadius: BorderRadius.circular(14),

            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: widget.isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: AppColors.whiteText,
                  ),
                )
              : Text(
                  widget.title,
                  style: AppTextStyles.buttonText,
                ),
        ),
      ),
    );
  }
}