import 'package:flutter/material.dart';
import '../../../../../../core/theme/color_palette.dart';
import '../../../../../../core/theme/typography.dart';

class TitleField extends StatelessWidget {
  final String value;
  final bool isEditable;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const TitleField({
    super.key,
    required this.value,
    required this.isEditable,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Title',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorPalette.secondaryText,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          enabled: isEditable,
          style: AppTypography.body.copyWith(
            color: ColorPalette.primaryText,
          ),
          decoration: InputDecoration(
            hintText: 'e.g., Lunch at restaurant',
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
          onChanged: onChanged,
        ),
      ],
    );
  }
}
