import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../dashboard/presentation/widgets/dashboard_container.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_title.dart';

class UploadBillsPage extends StatelessWidget {
  const UploadBillsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          AppColors.scaffoldBackground,

      floatingActionButton:
          FloatingActionButton(
        backgroundColor:
            AppColors.primary,

        onPressed: () {},

        child: const Icon(
          Icons.upload_rounded,
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              /// HEADER
              LayoutBuilder(
                builder:
                    (context, constraints) {

                  final bool isMobile =
                      constraints.maxWidth <
                          700;

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,

                    alignment:
                        WrapAlignment
                            .spaceBetween,

                    crossAxisAlignment:
                        WrapCrossAlignment
                            .center,

                    children: [

                      /// LEFT CONTENT
                      SizedBox(
                        width: isMobile
                            ? constraints
                                .maxWidth
                            : constraints
                                    .maxWidth *
                                0.65,

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [

                            Text(
                              'Upload Bills',
                              style:
                                  AppTextStyles
                                      .heading2,
                            ),

                            const SizedBox(
                                height: 8),

                            Text(
                              'Upload invoices, receipts and financial documents securely.',
                              style:
                                  AppTextStyles
                                      .bodySmall,
                            ),
                          ],
                        ),
                      ),

                      /// AI OCR BADGE
                      Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),

                        decoration:
                            BoxDecoration(
                          color: AppColors
                              .primary
                              .withValues(
                                  alpha: 0.12),

                          borderRadius:
                              BorderRadius
                                  .circular(
                                      30),
                        ),

                        child: Row(
                          mainAxisSize:
                              MainAxisSize
                                  .min,
                          children: [

                            const Icon(
                              Icons
                                  .auto_awesome,
                              size: 18,
                              color:
                                  AppColors
                                      .primary,
                            ),

                            const SizedBox(
                                width: 8),

                            Flexible(
                              child: Text(
                                'AI OCR Enabled',

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    AppTextStyles
                                        .bodySmall
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
                  );
                },
              ),

              const SizedBox(height: 36),

              /// UPLOAD AREA
              DashboardSectionTitle(
                title:
                    'Document Upload',
                subtitle:
                    'Upload receipts, invoices and tax-related files.',
              ),

              const SizedBox(height: 24),

              DashboardContainer(
                padding:
                    const EdgeInsets.all(
                        36),

                child: Column(
                  children: [

                    /// UPLOAD ICON
                    Container(
                      width: 100,
                      height: 100,

                      decoration:
                          BoxDecoration(
                        color: AppColors
                            .primary
                            .withValues(
                                alpha: 0.12),

                        shape:
                            BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons
                            .cloud_upload_rounded,
                        size: 46,
                        color:
                            AppColors
                                .primary,
                      ),
                    ),

                    const SizedBox(
                        height: 28),

                    /// TITLE
                    Text(
                      'Drag & Drop Files',
                      style:
                          AppTextStyles
                              .heading3,
                      textAlign:
                          TextAlign.center,
                    ),

                    const SizedBox(
                        height: 10),

                    /// SUBTITLE
                    Text(
                      'Upload PDFs, invoices, receipts or screenshots for AI processing.',

                      textAlign:
                          TextAlign.center,

                      style:
                          AppTextStyles
                              .bodySmall
                              .copyWith(
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(
                        height: 28),

                    /// BUTTONS
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,

                      alignment:
                          WrapAlignment
                              .center,

                      children: [

                        _actionButton(
                          title:
                              'Choose Files',

                          icon:
                              Icons
                                  .folder_open_rounded,

                          isPrimary:
                              true,
                        ),

                        _actionButton(
                          title:
                              'Open Camera',

                          icon:
                              Icons
                                  .camera_alt_outlined,

                          isPrimary:
                              false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// AI FEATURES
              DashboardSectionTitle(
                title:
                    'AI Processing Features',

                subtitle:
                    'Smart analysis performed after upload.',
              ),

              const SizedBox(height: 24),

              LayoutBuilder(
                builder:
                    (context, constraints) {

                  int crossAxisCount =
                      1;

                  if (constraints
                          .maxWidth >=
                      1200) {

                    crossAxisCount = 4;

                  } else if (constraints
                          .maxWidth >=
                      900) {

                    crossAxisCount = 3;

                  } else if (constraints
                          .maxWidth >=
                      600) {

                    crossAxisCount = 2;
                  }

                  return GridView.builder(
                    shrinkWrap: true,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    itemCount: 4,

                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount:
                          crossAxisCount,

                      crossAxisSpacing:
                          20,

                      mainAxisSpacing:
                          20,

                      childAspectRatio:
                          constraints.maxWidth <
                                  600
                              ? 1.05
                              : 1.25,
                    ),

                    itemBuilder:
                        (context, index) {

                      final items = [

                        _featureCard(
                          title:
                              'OCR Extraction',

                          subtitle:
                              'Automatically extract text and bill details.',

                          icon:
                              Icons
                                  .document_scanner_outlined,

                          color:
                              AppColors
                                  .primary,
                        ),

                        _featureCard(
                          title:
                              'Expense Categorization',

                          subtitle:
                              'AI categorizes expenses intelligently.',

                          icon:
                              Icons
                                  .category_outlined,

                          color:
                              AppColors
                                  .chartOrange,
                        ),

                        _featureCard(
                          title:
                              'Tax Detection',

                          subtitle:
                              'Identify GST and tax-related entries.',

                          icon:
                              Icons
                                  .receipt_long_outlined,

                          color:
                              AppColors
                                  .taxHighlight,
                        ),

                        _featureCard(
                          title:
                              'Fraud Detection',

                          subtitle:
                              'AI detects suspicious or duplicate invoices.',

                          icon:
                              Icons
                                  .security_outlined,

                          color:
                              AppColors
                                  .error,
                        ),
                      ];

                      return items[index];
                    },
                  );
                },
              ),

              const SizedBox(height: 36),

              /// RECENT UPLOADS
              DashboardSectionTitle(
                title:
                    'Recent Uploads',

                subtitle:
                    'Recently uploaded bills and invoices.',

                actionText:
                    'View All',

                onActionTap: () {},
              ),

              const SizedBox(height: 24),

              Column(
                children: [

                  _uploadTile(
                    fileName:
                        'Freelance_Invoice_March.pdf',

                    fileSize:
                        '2.4 MB',

                    uploadTime:
                        'Today',

                    status:
                        'Processed',

                    statusColor:
                        AppColors.success,

                    icon:
                        Icons
                            .picture_as_pdf_outlined,

                    iconColor:
                        AppColors.error,
                  ),

                  const SizedBox(
                      height: 18),

                  _uploadTile(
                    fileName:
                        'Office_Rent_Receipt.jpg',

                    fileSize:
                        '1.2 MB',

                    uploadTime:
                        'Yesterday',

                    status:
                        'Analyzing',

                    statusColor:
                        AppColors.warning,

                    icon:
                        Icons.image_outlined,

                    iconColor:
                        AppColors.chartPurple,
                  ),

                  const SizedBox(
                      height: 18),

                  _uploadTile(
                    fileName:
                        'Internet_Bill_April.pdf',

                    fileSize:
                        '980 KB',

                    uploadTime:
                        '2 days ago',

                    status:
                        'Completed',

                    statusColor:
                        AppColors.success,

                    icon:
                        Icons
                            .receipt_long_outlined,

                    iconColor:
                        AppColors.taxHighlight,
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
  // ACTION BUTTON
  // =========================================================

  Widget _actionButton({
    required String title,
    required IconData icon,
    required bool isPrimary,
  }) {

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 16,
      ),

      decoration: BoxDecoration(
        color: isPrimary
            ? AppColors.primary
            : AppColors
                .secondaryCardBackground,

        borderRadius:
            BorderRadius.circular(18),

        border: isPrimary
            ? null
            : Border.all(
                color:
                    AppColors.border,
              ),
      ),

      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [

          Icon(
            icon,
            color: isPrimary
                ? Colors.white
                : AppColors.primary,
          ),

          const SizedBox(width: 10),

          Flexible(
            child: Text(
              title,

              overflow:
                  TextOverflow.ellipsis,

              style:
                  AppTextStyles
                      .bodyMedium
                      .copyWith(
                color: isPrimary
                    ? Colors.white
                    : AppColors
                        .primaryText,

                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FEATURE CARD
  // =========================================================

  Widget _featureCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {

    return DashboardContainer(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        mainAxisAlignment:
            MainAxisAlignment.start,

        children: [

          Container(
            padding:
                const EdgeInsets.all(
                    14),

            decoration: BoxDecoration(
              color:
                  color.withOpacity(
                      0.12),

              borderRadius:
                  BorderRadius.circular(
                      18),
            ),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(height: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(
                  title,

                  maxLines: 2,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      AppTextStyles
                          .cardTitle,
                ),

                const SizedBox(
                    height: 8),

                Expanded(
                  child: Text(
                    subtitle,

                    overflow:
                        TextOverflow.fade,

                    style:
                        AppTextStyles
                            .bodySmall
                            .copyWith(
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // UPLOAD TILE
  // =========================================================

  Widget _uploadTile({
    required String fileName,
    required String fileSize,
    required String uploadTime,
    required String status,
    required Color statusColor,
    required IconData icon,
    required Color iconColor,
  }) {

    return DashboardContainer(
      child: LayoutBuilder(
        builder:
            (context, constraints) {

          final bool isMobile =
              constraints.maxWidth <
                  650;

          return isMobile

              /// MOBILE VIEW
              ? Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [

                    Row(
                      children: [

                        Container(
                          width: 58,
                          height: 58,

                          decoration:
                              BoxDecoration(
                            color: iconColor
                                .withOpacity(
                                    0.12),

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        18),
                          ),

                          child: Icon(
                            icon,
                            color:
                                iconColor,
                          ),
                        ),

                        const SizedBox(
                            width: 18),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [

                              Text(
                                fileName,

                                maxLines:
                                    2,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    AppTextStyles
                                        .cardTitle,
                              ),

                              const SizedBox(
                                  height:
                                      6),

                              Text(
                                '$fileSize • $uploadTime',

                                style:
                                    AppTextStyles
                                        .bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 16),

                    Align(
                      alignment:
                          Alignment
                              .centerLeft,

                      child: Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),

                        decoration:
                            BoxDecoration(
                          color:
                              statusColor
                                  .withOpacity(
                                      0.12),

                          borderRadius:
                              BorderRadius
                                  .circular(
                                      30),
                        ),

                        child: Text(
                          status,

                          style:
                              AppTextStyles
                                  .bodySmall
                                  .copyWith(
                            color:
                                statusColor,

                            fontWeight:
                                FontWeight
                                    .w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              /// DESKTOP VIEW
              : Row(
                  children: [

                    Container(
                      width: 58,
                      height: 58,

                      decoration:
                          BoxDecoration(
                        color: iconColor
                            .withOpacity(
                                0.12),

                        borderRadius:
                            BorderRadius
                                .circular(
                                    18),
                      ),

                      child: Icon(
                        icon,
                        color:
                            iconColor,
                      ),
                    ),

                    const SizedBox(
                        width: 18),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [

                          Text(
                            fileName,

                            maxLines: 1,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                AppTextStyles
                                    .cardTitle,
                          ),

                          const SizedBox(
                              height: 6),

                          Text(
                            '$fileSize • $uploadTime',

                            style:
                                AppTextStyles
                                    .bodySmall,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                        width: 16),

                    Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),

                      decoration:
                          BoxDecoration(
                        color: statusColor
                            .withOpacity(
                                0.12),

                        borderRadius:
                            BorderRadius
                                .circular(
                                    30),
                      ),

                      child: Text(
                        status,

                        style:
                            AppTextStyles
                                .bodySmall
                                .copyWith(
                          color:
                              statusColor,

                          fontWeight:
                              FontWeight
                                  .w600,
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}