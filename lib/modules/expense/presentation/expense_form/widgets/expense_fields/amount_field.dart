import 'package:flutter/material.dart';
import '../../../../../../core/theme/color_palette.dart';
import '../../../../../../core/theme/typography.dart';

class AmountField extends StatelessWidget {
  final double value;
  final bool isEditable;
  final ValueChanged<double> onChanged;
  final String? errorText;

  const AmountField({
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
          'Amount',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorPalette.secondaryText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F7FF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFBFDBFE),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
               Text(
                 "\$",
                style: AppTypography.title.copyWith(
                  color: ColorPalette.tertiaryText,
                  fontSize: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  enabled: isEditable,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: AppTypography.title.copyWith(
                    color: ColorPalette.secondaryText,
                    fontSize: 24,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: '0.00',
                  ),
                  onChanged: (val) {
                    final d = double.tryParse(val) ?? 0.0;
                    onChanged(d);
                  },
                ),
              ),
            ],
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
