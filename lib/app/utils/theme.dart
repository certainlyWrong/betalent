import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade package to version 8.0.1.
///
/// Use in [MaterialApp] like this:
///
/// MaterialApp(
///  theme: AppTheme.light,
///  darkTheme: AppTheme.dark,
///  :
/// );
sealed class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    colors: const FlexSchemeColor(
      // Custom
      primary: Color(0xff0500ff),
      primaryContainer: Color(0xffd0e4ff),
      primaryLightRef: Color(0xff0500ff),
      secondary: Color(0xffac3306),
      secondaryContainer: Color(0xffffdbcf),
      secondaryLightRef: Color(0xffac3306),
      tertiary: Color(0xff006875),
      tertiaryContainer: Color(0xff95f0ff),
      tertiaryLightRef: Color(0xff006875),
      appBarColor: Color(0xffffdbcf),
      error: Color(0xffba1a1a),
      errorContainer: Color(0xffffdad6),
    ),
    usedColors: 2,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    fontFamily: 'Helvetica',
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      // Custom
      primary: Color(0xff9fc9ff),
      primaryContainer: Color(0xff00325b),
      primaryLightRef: Color(0xff0500ff),
      secondary: Color(0xffffb59d),
      secondaryContainer: Color(0xff872100),
      secondaryLightRef: Color(0xffac3306),
      tertiary: Color(0xff86d2e1),
      tertiaryContainer: Color(0xff004e59),
      tertiaryLightRef: Color(0xff006875),
      appBarColor: Color(0xffffdbcf),
      error: Color(0xffffb4ab),
      errorContainer: Color(0xff93000a),
    ),
    usedColors: 2,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    fontFamily: 'Helvetica',
  );
}

sealed class BeTheme {
  static const Color bluePrimary = Color(0xff0500FF);
  static const Color blue100 = Color(0xffEDEFFB);
  static const Color blackNeutral = Color(0xff1C1C1C);
  static const Color gray20Neutral = Color(0xff9E9E9E);
  static const Color gray10Neutral = Color(0xffDFDFDF);
  static const Color gray5Neutral = Color(0xffF5F5F5);
  static const Color grayNeutral = Color(0xffF0F0F0);
  static const Color whiteNeutral = Color(0xffFFFFFF);
}
