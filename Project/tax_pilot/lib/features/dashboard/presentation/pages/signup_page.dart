import 'package:flutter/material.dart';
import 'package:tax_pilot/core/router/app_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/auth_form_field.dart';
import '../../../../core/widgets/primary_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() =>
      _SignupPageState();
}

class _SignupPageState
    extends State<SignupPage> {
  final TextEditingController
      fullNameController =
      TextEditingController();

  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  final TextEditingController
      confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width;

    final bool isMobile =
        screenWidth < 700;

    return Scaffold(
      backgroundColor:
          const Color.fromRGBO(
        241,
        245,
        249,
        1,
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal:
                  isMobile ? 20 : 32,
              vertical: 24,
            ),

            child: Container(
              width: double.infinity,

              constraints:
                  const BoxConstraints(
                maxWidth: 460,
              ),

              padding:
                  EdgeInsets.symmetric(
                horizontal:
                    isMobile ? 24 : 40,
                vertical:
                    isMobile ? 28 : 42,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                        18),

                border: Border.all(
                  color:
                      const Color.fromRGBO(
                    226,
                    232,
                    240,
                    1,
                  ),
                ),

                boxShadow: const [
                  BoxShadow(
                    color:
                        Color.fromRGBO(
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
                    CrossAxisAlignment
                        .start,

                children: [
                  // =====================================
                  // LOGO
                  // =====================================

                  Container(
                    width: 56,
                    height: 56,

                    decoration:
                        BoxDecoration(
                      color: AppColors
                          .primary
                          .withValues(
                            alpha: 0.10,
                          ),

                      borderRadius:
                          BorderRadius
                              .circular(
                        14,
                      ),
                    ),

                    child: const Icon(
                      Icons
                          .account_balance_wallet_rounded,

                      color:
                          AppColors.primary,

                      size: 28,
                    ),
                  ),

                  const SizedBox(
                      height: 28),

                  // =====================================
                  // TITLE
                  // =====================================

                  Text(
                    'Create Account',

                    style:
                        AppTextStyles
                            .heading1
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

                  const SizedBox(
                      height: 10),

                  Text(
                    'Create your TaxPilot account and start managing freelance taxes professionally.',

                    style:
                        AppTextStyles
                            .bodyMedium
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

                  const SizedBox(
                      height: 36),

                  // =====================================
                  // FULL NAME
                  // =====================================

                  Text(
                    'Full Name',

                    style:
                        AppTextStyles
                            .textFieldLabel
                            .copyWith(
                      color:
                          const Color
                              .fromRGBO(
                        51,
                        65,
                        85,
                        1,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 12),

                  Container(
                    decoration:
                        BoxDecoration(
                      borderRadius:
                          BorderRadius
                              .circular(
                        12,
                      ),

                      border: Border.all(
                        color:
                            const Color
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
                          fullNameController,

                      hintText:
                          'Enter your full name',

                      prefixIcon:
                          const Icon(
                        Icons
                            .person_outline_rounded,

                        color:
                            Color.fromRGBO(
                          100,
                          116,
                          139,
                          1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 24),

                  // =====================================
                  // EMAIL
                  // =====================================

                  Text(
                    'Email Address',

                    style:
                        AppTextStyles
                            .textFieldLabel
                            .copyWith(
                      color:
                          const Color
                              .fromRGBO(
                        51,
                        65,
                        85,
                        1,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 12),

                  Container(
                    decoration:
                        BoxDecoration(
                      borderRadius:
                          BorderRadius
                              .circular(
                        12,
                      ),

                      border: Border.all(
                        color:
                            const Color
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

                      prefixIcon:
                          const Icon(
                        Icons
                            .mail_outline_rounded,

                        color:
                            Color.fromRGBO(
                          100,
                          116,
                          139,
                          1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 24),

                  // =====================================
                  // PASSWORD
                  // =====================================

                  Text(
                    'Password',

                    style:
                        AppTextStyles
                            .textFieldLabel
                            .copyWith(
                      color:
                          const Color
                              .fromRGBO(
                        51,
                        65,
                        85,
                        1,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 12),

                  Container(
                    decoration:
                        BoxDecoration(
                      borderRadius:
                          BorderRadius
                              .circular(
                        12,
                      ),

                      border: Border.all(
                        color:
                            const Color
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
                          'Create password',

                      isPassword: true,

                      prefixIcon:
                          const Icon(
                        Icons
                            .lock_outline_rounded,

                        color:
                            Color.fromRGBO(
                          100,
                          116,
                          139,
                          1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 24),

                  // =====================================
                  // CONFIRM PASSWORD
                  // =====================================

                  Text(
                    'Confirm Password',

                    style:
                        AppTextStyles
                            .textFieldLabel
                            .copyWith(
                      color:
                          const Color
                              .fromRGBO(
                        51,
                        65,
                        85,
                        1,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 12),

                  Container(
                    decoration:
                        BoxDecoration(
                      borderRadius:
                          BorderRadius
                              .circular(
                        12,
                      ),

                      border: Border.all(
                        color:
                            const Color
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
                          confirmPasswordController,

                      hintText:
                          'Re-enter password',

                      isPassword: true,

                      prefixIcon:
                          const Icon(
                        Icons
                            .shield_outlined,

                        color:
                            Color.fromRGBO(
                          100,
                          116,
                          139,
                          1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 32),

                  // =====================================
                  // CREATE ACCOUNT BUTTON
                  // =====================================

                  PrimaryButton(
                    title:
                        'Create Account',

                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.onboarding);
                    },
                  ),

                  const SizedBox(
                      height: 28),

                  // =====================================
                  // DIVIDER
                  // =====================================

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,

                          color:
                              const Color
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
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          height: 1,

                          color:
                              const Color
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

                  const SizedBox(
                      height: 28),

                  // =====================================
                  // GOOGLE BUTTON
                  // =====================================

                  Container(
                    height: 56,

                    decoration:
                        BoxDecoration(
                      color:
                          const Color
                              .fromRGBO(
                        248,
                        250,
                        252,
                        1,
                      ),

                      borderRadius:
                          BorderRadius
                              .circular(
                        14,
                      ),

                      border: Border.all(
                        color:
                            const Color
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
                          Icons
                              .g_mobiledata_rounded,

                          color:
                              Color.fromRGBO(
                            15,
                            23,
                            42,
                            1,
                          ),

                          size: 34,
                        ),

                        const SizedBox(
                            width: 8),

                        Text(
                          'Continue with Google',

                          style:
                              AppTextStyles
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

                  const SizedBox(
                      height: 28),

                  // =====================================
                  // LOGIN REDIRECT
                  // =====================================

                  Center(
                    child: Wrap(
                      alignment:
                          WrapAlignment
                              .center,

                      crossAxisAlignment:
                          WrapCrossAlignment
                              .center,

                      children: [
                        Text(
                          'Already have an account?',

                          style:
                              AppTextStyles
                                  .bodyMedium
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

                        const SizedBox(
                            width: 6),

                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context);
                          },

                          child: Text(
                            'Login',

                            style:
                                AppTextStyles
                                    .bodyMedium
                                    .copyWith(
                              color:
                                  AppColors
                                      .primary,

                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}