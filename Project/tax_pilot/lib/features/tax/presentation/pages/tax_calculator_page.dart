// import 'package:flutter/material.dart';

// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_text_styles.dart';
// import '../../../dashboard/presentation/widgets/dashboard_container.dart';
// import '../../../dashboard/presentation/widgets/dashboard_section_title.dart';

// class TaxCalculatorPage extends StatefulWidget {
//   const TaxCalculatorPage({super.key});

//   @override
//   State<TaxCalculatorPage> createState() =>
//       _TaxCalculatorPageState();
// }

// class _TaxCalculatorPageState
//     extends State<TaxCalculatorPage> {

//   final TextEditingController incomeController =
//       TextEditingController();

//   final TextEditingController deductionController =
//       TextEditingController();

//   double estimatedTax = 0;

//   void calculateTax() {

//     final income =
//         double.tryParse(
//               incomeController.text,
//             ) ??
//             0;

//     final deduction =
//         double.tryParse(
//               deductionController.text,
//             ) ??
//             0;

//     final taxableIncome =
//         income - deduction;

//     double tax = 0;

//     /// SIMPLE DEMO TAX LOGIC
//     if (taxableIncome <= 250000) {

//       tax = 0;

//     } else if (taxableIncome <=
//         500000) {

//       tax = taxableIncome * 0.05;

//     } else if (taxableIncome <=
//         1000000) {

//       tax = taxableIncome * 0.10;

//     } else {

//       tax = taxableIncome * 0.20;
//     }

//     setState(() {
//       estimatedTax = tax;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       backgroundColor:
//           AppColors.scaffoldBackground,

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding:
//               const EdgeInsets.all(24),

//           child: Column(
//             crossAxisAlignment:
//                 CrossAxisAlignment.start,
//             children: [

//               /// HEADER
//               LayoutBuilder(
//                 builder:
//                     (context, constraints) {

//                   final bool isMobile =
//                       constraints.maxWidth <
//                           700;

//                   return Wrap(
//                     spacing: 16,
//                     runSpacing: 16,

//                     alignment:
//                         WrapAlignment
//                             .spaceBetween,

//                     crossAxisAlignment:
//                         WrapCrossAlignment
//                             .center,

//                     children: [

//                       /// LEFT SECTION
//                       SizedBox(
//                         width: isMobile
//                             ? constraints
//                                 .maxWidth
//                             : constraints
//                                     .maxWidth *
//                                 0.65,

//                         child: Column(
//                           crossAxisAlignment:
//                               CrossAxisAlignment
//                                   .start,
//                           children: [

//                             Text(
//                               'Tax Calculator',

//                               style:
//                                   AppTextStyles
//                                       .heading2,
//                             ),

//                             const SizedBox(
//                                 height: 8),

//                             Text(
//                               'Estimate taxes, deductions and financial liabilities.',

//                               style:
//                                   AppTextStyles
//                                       .bodySmall,
//                             ),
//                           ],
//                         ),
//                       ),

//                       /// AI BADGE
//                       Container(
//                         padding:
//                             const EdgeInsets
//                                 .symmetric(
//                           horizontal: 16,
//                           vertical: 10,
//                         ),

//                         decoration:
//                             BoxDecoration(
//                           color: AppColors
//                               .primary
//                               .withOpacity(
//                                   0.12),

//                           borderRadius:
//                               BorderRadius
//                                   .circular(
//                                       30),
//                         ),

//                         child: Row(
//                           mainAxisSize:
//                               MainAxisSize
//                                   .min,

//                           children: [

//                             const Icon(
//                               Icons
//                                   .auto_awesome,

//                               color:
//                                   AppColors
//                                       .primary,

//                               size: 18,
//                             ),

//                             const SizedBox(
//                                 width: 8),

//                             Flexible(
//                               child: Text(
//                                 'AI Powered',

//                                 overflow:
//                                     TextOverflow
//                                         .ellipsis,

//                                 style:
//                                     AppTextStyles
//                                         .bodySmall
//                                         .copyWith(
//                                   color:
//                                       AppColors
//                                           .primary,

//                                   fontWeight:
//                                       FontWeight
//                                           .w600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),

//               const SizedBox(height: 36),

//               /// TAX INPUT SECTION
//               DashboardSectionTitle(
//                 title:
//                     'Tax Estimation',

//                 subtitle:
//                     'Enter your financial details for tax calculation.',
//               ),

//               const SizedBox(height: 24),

