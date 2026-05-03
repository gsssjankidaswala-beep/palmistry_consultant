import 'package:flutter/material.dart';

class AppTheme {
  // Colors - Palmist side uses a deeper, more professional tone
  static const Color primaryColor = Color(0xFF4A2080); // Deep Indigo-Purple
  static const Color secondaryColor = Color(0xFF00BCD4); // Teal accent
  static const Color accentColor = Color(0xFFFFB300); // Amber gold

  static const Color backgroundColor = Color(0xFFF5F3FA); // Soft lavender-white
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color dividerColor = Color(0xFFE0E0E0);

  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF555577);
  static const Color textHint = Color(0xFF9999BB);

  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color warningColor = Color(0xFFFFA500);
  static const Color infoColor = Color(0xFF3498DB);

  static const Color onlineColor = Color(0xFF4CAF50);
  static const Color busyColor = Color(0xFFFF9800);
  static const Color offlineColor = Color(0xFF9E9E9E);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
      error: errorColor,
      surface: cardBackground,
      background: backgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: textPrimary),
      displayMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: textPrimary),
      headlineSmall: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: textPrimary),
      titleLarge: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
      bodyLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: textPrimary),
      bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal, color: textSecondary),
      labelSmall:
          TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: textHint),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF0EEF8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
      contentPadding: const EdgeInsets.all(16),
      hintStyle: const TextStyle(color: textHint),
    ),
    cardTheme: const CardThemeData(
      color: cardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );
}
