import 'package:flutter/material.dart';
import '../../../../../../core/theme/color_palette.dart';
import '../../../../../../core/theme/typography.dart';

class NoteField extends StatelessWidget {
  final String? value;
  final bool isEditable;
  final ValueChanged<String> onChanged;

  const NoteField({
    super.key,
    required this.value,
    required this.isEditable,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Note (Optional)',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorPalette.secondaryText,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          enabled: isEditable,
          maxLines: 4,
          style: AppTypography.body,
          decoration: InputDecoration(
            hintText: 'Add any additional details...',
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
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
