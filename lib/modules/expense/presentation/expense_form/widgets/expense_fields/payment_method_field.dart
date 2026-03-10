import 'package:flutter/material.dart';
import '../../../../../../core/theme/color_palette.dart';
import '../../../../../../core/theme/typography.dart';

class PaymentMethodField extends StatelessWidget {
  final String? value;
  final bool isEditable;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const PaymentMethodField({
    super.key,
    required this.value,
    required this.isEditable,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final methods = [
      'Cash',
      'Credit Card',
      'Debit Card',
      'Bank Transfer',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorPalette.secondaryText,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: methods.contains(value) ? value : null,
          items: methods.map((m) => DropdownMenuItem(
            value: m,
            child: Text(m, style: AppTypography.body),
          )).toList(),
          onChanged: isEditable ? (val) => onChanged(val ?? '') : null,
          decoration: InputDecoration(
            hintText: 'Select Payment Method',
            hintStyle: AppTypography.secondaryText.copyWith(
              color: ColorPalette.tertiaryText,
            ),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: ColorPalette.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: ColorPalette.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: ColorPalette.blueLight, width: 1.5),
            ),
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
