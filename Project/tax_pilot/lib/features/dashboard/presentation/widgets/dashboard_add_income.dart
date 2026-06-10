import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tax_pilot/core/constants/app_colors.dart';
import 'package:tax_pilot/core/constants/app_text_styles.dart';


class AddIncomePage extends StatefulWidget {
  const AddIncomePage({super.key});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final TextEditingController clientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController tdsController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  String selectedPaymentMode = 'UPI';

  final List<String> paymentModes = [
    'UPI',
    'Bank Transfer',
    'Cash',
    'PayPal',
    'Stripe',
  ];

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.border,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Income',
                          style: AppTextStyles.heading2,
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Track freelance payments & tax records',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              /// OVERVIEW CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'This Month Income',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.whiteText.withValues(alpha: 0.7),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      '₹85,000',
                      style: AppTextStyles.displayMedium,
                    ),

                    const SizedBox(height: 14),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.glassEffect,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '+12% from last month',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.whiteText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// CLIENT NAME
              _buildLabel('Client / Company Name'),

              const SizedBox(height: 10),

              _buildTextField(
                controller: clientController,
                hint: 'Enter client name',
                icon: Icons.business_center_outlined,
              ),

              const SizedBox(height: 22),

              /// AMOUNT
              _buildLabel('Amount Received'),

              const SizedBox(height: 10),

              _buildTextField(
                controller: amountController,
                hint: 'Enter amount',
                keyboardType: TextInputType.number,
                prefixText: '₹ ',
                icon: Icons.currency_rupee_rounded,
              ),

              const SizedBox(height: 22),

              /// DATE PICKER
              _buildLabel('Payment Date'),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textFieldFill,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: AppColors.textFieldBorder,
                    ),
                  ),
                  child: Row(
                    children: [

                      const Icon(
                        Icons.calendar_month_rounded,
                        color: AppColors.primary,
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Text(
                          DateFormat('dd MMM yyyy')
                              .format(selectedDate),
                          style: AppTextStyles.textFieldText,
                        ),
                      ),

                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.secondaryText,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              /// PAYMENT MODE
              _buildLabel('Payment Mode'),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.textFieldFill,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.textFieldBorder,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedPaymentMode,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(16),
                    style: AppTextStyles.textFieldText,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.secondaryText,
                    ),
                    items: paymentModes.map((mode) {
                      return DropdownMenuItem(
                        value: mode,
                        child: Text(mode),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMode = value!;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 22),

              /// TDS
              _buildLabel('TDS Deducted'),

              const SizedBox(height: 10),

              _buildTextField(
                controller: tdsController,
                hint: 'Enter TDS amount',
                keyboardType: TextInputType.number,
                prefixText: '₹ ',
                icon: Icons.receipt_long_outlined,
              ),

              const SizedBox(height: 8),

              Text(
                'Enter TDS deducted by client if applicable',
                style: AppTextStyles.bodySmall,
              ),

              const SizedBox(height: 22),

              /// NOTES
              _buildLabel('Notes'),

              const SizedBox(height: 10),

              _buildTextField(
                controller: notesController,
                hint: 'Add payment notes',
                icon: Icons.notes_rounded,
                maxLines: 4,
              ),

              const SizedBox(height: 28),

              /// AI TIP CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: AppColors.primaryLight.withValues(alpha: 0.15),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: AppColors.primaryLight,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'AI Tip',
                            style: AppTextStyles.cardTitle,
                          ),

                          const SizedBox(height: 6),

                          Text(
                            'Payments with TDS help reduce final tax liability during filing.',
                            style: AppTextStyles.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 34),

              /// SAVE BUTTON
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBackground,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Save Income',
                    style: AppTextStyles.buttonText,
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String title) {
    return Text(
      title,
      style: AppTextStyles.textFieldLabel,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? prefixText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: AppTextStyles.textFieldText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textFieldFill,
        hintText: hint,
        hintStyle: AppTextStyles.textFieldHint,
        prefixText: prefixText,
        prefixStyle: AppTextStyles.textFieldText,
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.textFieldBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.focusedBorder,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}