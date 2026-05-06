import 'package:flutter/material.dart';

class ThemeColors {
  // Professional & Academic Colors
  // Primary: Professional Blue
  static const Color primary = Color(0xFF1F4788); // Deep Professional Blue
  static const Color primaryLight = Color(0xFF2E5FA3);
  static const Color primaryDark = Color(0xFF162D5A);

  // Secondary: Accent Blue
  static const Color secondary = Color(0xFF00A3FF);

  // Success: Professional Green
  static const Color success = Color(0xFF27AE60);

  // Warning: Professional Orange
  static const Color warning = Color(0xFFE67E22);

  // Error: Professional Red
  static const Color error = Color(0xFFE74C3C);

  // Neutral: Professional Grays
  static const Color gray900 = Color(0xFF1A1A1A);
  static const Color gray800 = Color(0xFF2D2D2D);
  static const Color gray700 = Color(0xFF424242);
  static const Color gray600 = Color(0xFF616161);
  static const Color gray500 = Color(0xFF757575);
  static const Color gray400 = Color(0xFF9E9E9E);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray200 = Color(0xFFF5F5F5);
  static const Color gray100 = Color(0xFFFAFAFA);

  // Light mode
  static const Color lightBg = Color(0xFFFAFAFC);
  static const Color lightText = Color(0xFF1A1A1A);
  static const Color lightBorder = Color(0xFFDEE0E6);
  static const Color lightSecondaryText = Color(0xFF616161);

  // Dark mode
  static const Color darkBg = Color(0xFF0F1419);
  static const Color darkCardBg = Color(0xFF1A1F2E);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkBorder = Color(0xFF2D3546);
  static const Color darkSecondaryText = Color(0xFFB0B0B0);

  static Color getBgColor(bool isDarkMode) {
    return isDarkMode ? darkBg : lightBg;
  }

  static Color getCardBgColor(bool isDarkMode) {
    return isDarkMode ? darkCardBg : Colors.white;
  }

  static Color getTextColor(bool isDarkMode) {
    return isDarkMode ? darkText : lightText;
  }

  static Color getSecondaryTextColor(bool isDarkMode) {
    return isDarkMode ? darkSecondaryText : lightSecondaryText;
  }

  static Color getBorderColor(bool isDarkMode) {
    return isDarkMode ? darkBorder : lightBorder;
  }

  static Color getHintTextColor(bool isDarkMode) {
    return isDarkMode ? const Color(0xFF9E9E9E) : Color(0xFF9E9E9E);
  }
}
