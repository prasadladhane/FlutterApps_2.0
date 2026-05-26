// import 'package:flutter/material.dart';

// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_text_styles.dart';

// class AuthFormField extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final bool isPassword;
//   final TextInputType keyboardType;
//   final Widget? prefixIcon;

//   const AuthFormField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     this.isPassword = false,
//     this.keyboardType = TextInputType.text,
//     this.prefixIcon,
//   });

//   @override
//   State<AuthFormField> createState() => _AuthFormFieldState();
// }

// class _AuthFormFieldState extends State<AuthFormField> {
//   bool obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: widget.controller,

//       obscureText: widget.isPassword ? obscureText : false,

//       keyboardType: widget.keyboardType,

//       style: AppTextStyles.textFieldText,

//       cursorColor: AppColors.primary,

//       decoration: InputDecoration(
//         hintText: widget.hintText,

//         hintStyle: AppTextStyles.textFieldHint,

//         prefixIcon: widget.prefixIcon,

//         prefixIconColor: AppColors.secondaryText,

//         suffixIcon: widget.isPassword
//             ? GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     obscureText = !obscureText;
//                   });
//                 },
//                 child: Icon(
//                   obscureText
//                       ? Icons.visibility_off_rounded
//                       : Icons.visibility_rounded,
//                   color: AppColors.secondaryText,
//                   size: 20,
//                 ),
//               )
//             : null,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class AuthFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final Widget? prefixIcon;

  const AuthFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
  });

  @override
  State<AuthFormField> createState() =>
      _AuthFormFieldState();
}

class _AuthFormFieldState
    extends State<AuthFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
  borderRadius: BorderRadius.circular(12),

  child: TextField(
    controller: widget.controller,

    obscureText:
        widget.isPassword ? obscureText : false,

    keyboardType: widget.keyboardType,

    cursorColor:
        const Color.fromRGBO(72, 118, 255, 1),

    style: const TextStyle(
      color: Color.fromRGBO(15, 23, 42, 1),
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),

    decoration: InputDecoration(
      filled: true,

      fillColor: Colors.white,

      hintText: widget.hintText,

      hintStyle: const TextStyle(
        color: Color.fromRGBO(148, 163, 184, 1),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),

      prefixIcon: widget.prefixIcon,

      border: InputBorder.none,

      enabledBorder: InputBorder.none,

      focusedBorder: InputBorder.none,

      disabledBorder: InputBorder.none,

      errorBorder: InputBorder.none,

      focusedErrorBorder:
          InputBorder.none,

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),

      suffixIcon: widget.isPassword
          ? GestureDetector(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },

              child: Icon(
                obscureText
                    ? Icons
                        .visibility_off_rounded
                    : Icons.visibility_rounded,

                color:
                    const Color.fromRGBO(
                  100,
                  116,
                  139,
                  1,
                ),

                size: 20,
              ),
            )
          : null,
    ),
  ),
);
  }
}