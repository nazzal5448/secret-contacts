import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primary = Color(0xFFBAC8DC);
  static const Color primaryContainer = Color(0xFF0D1B2A);
  static const Color onPrimaryContainer = Color(0xFF768497);
  
  static const Color secondary = Color(0xFFAFC9EA);
  static const Color secondaryContainer = Color(0xFF2F4865);
  
  static const Color tertiary = Color(0xFF95D4B3);
  static const Color tertiaryContainer = Color(0xFF001F12);
  
  static const Color background = Color(0xFF071327);
  static const Color surface = Color(0xFF071327);
  static const Color surfaceVariant = Color(0xFF2A354B);
  
  static const Color error = Color(0xFFFFB4AB);
  
  static const Color onBackground = Color(0xFFD7E2FF);
  static const Color onSurface = Color(0xFFD7E2FF);
  static const Color onSurfaceVariant = Color(0xFFC4C6CC);

  // Additional design system colors
  static const Color surfaceContainerHighest = Color(0xFF2A354B);
  static const Color surfaceContainerHigh = Color(0xFF1F2A3F);
  static const Color surfaceContainer = Color(0xFF142034);
  static const Color outline = Color(0xFF8E9196);
  static const Color onTertiary = Color(0xFF003824);
  static const Color onSecondaryContainer = Color(0xFF9EB7D8);

  // Spacing
  static const double spacingXs = 4.0;
  static const double spacingBase = 8.0;
  static const double spacingSm = 12.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  
  // Border Radius
  static const double radiusSm = 4.0;
  static const double radiusDefault = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        secondaryContainer: secondaryContainer,
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        background: background,
        surface: surface,
        surfaceVariant: surfaceVariant,
        error: error,
        onBackground: onBackground,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
      ),
      scaffoldBackgroundColor: background,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          height: 56 / 48,
          letterSpacing: -0.02 * 48,
          color: onBackground,
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          height: 40 / 32,
          letterSpacing: -0.01 * 32,
          color: onBackground,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 24 / 18,
          color: onBackground,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 24 / 16,
          color: onBackground,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
          color: onBackground,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 16 / 12,
          letterSpacing: 0.05 * 12,
          color: onSurfaceVariant,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: tertiary, // Emerald primary actions
          foregroundColor: tertiaryContainer,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          minimumSize: const Size(double.infinity, 48),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: secondary,
          side: const BorderSide(color: secondaryContainer, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          minimumSize: const Size(double.infinity, 48),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLg),
          borderSide: const BorderSide(color: tertiary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingMd,
          vertical: spacingMd,
        ),
      ),
    );
  }
}
