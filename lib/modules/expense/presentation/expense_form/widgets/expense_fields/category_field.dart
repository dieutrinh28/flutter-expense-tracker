import 'package:flutter/material.dart';
import '../../../../../../core/theme/color_palette.dart';
import '../../../../../../core/theme/typography.dart';

class CategoryField extends StatelessWidget {
  final String? value;
  final bool isEditable;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const CategoryField({
    super.key,
    required this.value,
    required this.isEditable,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Food & Dining',
      'Transportation',
      'Shopping',
      'Entertainment',
      'Medical',
      'Other',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorPalette.secondaryText,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: categories.contains(value) ? value : null,
          items: categories.map((c) => DropdownMenuItem(
            value: c,
            child: Text(c, style: AppTypography.body),
          )).toList(),
          onChanged: isEditable ? (val) => onChanged(val ?? '') : null,
          decoration: InputDecoration(
            hintText: 'Select Category',
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
