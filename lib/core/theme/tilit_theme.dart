import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/core/theme/tili_palette.dart';

// Simple static theme class - no DI bullshit needed
class TiliTheme {
  // Your font family
  static const String fontFamily = 'Nunito Sans';

  // Light theme - your main theme
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,

    // Color scheme using your palette colors
    colorScheme: const ColorScheme.light(
      // Your primary branding color
      primary: TiliPalette.ochre,
      primaryContainer: TiliPalette.ochreLight,

      // Your two main accent colors
      secondary: TiliPalette.deepOrange,
      onSecondary: TiliPalette.white,
      onPrimary: TiliPalette.white,

      tertiary: TiliPalette.mutedTeal,
      tertiaryContainer: TiliPalette.veryLightMutedTeal,
      onTertiaryContainer: TiliPalette.lightMutedTeal,
      surface: TiliPalette.offWhiteBackground,
      surfaceDim: TiliPalette.grayMedium,
      surfaceContainer: TiliPalette.grayLight,
      surfaceContainerLowest: TiliPalette.white,
      surfaceContainerHigh: TiliPalette.lightOrche,
      outline: TiliPalette.lightGrayDark,
      outlineVariant: TiliPalette.lightGrayMedium,
      //onPrimary: TiliPalette.lightBlack,
      onTertiary: TiliPalette.offWhiteBackground,
      onSurface: TiliPalette.black,
      onSurfaceVariant: TiliPalette.lightBlack,
      error: TiliPalette.deepOrange,
      onError: TiliPalette.offWhiteBackground,
    ),
    textTheme: _textTheme,
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    cardTheme: CardThemeData(
      color: TiliPalette.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      linearTrackColor: TiliPalette.grayLight,
      color: TiliPalette.ochre,
      borderRadius: BorderRadiusGeometry.circular(9999),
      linearMinHeight: 8,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: TiliPalette.ochre,
        textStyle: _textTheme.labelMedium,
        disabledForegroundColor: TiliPalette.grayMedium,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: TiliPalette.deepOrange,
        foregroundColor: TiliPalette.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: _textTheme.labelMedium,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: TiliPalette.mutedTeal,
        side: const BorderSide(color: TiliPalette.mutedTeal, width: 2),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: _textTheme.labelMedium,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: TiliPalette.mutedTeal,
        side: const BorderSide(color: TiliPalette.mutedTeal, width: 2),
        shape: const CircleBorder(),
        disabledBackgroundColor: TiliPalette.grayMedium,
        disabledForegroundColor: TiliPalette.grayMedium,
        padding: const EdgeInsets.all(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: TiliPalette.grayLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: TiliPalette.grayMedium, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: TiliPalette.grayMedium, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: TiliPalette.grayMedium, width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: TiliPalette.grayMedium, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: TiliPalette.deepOrange, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: TiliPalette.deepOrange, width: 2),
      ),
      hintStyle: _textTheme.bodyMedium?.copyWith(color: TiliPalette.grayMedium),
      labelStyle: _textTheme.bodyMedium?.copyWith(
        color: TiliPalette.lightBlack,
      ),
      errorStyle: _textTheme.labelSmall?.copyWith(
        color: TiliPalette.deepOrange,
      ),
    ),
    dividerTheme: const DividerThemeData(color: TiliPalette.grayMedium),
  );

  static TextTheme get _textTheme => const TextTheme(
    // Display/Large heading text
    headlineLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: TiliPalette.lightBlack,
    ),
    headlineMedium: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: TiliPalette.lightBlack,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: TiliPalette.lightBlack,
    ),
    bodyLarge: TextStyle(fontSize: 18, color: TiliPalette.lightBlack),
    // Body text
    bodyMedium: TextStyle(fontSize: 16, color: TiliPalette.lightBlack),
    // Label/Button text
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: TiliPalette.lightBlack,
    ),
  );

  // Dark theme - ready for when you need it
  static ThemeData get darkTheme => lightTheme;
}
