import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/core/theme/palette.dart';

// Simple static theme class - no DI bullshit needed
class AppTheme {
  // Your font family
  static const String fontFamily = 'Nunito Sans';

  // Light theme - your main theme
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,

    // Color scheme using your palette colors
    colorScheme: const ColorScheme.light(
      // Your primary branding color
      primary: Palette.primaryOchre,

      // Your two main accent colors
      secondary: Palette.deepOrangeAccent,
      tertiary: Palette.mutedTealAccent,
      // Backgrounds and surfaces
      surface: Palette.offWhiteBackground,
      // Text colors that are legible on your main surfaces
      onPrimary: Palette.textIconBlack,
      onSecondary: Palette.offWhiteBackground,
      onTertiary: Palette.offWhiteBackground,
      onSurface: Palette.textIconBlack,
      // Other important system colors
      error: Palette.deepOrangeAccent,
      onError: Palette.offWhiteBackground,
    ),

    // Typography with your 4 font types
    textTheme: _textTheme,
    //

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Palette.primaryOchre,
        textStyle: _textTheme.labelMedium,
      ),
    ),
  );

  static TextTheme get _textTheme => const TextTheme(
    // Display/Large heading text
    headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    // Medium heading text
    headlineMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    // Body text
    bodyMedium: TextStyle(fontSize: 16),
    // Label/Button text
    labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );

  // Dark theme - ready for when you need it
  static ThemeData get darkTheme => lightTheme;
}