//               DashboardContainer(
//                 padding:
//                     const EdgeInsets.all(
//                         28),

//                 child: Column(
//                   children: [

//                     /// INCOME FIELD
//                     _inputField(
//                       title:
//                           'Annual Income',

//                       hint:
//                           'Enter annual income',

//                       controller:
//                           incomeController,

//                       icon:
//                           Icons
//                               .currency_rupee_rounded,
//                     ),

//                     const SizedBox(
//                         height: 22),

//                     /// DEDUCTION FIELD
//                     _inputField(
//                       title:
//                           'Total Deductions',

//                       hint:
//                           'Enter deductions',

//                       controller:
//                           deductionController,

//                       icon:
//                           Icons
//                               .receipt_long_outlined,
//                     ),

//                     const SizedBox(
//                         height: 30),

//                     /// CALCULATE BUTTON
//                     SizedBox(
//                       width:
//                           double.infinity,

//                       child:
//                           ElevatedButton(
//                         onPressed:
//                             calculateTax,

//                         style:
//                             ElevatedButton
//                                 .styleFrom(
//                           backgroundColor:
//                               AppColors
//                                   .primary,

//                           padding:
//                               const EdgeInsets
//                                   .symmetric(
//                             vertical:
//                                 18,
//                           ),

//                           shape:
//                               RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(
//                                     18),
//                           ),
//                         ),

//                         child: Text(
//                           'Calculate Tax',

//                           style:
//                               AppTextStyles
//                                   .bodyMedium
//                                   .copyWith(
//                             color:
//                                 Colors
//                                     .white,

//                             fontWeight:
//                                 FontWeight
//                                     .w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 36),

//               /// RESULT SECTION
//               DashboardSectionTitle(
//                 title:
//                     'Estimated Tax Result',

//                 subtitle:
//                     'Calculated tax based on entered details.',
//               ),

//               const SizedBox(height: 24),

//               DashboardContainer(
//                 padding:
//                     const EdgeInsets.all(
//                         30),

//                 child: Column(
//                   crossAxisAlignment:
//                       CrossAxisAlignment
//                           .start,
//                   children: [

//                     Text(
//                       'Estimated Tax',

//                       style:
//                           AppTextStyles
//                               .bodySmall,
//                     ),

//                     const SizedBox(
//                         height: 14),

//                     Text(
//                       '₹${estimatedTax.toStringAsFixed(2)}',

//                       style:
//                           AppTextStyles
//                               .heading1
//                               .copyWith(
//                         color:
//                             AppColors
//                                 .taxHighlight,
//                       ),
//                     ),

//                     const SizedBox(
//                         height: 20),

//                     Row(
//                       children: [

//                         Container(
//                           padding:
//                               const EdgeInsets
//                                   .all(14),

//                           decoration:
//                               BoxDecoration(
//                             color: AppColors
//                                 .taxHighlight
//                                 .withOpacity(
//                                     0.12),

//                             borderRadius:
//                                 BorderRadius.circular(
//                                     18),
//                           ),

//                           child:
//                               const Icon(
//                             Icons
//                                 .analytics_outlined,

//                             color:
//                                 AppColors
//                                     .taxHighlight,
//                           ),
//                         ),

//                         const SizedBox(
//                             width: 16),

//                         Expanded(
//                           child: Text(
//                             'AI analysis suggests possible tax-saving opportunities '
//                             'through investment deductions and expense optimization.',

//                             style:
//                                 AppTextStyles
//                                     .bodySmall
//                                     .copyWith(
//                               height:
//                                   1.6,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 36),

//               /// TAX SAVING TIPS
//               DashboardSectionTitle(
//                 title:
//                     'Smart Tax Saving Tips',

//                 subtitle:
//                     'AI-powered recommendations for reducing taxable income.',
//               ),

//               const SizedBox(height: 24),

//               Column(
//                 children: [

//                   _tipTile(
//                     title:
//                         'Section 80C Investments',

//                     subtitle:
//                         'Invest in ELSS, PPF and insurance to reduce taxable income.',

//                     icon:
//                         Icons
//                             .savings_outlined,

//                     iconColor:
//                         AppColors
//                             .chartGreen,
//                   ),

//                   const SizedBox(
//                       height: 18),

//                   _tipTile(
//                     title:
//                         'Track Business Expenses',

//                     subtitle:
//                         'Freelancers can deduct eligible business-related expenses.',

//                     icon:
//                         Icons
//                             .business_center_outlined,

//                     iconColor:
//                         AppColors
//                             .chartOrange,
//                   ),

