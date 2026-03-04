import 'package:flutter/material.dart';
import 'color_palette.dart';
import 'typography.dart';
import 'spacing.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorPalette.background,
      colorScheme: ColorScheme.light(
        primary: ColorPalette.greenDark,
        secondary: ColorPalette.blueDark,
        tertiary: ColorPalette.pinkDark,
        surface: ColorPalette.cardBackground,
        onSurface: ColorPalette.background,
      ),
      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: ColorPalette.cardBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.title.copyWith(
          color: ColorPalette.primaryText,
        ),
        iconTheme: const IconThemeData(color: ColorPalette.primaryText),
      ),
      // Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          backgroundColor: ColorPalette.greenDark,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppSpacing.radiusButton),
          ),
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeight),
          textStyle: AppTypography.button,
        ),
      ),
      // Text Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorPalette.cardBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusInput),
          borderSide: const BorderSide(color: ColorPalette.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusInput),
          borderSide: const BorderSide(color: ColorPalette.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusInput),
          borderSide: const BorderSide(
            color: ColorPalette.greenDark,
            width: 2,
          ),
        ),
        hintStyle: AppTypography.secondaryText,
        labelStyle: AppTypography.body,
      ),
      // Bottom Navigation
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorPalette.cardBackground,
        selectedItemColor: ColorPalette.greenDark,
        unselectedItemColor: ColorPalette.secondaryText,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      // FloatingActionButton
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorPalette.greenDark,
        foregroundColor: Colors.white,
        elevation: 4,
        sizeConstraints: BoxConstraints.tight(
          const Size(AppSpacing.fabSize, AppSpacing.fabSize),
        ),
        shape: const CircleBorder(),
      ),
      // Card
      cardTheme: CardThemeData(
        color: ColorPalette.cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        ),
      ),
      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTypography.title,
        headlineSmall: AppTypography.sectionTitle,
        bodyLarge: AppTypography.body,
        bodyMedium: AppTypography.secondaryText,
        labelLarge: AppTypography.button,
      ),
    );
  }
}
