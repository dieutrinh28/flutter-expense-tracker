import 'package:flutter/material.dart';
import '../../../../../core/theme/color_palette.dart';
import '../../../../../core/theme/typography.dart';
import '../config/screen_mode.dart';

class ExpenseHeader extends StatelessWidget {
  final ScreenMode mode;
  final String? subtitle;
  final VoidCallback? onBack;
  final VoidCallback? onClose;

  const ExpenseHeader({
    super.key,
    required this.mode,
    this.subtitle,
    this.onBack,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                color: ColorPalette.secondaryText,
                onPressed: onBack ?? () => Navigator.of(context).pop(),
              ),
              Text(
                mode.screenTitle,
                style: AppTypography.title.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.primaryText,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 24),
                color: ColorPalette.tertiaryText,
                onPressed: onClose ?? () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        const Divider(color: ColorPalette.dividerColor, height: 1),
      ],
    );
  }
}
