import 'package:flutter/material.dart';

class ColorPalette {
  // Primary Colors - Pastel Green
  static const Color greenLight = Color(0xFF4ADE80);
  static const Color green = Color(0xFF34D399);
  static const Color greenDark = Color(0xFF22C55E);

  // Secondary Colors - Pastel Blue
  static const Color blueLight = Color(0xFF60A5FA);
  static const Color blue = Color(0xFF3B82F6);
  static const Color blueDark = Color(0xFF1E40AF);

  // Accent Colors - Pastel Pink
  static const Color pinkLight = Color(0xFFF9A8D4);
  static const Color pink = Color(0xFFF472B6);
  static const Color pinkDark = Color(0xFFEC4899);

  // Pastel Purple
  static const Color purpleLight = Color(0xFFC084FC);
  static const Color purple = Color(0xFFA855F7);
  static const Color purpleDark = Color(0xFF9333EA);

  // Pastel Yellow/Orange
  static const Color yellowLight = Color(0xFFFED7AA);
  static const Color yellow = Color(0xFFFBBF24);
  static const Color orange = Color(0xFFF97316);

  // Pastel Red/Error
  static const Color redLight = Color(0xFFFCA5A5);
  static const Color red = Color(0xFFEF4444);
  static const Color redDark = Color(0xFFDC2626);

  // Pastel Cyan
  static const Color cyanLight = Color(0xFF67E8F9);
  static const Color cyan = Color(0xFF06B6D4);

  // Neutrals
  static const Color background = Color(0xFFFAFBFC);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color borderColor = Color(0xFFE0E7FF);
  static const Color dividerColor = Color(0xFFF3F4F6);
  static const Color primaryText = Color(0xFF0F172A);
  static const Color secondaryText = Color(0xFF64748B);
  static const Color tertiaryText = Color(0xFF94A3B8);

  // Overlay colors (with built-in opacity)
  static const Color blueLight10 = Color(0x1960A5FA);    // blueLight @ 10% opacity
  static const Color redLight10 = Color(0x19FCA5A5);     // redLight @ 10% opacity
  static const Color greenDark15 = Color(0x2622C55E);    // greenDark @ 15% opacity
  static const Color white20 = Color(0x33FFFFFF);        // white @ 20% opacity
  static const Color black04 = Color(0x0A000000);        // black @ 4% opacity

  // Status Colors
  static const Color success = green;
  static const Color warning = yellow;
  static const Color error = red;
  static const Color info = blue;

  // Gradients
  static const LinearGradient greenGradient = LinearGradient(
    colors: [greenLight, greenDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [blueLight, blueDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pinkGradient = LinearGradient(
    colors: [pinkLight, pinkDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [purpleLight, purpleDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [yellowLight, orange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Category color mapping
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
      case 'groceries':
        return orange;
      case 'transport':
      case 'travel':
        return blue;
      case 'entertainment':
      case 'shopping':
        return pink;
      case 'utilities':
      case 'bills':
        return cyan;
      case 'health':
      case 'fitness':
        return green;
      case 'education':
        return purple;
      case 'other':
      default:
        return secondaryText;
    }
  }

  // Category light color mapping
  static Color getCategoryLightColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
      case 'groceries':
        return Color(0xFFFFEDD5);
      case 'transport':
      case 'travel':
        return Color(0xFFEFF6FF);
      case 'entertainment':
      case 'shopping':
        return Color(0xFFFCE7F3);
      case 'utilities':
      case 'bills':
        return Color(0xFFECFDF5);
      case 'health':
      case 'fitness':
        return Color(0xFFEFF6FF);
      case 'education':
        return Color(0xFFF5F3FF);
      case 'other':
      default:
        return Color(0xFFF8FAFC);
    }
  }
}
