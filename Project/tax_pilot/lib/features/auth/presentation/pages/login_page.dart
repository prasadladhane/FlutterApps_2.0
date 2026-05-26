import 'package:flutter/material.dart';
import 'package:tax_pilot/core/widgets/auth_form_field.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
// import '../widgets/auth_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth < 700;

    return Scaffold(
      backgroundColor:
          const Color.fromRGBO(241, 245, 249, 1),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 32,
              vertical: 24,
            ),

            child: Container(
              width: double.infinity,

              constraints: const BoxConstraints(
                maxWidth: 460,
              ),

              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 40,
                vertical: isMobile ? 28 : 42,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(18),

                border: Border.all(
                  color: const Color.fromRGBO(
                    226,
                    232,
                    240,
                    1,
                  ),
                ),

                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(
                      15,
                      23,
                      42,
                      0.06,
                    ),
                    blurRadius: 24,
                    offset: Offset(0, 10),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  // ==================================
                  // LOGO
                  // ==================================

                  Container(
                    width: 56,
                    height: 56,

                    decoration: BoxDecoration(
                      color: AppColors.primary
                          .withValues(alpha: 0.10),

                      borderRadius:
                          BorderRadius.circular(
                              14),
                    ),

                    child: const Icon(
                      Icons.account_balance_rounded,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ==================================
                  // TITLE
                  // ==================================

                  Text(
                    'Welcome Back',
                    style: AppTextStyles
                        .heading1
                        .copyWith(
                      color: const Color.fromRGBO(
                        15,
                        23,
                        42,
                        1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Sign in to continue managing your taxes professionally.',
                    style: AppTextStyles
                        .bodyMedium
                        .copyWith(
                      color: const Color.fromRGBO(
                        100,
                        116,
                        139,
                        1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // ==================================
                  // EMAIL
                  // ==================================

                  Text(
                    'Email Address',
                    style: AppTextStyles
                        .textFieldLabel
                        .copyWith(
                      color: const Color.fromRGBO(
                        51,
                        65,
                        85,
                        1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(
                              12),
                      border: Border.all(
                        color: const Color
                            .fromRGBO(
                          203,
                          213,
                          225,
                          1,
                        ),
                      ),
                    ),
                    child: AuthFormField(
                      controller:
                          emailController,

                      hintText:
                          'Enter your email',

                      keyboardType:
                          TextInputType
                              .emailAddress,

                      prefixIcon: const Icon(
                        Icons.mail_outline_rounded,
                        color: Color.fromRGBO(
                          100,
                          116,
                          139,
                          1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ==================================
                  // PASSWORD
                  // ==================================

                  Text(
                    'Password',
                    style: AppTextStyles
                        .textFieldLabel
                        .copyWith(
                      color: const Color.fromRGBO(
                        51,
                        65,
                        85,
                        1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(
                              12),
                      border: Border.all(
                        color: const Color
                            .fromRGBO(
                          203,
                          213,
                          225,
                          1,
                        ),
                      ),
                    ),
                    child: AuthFormField(
                      controller:
                          passwordController,

                      hintText:
                          'Enter your password',

                      isPassword: true,

                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: Color.fromRGBO(
                          100,
                          116,
                          139,
                          1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment:
                        Alignment.centerRight,

                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles
                          .bodySmall
                          .copyWith(
                        color:
                            AppColors.primary,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ==================================
                  // LOGIN BUTTON
                  // ==================================

                  PrimaryButton(
                    title: 'Login',
                    onTap: () {},
                  ),

                  const SizedBox(height: 28),

                  // ==================================
                  // DIVIDER
                  // ==================================

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color
                              .fromRGBO(
                            226,
                            232,
                            240,
                            1,
                          ),
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 14,
                        ),

                        child: Text(
                          'OR',
                          style: AppTextStyles
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
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color
                              .fromRGBO(
                            226,
                            232,
                            240,
                            1,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ==================================
                  // GOOGLE BUTTON
                  // ==================================

                  Container(
                    height: 56,

                    decoration: BoxDecoration(
                      color: const Color
                          .fromRGBO(
                        248,
                        250,
                        252,
                        1,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                              14),

                      border: Border.all(
                        color: const Color
                            .fromRGBO(
                          226,
                          232,
                          240,
                          1,
                        ),
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [
                        const Icon(
                          Icons.g_mobiledata_rounded,
                          color: Color.fromRGBO(
                            15,
                            23,
                            42,
                            1,
                          ),
                          size: 34,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          'Continue with Google',
                          style: AppTextStyles
                              .buttonText
                              .copyWith(
                            color:
                                const Color
                                    .fromRGBO(
                              15,
                              23,
                              42,
                              1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ==================================
                  // SIGNUP
                  // ==================================

                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment:
                          WrapCrossAlignment.center,
                    
                      children: [
                        Text(
                          'Don’t have an account?',
                          style: AppTextStyles.bodyMedium
                              .copyWith(
                            color: const Color.fromRGBO(
                              100,
                              116,
                              139,
                              1,
                            ),
                          ),
                        ),
                    
                        const SizedBox(width: 6),
                    
                        Text(
                          'Create Account',
                          style: AppTextStyles.bodyMedium
                              .copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
