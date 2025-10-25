import 'package:flutter/material.dart';
part 'tili_palette.dart';

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
      primary: _TiliPalette.ochre,
      primaryContainer: _TiliPalette.ochreLight,

      // Your two main accent colors
      secondary: _TiliPalette.deepOrange,
      onSecondary: _TiliPalette.white,
      onPrimary: _TiliPalette.white,

      tertiary: _TiliPalette.mutedTeal,
      tertiaryContainer: _TiliPalette.veryLightMutedTeal,
      onTertiaryContainer: _TiliPalette.lightMutedTeal,
      surface: _TiliPalette.offWhiteBackground,
      surfaceDim: _TiliPalette.grayMedium,
      surfaceContainer: _TiliPalette.grayLight,
      surfaceContainerLowest: _TiliPalette.white,
      surfaceContainerHigh: _TiliPalette.lightOrche,
      outline: _TiliPalette.lightGrayDark,
      outlineVariant: _TiliPalette.lightGrayMedium,
      onTertiary: _TiliPalette.offWhiteBackground,
      onSurface: _TiliPalette.black,
      onSurfaceVariant: _TiliPalette.lightBlack,
      error: _TiliPalette.deepOrange,
      onError: _TiliPalette.offWhiteBackground,
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _TiliPalette.deepOrange;
        }
        return _TiliPalette.lightGrayMedium;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _TiliPalette.deepOrange;
        }
        return _TiliPalette.veryLightGrayMedium;
      }),

      thumbColor: WidgetStateProperty.all(_TiliPalette.white),
    ),
    textTheme: _textTheme,
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    cardTheme: CardThemeData(
      color: _TiliPalette.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      linearTrackColor: _TiliPalette.grayLight,
      color: _TiliPalette.ochre,
      borderRadius: BorderRadiusGeometry.circular(9999),
      linearMinHeight: 8,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _TiliPalette.ochre,
        textStyle: _textTheme.labelMedium,
        disabledForegroundColor: _TiliPalette.grayMedium,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _TiliPalette.deepOrange,
        foregroundColor: _TiliPalette.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: _textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _TiliPalette.mutedTeal,
        side: const BorderSide(color: _TiliPalette.mutedTeal, width: 2),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: _textTheme.labelMedium,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: _TiliPalette.lightBlack,
        // side: const BorderSide(color: _TiliPalette.mutedTeal, width: 2),
        // shape: const CircleBorder(),
        disabledBackgroundColor: _TiliPalette.grayMedium,
        disabledForegroundColor: _TiliPalette.grayMedium,
        //padding: const EdgeInsets.all(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _TiliPalette.grayLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _TiliPalette.grayMedium, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _TiliPalette.grayMedium, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _TiliPalette.grayMedium, width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _TiliPalette.grayMedium, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _TiliPalette.deepOrange, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _TiliPalette.deepOrange, width: 2),
      ),
      hintStyle: _textTheme.bodyMedium?.copyWith(
        color: _TiliPalette.grayMedium,
      ),
      labelStyle: _textTheme.bodyMedium?.copyWith(
        color: _TiliPalette.lightBlack,
      ),
      errorStyle: _textTheme.labelSmall?.copyWith(
        color: _TiliPalette.deepOrange,
      ),
    ),
    dividerTheme: const DividerThemeData(color: _TiliPalette.grayMedium),
    dialogTheme: DialogThemeData(
      backgroundColor: _TiliPalette.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    appBarTheme: AppBarTheme(
      foregroundColor: _TiliPalette.lightBlack,
      titleTextStyle: _textTheme.headlineSmall,
    ),
  );

  static TextTheme get _textTheme => const TextTheme(
    // Display/Large heading text
    headlineLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: _TiliPalette.lightBlack,
    ),
    headlineMedium: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: _TiliPalette.lightBlack,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: _TiliPalette.lightBlack,
    ),
    bodyLarge: TextStyle(fontSize: 18, color: _TiliPalette.lightBlack),
    // Body text
    bodyMedium: TextStyle(fontSize: 16, color: _TiliPalette.lightBlack),
    // Label/Button text
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: _TiliPalette.lightBlack,
    ),
  );

  // Dark theme - ready for when you need it
  static ThemeData get darkTheme => lightTheme;
}
