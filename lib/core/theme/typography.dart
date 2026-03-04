import 'package:flutter/material.dart';
import 'color_palette.dart';

class AppTypography {
  // Title: 28px SemiBold
  static const TextStyle title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: ColorPalette.primaryText,
    fontFamily: 'Inter',
  );

  // Section title: 20px SemiBold
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorPalette.primaryText,
    fontFamily: 'Inter',
  );

  // Body: 16px Regular
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorPalette.primaryText,
    fontFamily: 'Inter',
  );

  // Button: 18px SemiBold
  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ColorPalette.primaryText,
    fontFamily: 'Inter',
  );

  // Secondary text: 16px Regular
  static const TextStyle secondaryText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorPalette.secondaryText,
    fontFamily: 'Inter',
  );

  // Small text: 14px Regular
  static const TextStyle smallText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorPalette.secondaryText,
    fontFamily: 'Inter',
  );

  // Caption: 12px Regular
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorPalette.tertiaryText,
    fontFamily: 'Inter',
  );
}
