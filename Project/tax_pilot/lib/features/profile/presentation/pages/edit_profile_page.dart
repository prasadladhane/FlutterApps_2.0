
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../dashboard/presentation/widgets/dashboard_container.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_title.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState
    extends State<EditProfilePage> {

  bool aiInsights = true;
  bool taxSuggestions = true;
  bool expenseDetection = false;

  final TextEditingController nameController =
      TextEditingController(
    text: 'Prasad Ladhane',
  );

  final TextEditingController emailController =
      TextEditingController(
    text: 'prasad@gmail.com',
  );

  final TextEditingController phoneController =
      TextEditingController(
    text: '+91 9876543210',
  );

  final TextEditingController professionController =
      TextEditingController(
    text:
        'Flutter Developer • Freelancer',
  );

  final TextEditingController gstController =
      TextEditingController(
    text: 'GST Not Registered',
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          AppColors.scaffoldBackground,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(
            AppSpacing.lg,
          ),

          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(
                maxWidth: 1100,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  // =====================================================
                  // HEADER
                  // =====================================================

                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment:
                        WrapAlignment
                            .spaceBetween,
                    crossAxisAlignment:
                        WrapCrossAlignment
                            .center,
                    children: [

                      SizedBox(
                        width: 500,

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [

                            Text(
                              'Edit Profile',
                              style:
                                  AppTextStyles
                                      .heading2,
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Text(
                              'Manage your TaxPilot profile, preferences and account settings.',
                              style:
                                  AppTextStyles
                                      .bodySmall,
                            ),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisSize:
                            MainAxisSize.min,
                        children: [

                          _headerButton(
                            title: 'Cancel',
                            icon:
                                Icons.close_rounded,
                            background:
                                AppColors
                                    .cardBackground,
                            textColor:
                                AppColors
                                    .secondaryText,
                            borderColor:
                                AppColors
                                    .border,
                          ),

                          const SizedBox(
                            width: 14,
                          ),

                          _headerButton(
                            title:
                                'Save Changes',
                            icon:
                                Icons.check_rounded,
                            background:
                                AppColors
                                    .primary,
                            textColor:
                                AppColors
                                    .whiteText,
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  // =====================================================
                  // PROFILE CARD
                  // =====================================================

                  DashboardContainer(
                    padding:
                        const EdgeInsets.all(
                      32,
                    ),

                    child: LayoutBuilder(
                      builder:
                          (
                            context,
                            constraints,
                          ) {

                        final bool isMobile =
                            constraints
                                    .maxWidth <
                                800;

                        return isMobile

                            ? Column(
                                children: [

                                  _profileAvatar(),

                                  const SizedBox(
                                    height:
                                        24,
                                  ),

                                  _profileInfo(),
                                ],
                              )

                            : Row(
                                children: [

                                  _profileAvatar(),

                                  const SizedBox(
                                    width:
                                        32,
                                  ),

                                  Expanded(
                                    child:
                                        _profileInfo(),
                                  ),
                                ],
                              );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  // =====================================================
                  // PERSONAL INFORMATION
                  // =====================================================

                  const DashboardSectionTitle(
                    title:
                        'Personal Information',
                    subtitle:
                        'Update your account details and profile information.',
                  ),

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  DashboardContainer(
                    child: LayoutBuilder(
                      builder:
                          (
                            context,
                            constraints,
                          ) {

                        final bool isMobile =
                            constraints
                                    .maxWidth <
                                750;

                        return Column(
                          children: [

                            isMobile
                                ? Column(
                                    children: [

                                      _buildTextField(
                                        label:
                                            'Full Name',
                                        hint:
                                            'Enter full name',
                                        controller:
                                            nameController,
                                        icon:
                                            Icons.person_outline_rounded,
                                      ),

                                      const SizedBox(
                                        height:
                                            20,
                                      ),

                                      _buildTextField(
                                        label:
                                            'Email Address',
                                        hint:
                                            'Enter email',
                                        controller:
                                            emailController,
                                        icon:
                                            Icons.email_outlined,
                                      ),
                                    ],
                                  )

                                : Row(
                                    children: [

                                      Expanded(
                                        child:
                                            _buildTextField(
                                          label:
                                              'Full Name',
                                          hint:
                                              'Enter full name',
                                          controller:
                                              nameController,
                                          icon:
                                              Icons.person_outline_rounded,
                                        ),
                                      ),

                                      const SizedBox(
                                        width:
                                            20,
                                      ),

                                      Expanded(
                                        child:
                                            _buildTextField(
                                          label:
                                              'Email Address',
                                          hint:
                                              'Enter email',
                                          controller:
                                              emailController,
                                          icon:
                                              Icons.email_outlined,
                                        ),
                                      ),
                                    ],
                                  ),

                            const SizedBox(
                              height: 20,
                            ),

                            isMobile
                                ? Column(
                                    children: [

                                      _buildTextField(
                                        label:
                                            'Phone Number',
                                        hint:
                                            'Enter phone number',
                                        controller:
                                            phoneController,
                                        icon:
                                            Icons.phone_outlined,
                                      ),

                                      const SizedBox(
                                        height:
                                            20,
                                      ),

                                      _buildTextField(
                                        label:
                                            'Profession',
                                        hint:
                                            'Enter profession',
                                        controller:
                                            professionController,
                                        icon:
                                            Icons.work_outline_rounded,
                                      ),
                                    ],
                                  )

                                : Row(
                                    children: [

                                      Expanded(
                                        child:
                                            _buildTextField(
                                          label:
                                              'Phone Number',
                                          hint:
                                              'Enter phone number',
                                          controller:
                                              phoneController,
                                          icon:
                                              Icons.phone_outlined,
                                        ),
                                      ),

                                      const SizedBox(
                                        width:
                                            20,
                                      ),

                                      Expanded(
                                        child:
                                            _buildTextField(
                                          label:
                                              'Profession',
                                          hint:
                                              'Enter profession',
                                          controller:
                                              professionController,
                                          icon:
                                              Icons.work_outline_rounded,
                                        ),
                                      ),
                                    ],
                                  ),

                            const SizedBox(
                              height: 20,
                            ),

                            _buildTextField(
                              label:
                                  'GST Status',
                              hint:
                                  'GST registration status',
                              controller:
                                  gstController,
                              icon:
                                  Icons.receipt_long_outlined,
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  // =====================================================
                  // AI SETTINGS
                  // =====================================================

                  const DashboardSectionTitle(
                    title:
                        'AI Preferences',
                    subtitle:
                        'Customize TaxPilot AI experience.',
                  ),

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  DashboardContainer(
                    child: Column(
                      children: [

                        _switchTile(
                          title:
                              'AI Financial Insights',
                          subtitle:
                              'Receive personalized AI-powered finance recommendations.',
                          value:
                              aiInsights,
                          onChanged:
                              (value) {

                            setState(() {
                              aiInsights =
                                  value;
                            });
                          },
                        ),

                        const Divider(
                          height: 36,
                          color:
                              AppColors
                                  .divider,
                        ),

                        _switchTile(
                          title:
                              'Smart Tax Suggestions',
                          subtitle:
                              'Enable intelligent deduction and tax saving suggestions.',
                          value:
                              taxSuggestions,
                          onChanged:
                              (value) {

                            setState(() {
                              taxSuggestions =
                                  value;
                            });
                          },
                        ),

                        const Divider(
                          height: 36,
                          color:
                              AppColors
                                  .divider,
                        ),

                        _switchTile(
                          title:
                              'Expense Pattern Detection',
                          subtitle:
                              'Automatically detect unusual expense patterns.',
                          value:
                              expenseDetection,
                          onChanged:
                              (value) {

                            setState(() {
                              expenseDetection =
                                  value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xl,
                  ),

                  // =====================================================
                  // SECURITY SETTINGS
                  // =====================================================

                  const DashboardSectionTitle(
                    title:
                        'Security Settings',
                    subtitle:
                        'Manage your password and account security.',
                  ),

                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  DashboardContainer(
                    child: Column(
                      children: [

                        _settingsTile(
                          title:
                              'Change Password',
                          subtitle:
                              'Update your account password securely.',
                          icon:
                              Icons.lock_outline_rounded,
                          iconColor:
                              AppColors
                                  .chartOrange,
                        ),

                        const SizedBox(
                          height: 18,
                        ),

                        _settingsTile(
                          title:
                              'Two-Factor Authentication',
                          subtitle:
                              'Add an extra layer of account protection.',
                          icon:
                              Icons.security_rounded,
                          iconColor:
                              AppColors
                                  .success,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.xxl,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // PROFILE AVATAR
  // =========================================================

  Widget _profileAvatar() {

    return Stack(
      children: [

        Container(
          width: 120,
          height: 120,

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                AppColors.primary
                    .withOpacity(0.1),
            border: Border.all(
              color:
                  AppColors.primary
                      .withOpacity(0.15),
              width: 3,
            ),
          ),

          child: Center(
            child: Text(
              'PL',
              style:
                  AppTextStyles
                      .heading2
                      .copyWith(
                color:
                    AppColors.primary,
                fontWeight:
                    FontWeight.w700,
              ),
            ),
          ),
        ),

        Positioned(
          right: 0,
          bottom: 0,

          child: Container(
            padding:
                const EdgeInsets.all(8),

            decoration: BoxDecoration(
              color:
                  AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    AppColors
                        .whiteText,
                width: 3,
              ),
            ),

            child: const Icon(
              Icons.camera_alt_outlined,
              size: 18,
              color:
                  AppColors.whiteText,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // PROFILE INFO
  // =========================================================

  Widget _profileInfo() {

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Text(
          'Prasad Ladhane',
          style:
              AppTextStyles.heading3,
        ),

        const SizedBox(height: 10),

        Text(
          'Flutter Developer • Freelancer • Finance Enthusiast',
          style:
              AppTextStyles.bodyMedium,
        ),

        const SizedBox(height: 20),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [

            _chip(
              title: 'Premium',
              color:
                  AppColors.gstHighlight,
            ),

            _chip(
              title: 'AI Enabled',
              color: AppColors.primary,
            ),

            _chip(
              title: 'Verified',
              color: AppColors.success,
            ),
          ],
        ),
      ],
    );
  }

  // =========================================================
  // HEADER BUTTON
  // =========================================================

  Widget _headerButton({
    required String title,
    required IconData icon,
    required Color background,
    required Color textColor,
    Color? borderColor,
  }) {

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),

      decoration: BoxDecoration(
        color: background,
        borderRadius:
            BorderRadius.circular(18),
        border: borderColor != null

            ? Border.all(
                color: borderColor,
              )

            : null,
        boxShadow: [
          BoxShadow(
            color:
                AppColors.shadow,
            blurRadius: 14,
            offset:
                const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [

          Icon(
            icon,
            size: 20,
            color: textColor,
          ),

          const SizedBox(width: 10),

          Text(
            title,
            style:
                AppTextStyles
                    .bodyMedium
                    .copyWith(
              color: textColor,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // INPUT FIELD
  // =========================================================

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController
        controller,
    required IconData icon,
  }) {

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style:
              AppTextStyles
                  .textFieldLabel,
        ),

        const SizedBox(height: 10),

        TextField(
          controller: controller,

          style:
              AppTextStyles
                  .textFieldText,

          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                AppTextStyles
                    .textFieldHint,

            prefixIcon: Icon(
              icon,
              color:
                  AppColors
                      .secondaryText,
            ),

            filled: true,
            fillColor:
                AppColors
                    .textFieldFill,

            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),

            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                18,
              ),

              borderSide:
                  const BorderSide(
                color:
                    AppColors
                        .border,
              ),
            ),

            enabledBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                18,
              ),

              borderSide:
                  const BorderSide(
                color:
                    AppColors
                        .border,
              ),
            ),

            focusedBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                18,
              ),

              borderSide:
                  const BorderSide(
                color:
                    AppColors
                        .primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // SWITCH TILE
  // =========================================================

  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>
        onChanged,
  }) {

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [

              Text(
                title,
                style:
                    AppTextStyles
                        .cardTitle,
              ),

              const SizedBox(height: 6),

              Text(
                subtitle,
                style:
                    AppTextStyles
                        .bodySmall,
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        Switch(
          value: value,
          activeColor:
              AppColors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // =========================================================
  // SETTINGS TILE
  // =========================================================

  Widget _settingsTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {

    return Container(
      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color:
            AppColors
                .secondaryCardBackground,
        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Row(
        children: [

          Container(
            width: 56,
            height: 56,

            decoration: BoxDecoration(
              color:
                  iconColor.withOpacity(
                0.12,
              ),

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            child: Icon(
              icon,
              color: iconColor,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [

                Text(
                  title,
                  style:
                      AppTextStyles
                          .cardTitle,
                ),

                const SizedBox(
                  height: 6,
                ),

                Text(
                  subtitle,
                  style:
                      AppTextStyles
                          .bodySmall,
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
            color:
                AppColors
                    .secondaryText,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CHIP
  // =========================================================

  Widget _chip({
    required String title,
    required Color color,
  }) {

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color:
            color.withOpacity(0.12),

        borderRadius:
            BorderRadius.circular(
          30,
        ),
      ),

      child: Text(
        title,
        style:
            AppTextStyles.bodySmall
                .copyWith(
          color: color,
          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }
}
