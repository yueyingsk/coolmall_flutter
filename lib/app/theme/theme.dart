import 'package:coolmall_flutter/app/theme/color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryDefault,
    // 其他浅色主题配置
    colorScheme: ColorScheme.light(
      primary: primaryDefault,
      secondary: colorPurple,
      tertiary: colorSuccess,
      surface: bgWhiteLight,
      error: colorDanger,
      onPrimary: textWhite,
      onSecondary: textWhite,
      onTertiary: textWhite,
      onSurface: textPrimaryLight,
      onError: textWhite,
      outline: borderLight,
      surfaceTint: primaryDefault,
      surfaceContainer: bgWhiteLight,
      surfaceContainerHigh: bgWhiteLight,
      surfaceContainerHighest: bgWhiteLight,
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryDefault,
    // 其他深色主题配置
    colorScheme: ColorScheme.dark(
      primary: primaryDefault,
      secondary: colorPurple,
      tertiary: colorSuccess,
      surface: bgGreyDark,
      error: colorDanger,
      onPrimary: textWhite,
      onSecondary: textWhite,
      onTertiary: textWhite,
      onSurface: textPrimaryDark,
      onError: textWhite,
      outline: borderDark,
      surfaceTint: bgColorDark,
      surfaceContainer: bgWhiteDark,
      surfaceContainerHigh: bgWhiteDark,
      surfaceContainerHighest: bgWhiteDark,
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