//                   const SizedBox(
//                       height: 18),

//                   _tipTile(
//                     title:
//                         'Health Insurance Benefits',

//                     subtitle:
//                         'Claim deductions under health insurance policies.',

//                     icon:
//                         Icons
//                             .health_and_safety_outlined,

//                     iconColor:
//                         AppColors
//                             .primary,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // =========================================================
//   // INPUT FIELD
//   // =========================================================

//   Widget _inputField({
//     required String title,
//     required String hint,
//     required TextEditingController
//         controller,
//     required IconData icon,
//   }) {

//     return Column(
//       crossAxisAlignment:
//           CrossAxisAlignment.start,
//       children: [

//         Text(
//           title,

//           style:
//               AppTextStyles.bodyMedium
//                   .copyWith(
//             fontWeight:
//                 FontWeight.w600,
//           ),
//         ),

//         const SizedBox(height: 12),

//         TextField(
//           controller: controller,

//           keyboardType:
//               TextInputType.number,

//           style:
//               AppTextStyles.bodyMedium,

//           decoration:
//               InputDecoration(
//             hintText: hint,

//             hintStyle:
//                 AppTextStyles
//                     .bodySmall,

//             filled: true,

//             fillColor:
//                 AppColors
//                     .secondaryCardBackground,

//             prefixIcon: Icon(
//               icon,

//               color:
//                   AppColors.primary,
//             ),

//             border:
//                 OutlineInputBorder(
//               borderRadius:
//                   BorderRadius.circular(
//                       18),

//               borderSide:
//                   BorderSide(
//                 color:
//                     AppColors.border,
//               ),
//             ),

//             enabledBorder:
//                 OutlineInputBorder(
//               borderRadius:
//                   BorderRadius.circular(
//                       18),

//               borderSide:
//                   BorderSide(
//                 color:
//                     AppColors.border,
//               ),
//             ),

//             focusedBorder:
//                 OutlineInputBorder(
//               borderRadius:
//                   BorderRadius.circular(
//                       18),

//               borderSide:
//                   const BorderSide(
//                 color:
//                     AppColors.primary,

//                 width: 1.5,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // =========================================================
//   // TIP TILE
//   // =========================================================

//   Widget _tipTile({
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required Color iconColor,
//   }) {

//     return DashboardContainer(
//       child: Row(
//         children: [

//           /// ICON
//           Container(
//             width: 58,
//             height: 58,

//             decoration:
//                 BoxDecoration(
//               color:
//                   iconColor.withOpacity(
//                       0.12),

//               borderRadius:
//                   BorderRadius.circular(
//                       18),
//             ),

//             child: Icon(
//               icon,
//               color: iconColor,
//             ),
//           ),

//           const SizedBox(width: 18),

//           /// TEXT
//           Expanded(
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment
//                       .start,
//               children: [

//                 Text(
//                   title,

//                   style:
//                       AppTextStyles
//                           .cardTitle,
//                 ),

//                 const SizedBox(height: 6),

//                 Text(
//                   subtitle,

//                   style:
//                       AppTextStyles
//                           .bodySmall
//                           .copyWith(
//                     height: 1.5,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../dashboard/presentation/widgets/dashboard_container.dart';
import '../../../dashboard/presentation/widgets/dashboard_section_title.dart';

class TaxCalculatorPage extends StatefulWidget {
  const TaxCalculatorPage({super.key});

  @override
  State<TaxCalculatorPage> createState() =>
      _TaxCalculatorPageState();
}

