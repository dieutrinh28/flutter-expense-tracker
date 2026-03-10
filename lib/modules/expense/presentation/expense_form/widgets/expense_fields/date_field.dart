import 'package:flutter/material.dart';
import '../../../../../../core/theme/color_palette.dart';
import '../../../../../../core/theme/typography.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  final DateTime? value;
  final bool isEditable;
  final ValueChanged<DateTime> onChanged;
  final String? errorText;

  const DateField({
    super.key,
    required this.value,
    required this.isEditable,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final controller = TextEditingController(text: value != null ? dateFormat.format(value!) : '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorPalette.secondaryText,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: isEditable ? () async {
            final date = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: ColorPalette.blue,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: ColorPalette.primaryText,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) {
              onChanged(date);
            }
          } : null,
          child: IgnorePointer(
            child: TextField(
              controller: controller,
              enabled: isEditable,
              style: AppTypography.body,
              decoration: InputDecoration(
                hintText: dateFormat.format(DateTime.now()),
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
            ),
          ),
        ),
      ],
    );
  }
}
