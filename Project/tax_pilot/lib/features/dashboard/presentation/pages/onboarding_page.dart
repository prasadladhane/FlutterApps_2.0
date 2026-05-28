import 'package:flutter/material.dart';
import 'package:tax_pilot/core/router/app_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() =>
      _OnboardingPageState();
}

class _OnboardingPageState
    extends State<OnboardingPage> {

  // =======================================================
  // STEP CONTROL
  // =======================================================

  int currentStep = 0;

  // =======================================================
  // SELECTED VALUES
  // =======================================================

  String selectedProfession = '';

  String selectedIncomeRange = '';

  String selectedRegime = '';

  bool isGstRegistered = false;

  // =======================================================
  // DATA
  // =======================================================

  final List<String> professions = [
    'Freelance Developer',
    'Designer',
    'Content Creator',
    'Consultant',
    'Tutor / Coach',
  ];

  final List<String> incomeRanges = [
    'Below ₹5 Lakhs',
    '₹5L - ₹10L',
    '₹10L - ₹20L',
    '₹20L - ₹50L',
    'Above ₹50L',
  ];

  final List<String> regimes = [
    'New Regime',
    'Old Regime',
    'Help Me Decide',
  ];

  // =======================================================
  // NEXT STEP
  // =======================================================

 void nextStep() {

  // =========================================
  // STEP 1 VALIDATION
  // =========================================

  if (currentStep == 0 &&
      selectedProfession.isEmpty) {

    showValidationMessage(
      'Please select your profession.',
    );

    return;
  }

  // =========================================
  // STEP 2 VALIDATION
  // =========================================

  if (currentStep == 1 &&
      selectedIncomeRange.isEmpty) {

    showValidationMessage(
      'Please select your income range.',
    );

    return;
  }

  // =========================================
  // STEP 3 VALIDATION
  // =========================================

  if (currentStep == 2 &&
      selectedRegime.isEmpty) {

    showValidationMessage(
      'Please select a tax regime.',
    );

    return;
  }

  // =========================================
  // NEXT STEP
  // =========================================

  if (currentStep < 3) {

    setState(() {
      currentStep++;
    });

  } else {

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.dashboard,
      (route) => false,
    );
  }
}
  // =======================================================
  // PREVIOUS STEP
  // =======================================================

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void showValidationMessage(
  String message,
) {
  ScaffoldMessenger.of(context)
      .showSnackBar(
    SnackBar(
      content: Text(message),

      backgroundColor:
          AppColors.error,

      behavior:
          SnackBarBehavior.floating,
    ),
  );
}

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
                maxWidth: 650,
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
                  // HEADER
                  // =====================================

                  Container(
                    width: 58,
                    height: 58,

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
                        16,
                      ),
                    ),

                    child: const Icon(
                      Icons
                          .auto_awesome_rounded,

                      color:
                          AppColors.primary,

                      size: 30,
                    ),
                  ),

                  const SizedBox(
                      height: 28),

                  Text(
                    'Setup Your Tax Profile',

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
                    'Personalise TaxPilot based on your freelance income and tax preferences.',

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
                      height: 32),

                  // =====================================
                  // PROGRESS BAR
                  // =====================================

                  Row(
                    children: List.generate(
                      4,
                      (index) {
                        return Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(
                              right: index == 3
                                  ? 0
                                  : 8,
                            ),

                            height: 6,

                            decoration:
                                BoxDecoration(
                              color: index <=
                                      currentStep
                                  ? AppColors
                                      .primary
                                  : const Color
                                      .fromRGBO(
                                      226,
                                      232,
                                      240,
                                      1,
                                    ),

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                20,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                      height: 42),

                  // =====================================
                  // STEP CONTENT
                  // =====================================

                  buildStepContent(),

                  const SizedBox(
                      height: 42),

                  // =====================================
                  // BUTTONS
                  // =====================================

                  Row(
                    children: [

                      // BACK BUTTON

                      if (currentStep > 0)
                        Expanded(
                          child: GestureDetector(
                            onTap:
                                previousStep,

                            child: Container(
                              height: 56,

                              alignment:
                                  Alignment
                                      .center,

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

                                border:
                                    Border.all(
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

                              child: Text(
                                'Back',

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
                            ),
                          ),
                        ),

                      if (currentStep > 0)
                        const SizedBox(
                            width: 16),

                      // NEXT BUTTON

                      Expanded(
                        child: PrimaryButton(
                          title:
                              currentStep == 3
                                  ? 'Finish Setup'
                                  : 'Continue',

                          onTap: nextStep,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =======================================================
  // STEP UI
  // =======================================================

  Widget buildStepContent() {

    switch (currentStep) {

      // ===================================================
      // PROFESSION
      // ===================================================

      case 0:
        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              'What do you do?',

              style:
                  AppTextStyles.heading3
                      .copyWith(
                color:
                    const Color.fromRGBO(
                  15,
                  23,
                  42,
                  1,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'Select your primary freelance profession.',

              style:
                  AppTextStyles.bodyMedium,
            ),

            const SizedBox(height: 28),

            Wrap(
              spacing: 16,
              runSpacing: 16,

              children: professions.map(
                (profession) {

                  final bool isSelected =
                      selectedProfession ==
                          profession;

                  return selectionCard(
                    title: profession,

                    isSelected:
                        isSelected,

                    onTap: () {
                      setState(() {
                        selectedProfession =
                            profession;
                      });
                    },
                  );
                },
              ).toList(),
            ),
          ],
        );

      // ===================================================
      // INCOME RANGE
      // ===================================================

      case 1:
        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              'Expected Annual Income',

              style:
                  AppTextStyles.heading3
                      .copyWith(
                color:
                    const Color.fromRGBO(
                  15,
                  23,
                  42,
                  1,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'Choose the closest annual income range.',

              style:
                  AppTextStyles.bodyMedium,
            ),

            const SizedBox(height: 28),

            Column(
              children:
                  incomeRanges.map(
                (income) {

                  final bool isSelected =
                      selectedIncomeRange ==
                          income;

                  return Padding(
                    padding:
                        const EdgeInsets.only(
                      bottom: 16,
                    ),

                    child: selectionTile(
                      title: income,

                      isSelected:
                          isSelected,

                      onTap: () {
                        setState(() {
                          selectedIncomeRange =
                              income;
                        });
                      },
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        );

      // ===================================================
      // TAX REGIME
      // ===================================================

      case 2:
        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              'Tax Regime Preference',

              style:
                  AppTextStyles.heading3
                      .copyWith(
                color:
                    const Color.fromRGBO(
                  15,
                  23,
                  42,
                  1,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'Choose your preferred tax regime.',

              style:
                  AppTextStyles.bodyMedium,
            ),

            const SizedBox(height: 28),

            Column(
              children:
                  regimes.map(
                (regime) {

                  final bool isSelected =
                      selectedRegime ==
                          regime;

                  return Padding(
                    padding:
                        const EdgeInsets.only(
                      bottom: 16,
                    ),

                    child: selectionTile(
                      title: regime,

                      isSelected:
                          isSelected,

                      onTap: () {
                        setState(() {
                          selectedRegime =
                              regime;
                        });
                      },
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        );

      // ===================================================
      // GST
      // ===================================================

      default:
        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              'GST Registration Status',

              style:
                  AppTextStyles.heading3
                      .copyWith(
                color:
                    const Color.fromRGBO(
                  15,
                  23,
                  42,
                  1,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'Tell us whether you are GST registered.',

              style:
                  AppTextStyles.bodyMedium,
            ),

            const SizedBox(height: 28),

            selectionTile(
              title: 'Yes, I am GST Registered',

              isSelected:
                  isGstRegistered,

              onTap: () {
                setState(() {
                  isGstRegistered = true;
                });
              },
            ),

            const SizedBox(height: 16),

            selectionTile(
              title:
                  'No, I am not GST Registered',

              isSelected:
                  !isGstRegistered,

              onTap: () {
                setState(() {
                  isGstRegistered = false;
                });
              },
            ),
          ],
        );
    }
  }

  // =======================================================
  // SELECTION CARD
  // =======================================================

  Widget selectionCard({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
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
        ),

        child: Text(
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
      ),
    );
  }

  // =======================================================
  // SELECTION TILE
  // =======================================================

  Widget selectionTile({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 180),

        width: double.infinity,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
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
        ),

        child: Row(
          children: [

            Expanded(
              child: Text(
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
            ),

            Container(
              width: 22,
              height: 22,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : const Color.fromRGBO(
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
                              AppColors.primary,
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