class _TaxCalculatorPageState
    extends State<TaxCalculatorPage> {

  final TextEditingController incomeController =
      TextEditingController();

  final TextEditingController deductionController =
      TextEditingController();

  double estimatedTax = 0;

  void calculateTax() {

    final income =
        double.tryParse(
              incomeController.text,
            ) ??
            0;

    final deduction =
        double.tryParse(
              deductionController.text,
            ) ??
            0;

    final taxableIncome =
        income - deduction;

    double tax = 0;

    if (taxableIncome <= 250000) {

      tax = 0;

    } else if (taxableIncome <=
        500000) {

      tax = taxableIncome * 0.05;

    } else if (taxableIncome <=
        1000000) {

      tax = taxableIncome * 0.10;

    } else {

      tax = taxableIncome * 0.20;
    }

    setState(() {
      estimatedTax = tax;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          AppColors.scaffoldBackground,

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

                      /// LEFT SECTION
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
                              'Tax Calculator',

                              style:
                                  AppTextStyles
                                      .heading2,
                            ),

                            const SizedBox(
                                height: 8),

                            Text(
                              'Estimate taxes, deductions and financial liabilities.',

                              style:
                                  AppTextStyles
                                      .bodySmall,
                            ),
                          ],
                        ),
                      ),

                      /// AI BADGE
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
                              .withOpacity(
                                  0.12),

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

                              color:
                                  AppColors
                                      .primary,

                              size: 18,
                            ),

                            const SizedBox(
                                width: 8),

                            Flexible(
                              child: Text(
                                'AI Powered',

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

              /// TAX INPUT SECTION
              DashboardSectionTitle(
                title:
                    'Tax Estimation',

                subtitle:
                    'Enter your financial details for tax calculation.',
              ),

              const SizedBox(height: 24),

              DashboardContainer(
                padding:
                    const EdgeInsets.all(
                        28),

                child: Column(
                  children: [

                    _inputField(
                      title:
                          'Annual Income',

                      hint:
                          'Enter annual income',

                      controller:
                          incomeController,

                      icon:
                          Icons
                              .currency_rupee_rounded,
                    ),

                    const SizedBox(
                        height: 22),

                    _inputField(
                      title:
                          'Total Deductions',

                      hint:
                          'Enter deductions',

                      controller:
                          deductionController,

                      icon:
                          Icons
                              .receipt_long_outlined,
                    ),

                    const SizedBox(
                        height: 30),

                    SizedBox(
                      width:
                          double.infinity,

                      child:
                          ElevatedButton(
                        onPressed:
                            calculateTax,

                        style:
                            ElevatedButton
                                .styleFrom(
                          backgroundColor:
                              AppColors
                                  .primary,

                          padding:
                              const EdgeInsets
                                  .symmetric(
                            vertical:
                                18,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    18),
                          ),
                        ),

                        child: Text(
                          'Calculate Tax',

                          style:
                              AppTextStyles
                                  .bodyMedium
                                  .copyWith(
                            color:
                                Colors
                                    .white,

                            fontWeight:
                                FontWeight
                                    .w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// RESULT SECTION
              DashboardSectionTitle(
                title:
                    'Estimated Tax Result',

                subtitle:
                    'Calculated tax based on entered details.',
              ),

              const SizedBox(height: 24),

              DashboardContainer(
                padding:
                    const EdgeInsets.all(
                        30),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [

                    Text(
                      'Estimated Tax',

                      style:
                          AppTextStyles
                              .bodySmall,
                    ),

                    const SizedBox(
                        height: 14),

                    Text(
                      '₹${estimatedTax.toStringAsFixed(2)}',

                      style:
                          AppTextStyles
                              .heading1
                              .copyWith(
                        color:
                            AppColors
                                .taxHighlight,
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    Row(
                      children: [

                        Container(
                          padding:
                              const EdgeInsets
                                  .all(14),

                          decoration:
                              BoxDecoration(
                            color: AppColors
                                .taxHighlight
                                .withOpacity(
                                    0.12),

                            borderRadius:
                                BorderRadius.circular(
                                    18),
                          ),

                          child:
                              const Icon(
                            Icons
                                .analytics_outlined,

                            color:
                                AppColors
                                    .taxHighlight,
                          ),
                        ),

                        const SizedBox(
                            width: 16),

                        Expanded(
                          child: Text(
                            'AI analysis suggests possible tax-saving opportunities '
                            'through investment deductions and expense optimization.',

                            style:
                                AppTextStyles
                                    .bodySmall
                                    .copyWith(
                              height:
                                  1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              /// TAX SAVING TIPS
              DashboardSectionTitle(
                title:
                    'Smart Tax Saving Tips',

                subtitle:
                    'AI-powered recommendations for reducing taxable income.',
              ),

              const SizedBox(height: 24),

              Column(
                children: [

                  _tipTile(
                    title:
                        'Section 80C Investments',

                    subtitle:
                        'Invest in ELSS, PPF and insurance to reduce taxable income.',

                    icon:
                        Icons.savings_outlined,

                    iconColor:
                        AppColors.chartGreen,
                  ),

                  const SizedBox(
                      height: 18),

                  _tipTile(
                    title:
                        'Track Business Expenses',

                    subtitle:
                        'Freelancers can deduct eligible business-related expenses.',

                    icon:
                        Icons.business_center_outlined,

                    iconColor:
                        AppColors.chartOrange,
                  ),

                  const SizedBox(
                      height: 18),

                  _tipTile(
                    title:
                        'Health Insurance Benefits',

                    subtitle:
                        'Claim deductions under health insurance policies.',

                    icon:
                        Icons.health_and_safety_outlined,

                    iconColor:
                        AppColors.primary,
                  ),

                  const SizedBox(
                      height: 18),

                  _tipTile(
                    title:
                        'Upload Deduction Proofs',

                    subtitle:
                        'Upload invoices, receipts and supporting documents '
                        'for verification and future tax filing.',

                    icon:
                        Icons.upload_file_rounded,

                    iconColor:
                        AppColors.chartBlue,
                  ),

                  const SizedBox(
                      height: 18),

                  DashboardContainer(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [

                        /// HEADER
                        Row(
                          children: [

                            Container(
                              width: 58,
                              height: 58,

                              decoration:
                                  BoxDecoration(
                                color: AppColors
                                    .taxHighlight
                                    .withOpacity(
                                        0.12),

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            18),
                              ),

                              child:
                                  const Icon(
                                Icons
                                    .track_changes_rounded,

                                color:
                                    AppColors
                                        .taxHighlight,
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
                                    'Deduction Progress Tracking',

                                    style:
                                        AppTextStyles
                                            .cardTitle,
                                  ),

                                  const SizedBox(
                                      height:
                                          6),

                                  Text(
                                    'Track how much deduction limit '
                                    'you have already utilized.',

                                    style:
                                        AppTextStyles
                                            .bodySmall
                                            .copyWith(
                                      height:
                                          1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                            height: 24),

                        /// PROGRESS LABEL
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [

                            Text(
                              '80C Utilization',

                              style:
                                  AppTextStyles
                                      .bodyMedium
                                      .copyWith(
                                fontWeight:
                                    FontWeight
                                        .w600,
                              ),
                            ),

                            Text(
                              '₹95,000 / ₹1,50,000',

                              style:
                                  AppTextStyles
                                      .bodySmall,
                            ),
                          ],
                        ),

                        const SizedBox(
                            height: 14),

                        /// PROGRESS BAR
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(
                                  30),

                          child:
                              LinearProgressIndicator(
                            value: 0.63,

                            minHeight: 10,

                            backgroundColor:
                                AppColors.border,

                            valueColor:
                                AlwaysStoppedAnimation(
                              AppColors
                                  .taxHighlight,
                            ),
                          ),
                        ),

                        const SizedBox(
                            height: 18),

                        /// AI INSIGHT
                        Container(
                          padding:
                              const EdgeInsets
                                  .all(16),

                          decoration:
                              BoxDecoration(
                            color: AppColors
                                .primary
                                .withOpacity(
                                    0.08),

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        18),
                          ),

                          child: Row(
                            children: [

                              const Icon(
                                Icons
                                    .auto_awesome,

                                color:
                                    AppColors
                                        .primary,

                                size: 20,
                              ),

                              const SizedBox(
                                  width: 12),

                              Expanded(
                                child: Text(
                                  'You can still invest ₹55,000 '
                                  'under Section 80C to maximize '
                                  'tax savings.',

                                  style:
                                      AppTextStyles
                                          .bodySmall
                                          .copyWith(
                                    height:
                                        1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _inputField({
    required String title,
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
          title,

          style:
              AppTextStyles.bodyMedium
                  .copyWith(
            fontWeight:
                FontWeight.w600,
          ),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: controller,

          keyboardType:
              TextInputType.number,

          style:
              AppTextStyles.bodyMedium,

          decoration:
              InputDecoration(
            hintText: hint,

            hintStyle:
                AppTextStyles
                    .bodySmall,

            filled: true,

            fillColor:
                AppColors
                    .secondaryCardBackground,

            prefixIcon: Icon(
              icon,

              color:
                  AppColors.primary,
            ),

            border:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                      18),

              borderSide:
                  BorderSide(
                color:
                    AppColors.border,
              ),
            ),

            enabledBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                      18),

              borderSide:
                  BorderSide(
                color:
                    AppColors.border,
              ),
            ),

            focusedBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                      18),

              borderSide:
                  const BorderSide(
                color:
                    AppColors.primary,

                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tipTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {

    return DashboardContainer(
      child: Row(
        children: [

          Container(
            width: 58,
            height: 58,

            decoration:
                BoxDecoration(
              color:
                  iconColor.withOpacity(
                      0.12),

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
                          .bodySmall
                          .copyWith(
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
