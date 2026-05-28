import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../dashboard/presentation/widgets/dashboard_container.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_title.dart';
import '../../../dashboard/presentation/widgets/profile_avatar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [

                  /// LEFT SIDE
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Text(
                        'Profile Settings',
                        style:
                            AppTextStyles.heading2,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Manage your TaxPilot account and preferences.',
                        style:
                            AppTextStyles.bodySmall,
                      ),
                    ],
                  ),

                  /// EDIT BUTTON
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),

                    decoration: BoxDecoration(
                      color:
                          AppColors.primary,

                      borderRadius:
                          BorderRadius.circular(
                              18),
                    ),

                    child: Row(
                      children: [

                        const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          'Edit Profile',
                          style:
                              AppTextStyles
                                  .bodySmall
                                  .copyWith(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              /// PROFILE OVERVIEW
              DashboardContainer(
                padding: const EdgeInsets.all(30),

                child: Row(
                  children: [

                    /// PROFILE IMAGE
                    const ProfileAvatar(
                      userName: 'Prasad',
                      isPremium: true,
                    ),

                    const SizedBox(width: 24),

                    /// USER INFO
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [

                          Text(
                            'Prasad Ladhane',
                            style:
                                AppTextStyles
                                    .heading3,
                          ),

                          const SizedBox(
                              height: 10),

                          Text(
                            'Flutter Developer • Freelancer • Finance Enthusiast',
                            style:
                                AppTextStyles
                                    .bodySmall
                                    .copyWith(
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(
                              height: 18),

                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [

                              _profileChip(
                                title:
                                    'Premium',
                                color:
                                    AppColors
                                        .gstHighlight,
                              ),

                              _profileChip(
                                title:
                                    'AI Enabled',
                                color:
                                    AppColors
                                        .primary,
                              ),

                              _profileChip(
                                title:
                                    'Verified',
                                color:
                                    AppColors
                                        .success,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// ACCOUNT SETTINGS
              DashboardSectionTitle(
                title: 'Account Settings',
                subtitle:
                    'Manage personal information and preferences.',
              ),

              const SizedBox(height: 24),

              Column(
                children: [

                  _settingsTile(
                    title:
                        'Personal Information',
                    subtitle:
                        'Update name, email and phone number.',
                    icon:
                        Icons.person_outline_rounded,
                    iconColor:
                        AppColors.primary,
                  ),

                  const SizedBox(height: 18),

                  _settingsTile(
                    title:
                        'Security & Privacy',
                    subtitle:
                        'Password, authentication and account security.',
                    icon:
                        Icons.lock_outline_rounded,
                    iconColor:
                        AppColors.chartOrange,
                  ),

                  const SizedBox(height: 18),

                  _settingsTile(
                    title:
                        'Notification Preferences',
                    subtitle:
                        'Manage alerts and reminders.',
                    icon:
                        Icons.notifications_none_rounded,
                    iconColor:
                        AppColors.chartPurple,
                  ),

                  const SizedBox(height: 18),

                  _settingsTile(
                    title:
                        'Subscription & Billing',
                    subtitle:
                        'Manage premium plan and billing details.',
                    icon:
                        Icons.workspace_premium_outlined,
                    iconColor:
                        AppColors.gstHighlight,
                  ),
                ],
              ),

              const SizedBox(height: 36),

              /// AI PREFERENCES
              DashboardSectionTitle(
                title: 'AI Preferences',
                subtitle:
                    'Customize TaxPilot AI experience.',
              ),

              const SizedBox(height: 24),

              DashboardContainer(
                child: Column(
                  children: [

                    _toggleTile(
                      title:
                          'AI Financial Insights',
                      subtitle:
                          'Receive personalized financial recommendations.',
                      value: true,
                    ),

                    const Divider(
                      color:
                          AppColors.divider,
                      height: 32,
                    ),

                    _toggleTile(
                      title:
                          'Smart Tax Suggestions',
                      subtitle:
                          'Enable AI-based tax optimization tips.',
                      value: true,
                    ),

                    const Divider(
                      color:
                          AppColors.divider,
                      height: 32,
                    ),

                    _toggleTile(
                      title:
                          'Expense Pattern Detection',
                      subtitle:
                          'Automatically analyze spending habits.',
                      value: false,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// ACCOUNT ACTIONS
              DashboardSectionTitle(
                title: 'Account Actions',
                subtitle:
                    'Manage logout and account controls.',
              ),

              const SizedBox(height: 24),

              Row(
                children: [

                  Expanded(
                    child: _actionButton(
                      title: 'Logout',
                      icon:
                          Icons.logout_rounded,
                      color:
                          AppColors.warning,
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: _actionButton(
                      title:
                          'Delete Account',
                      icon:
                          Icons.delete_outline_rounded,
                      color:
                          AppColors.error,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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

    return DashboardContainer(
      child: Row(
        children: [

          /// ICON
          Container(
            width: 56,
            height: 56,

            decoration: BoxDecoration(
              color:
                  iconColor.withOpacity(0.12),

              borderRadius:
                  BorderRadius.circular(
                      18),
            ),

            child: Icon(
              icon,
              color: iconColor,
            ),
          ),

          const SizedBox(width: 18),

          /// TEXT
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

          /// ARROW
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
            color:
                AppColors.secondaryText,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // TOGGLE TILE
  // =========================================================

  Widget _toggleTile({
    required String title,
    required String subtitle,
    required bool value,
  }) {

    return Row(
      children: [

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style:
                    AppTextStyles.cardTitle,
              ),

              const SizedBox(height: 6),

              Text(
                subtitle,
                style:
                    AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),

        Switch(
          value: value,
          activeColor:
              AppColors.primary,
          onChanged: (_) {},
        ),
      ],
    );
  }

  // =========================================================
  // ACTION BUTTON
  // =========================================================

  Widget _actionButton({
    required String title,
    required IconData icon,
    required Color color,
  }) {

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),

      decoration: BoxDecoration(
        color: color.withOpacity(0.12),

        borderRadius:
            BorderRadius.circular(20),

        border: Border.all(
          color: color.withOpacity(0.25),
        ),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            color: color,
          ),

          const SizedBox(width: 10),

          Text(
            title,
            style:
                AppTextStyles.bodyMedium
                    .copyWith(
              color: color,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // PROFILE CHIP
  // =========================================================

  Widget _profileChip({
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
        color: color.withOpacity(0.12),

        borderRadius:
            BorderRadius.circular(30),
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