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
      primary: AppPalette.primaryOchre,

      // Your two main accent colors
      secondary: AppPalette.deepOrangeAccent,
      tertiary: AppPalette.mutedTealAccent,
      // Backgrounds and surfaces
      surface: AppPalette.offWhiteBackground,
      // Text colors that are legible on your main surfaces
      onPrimary: AppPalette.textIconBlack,
      onSecondary: AppPalette.offWhiteBackground,
      onTertiary: AppPalette.offWhiteBackground,
      onSurface: AppPalette.textIconBlack,
      // Other important system colors
      error: AppPalette.deepOrangeAccent,
      onError: AppPalette.offWhiteBackground,
    ),

    // Typography with your 4 font types
    textTheme: _textTheme,
    //

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppPalette.primaryOchre,
        textStyle: _textTheme.labelMedium,
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.deepOrangeAccent,
        foregroundColor: AppPalette.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: _textTheme.labelMedium,
      ),
    ),

    // Outlined Button Theme (Secondary Buttons)
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppPalette.mutedTealAccent,
        side: const BorderSide(color: AppPalette.mutedTealAccent, width: 2),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: _textTheme.labelMedium,
      ),
    ),

    // Icon Button Theme
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppPalette.mutedTealAccent,
        side: const BorderSide(color: AppPalette.mutedTealAccent, width: 2),
        shape: const CircleBorder(),
        disabledBackgroundColor: AppPalette.lightGrayNeutral,
        disabledForegroundColor: AppPalette.lightGrayNeutral,
        padding: const EdgeInsets.all(12),
      ),
    ),

    // Input Decoration Theme (for TextFields)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppPalette.grayMedium,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppPalette.grayLight, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppPalette.grayLight, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppPalette.mutedTealAccent,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppPalette.deepOrangeAccent,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppPalette.deepOrangeAccent,
          width: 2,
        ),
      ),
      hintStyle: _textTheme.bodyMedium?.copyWith(
        color: AppPalette.lightGrayNeutral,
      ),
      labelStyle: _textTheme.bodyMedium?.copyWith(
        color: AppPalette.textIconBlack,
      ),
      errorStyle: _textTheme.labelSmall?.copyWith(
        color: AppPalette.deepOrangeAccent,
      ),
    ),
    //
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
