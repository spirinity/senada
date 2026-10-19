import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

/// App theme configuration for Senada, registering color tokens
/// and Material 3 ColorSchemes for both Light and Dark themes.
abstract final class AppTheme {
  /// Primary font used for body, labels, and general UI.
  static const String bodyFontFamily = 'Switzer';

  /// Expressive display & editorial font used for headings and titles.
  static const String titleFontFamily = 'Sentient';

  /// Text theme using Sentient for display/headline/title styles and Switzer elsewhere.
  static TextTheme _buildTextTheme(Color defaultTextColor) {
    return TextTheme(
      displayLarge: const TextStyle(fontFamily: titleFontFamily, fontWeight: FontWeight.w700),
      displayMedium: const TextStyle(fontFamily: titleFontFamily, fontWeight: FontWeight.w700),
      displaySmall: const TextStyle(fontFamily: titleFontFamily, fontWeight: FontWeight.w600),
      headlineLarge: const TextStyle(fontFamily: titleFontFamily, fontWeight: FontWeight.w700),
      headlineMedium: const TextStyle(fontFamily: titleFontFamily, fontWeight: FontWeight.w600),
      headlineSmall: const TextStyle(fontFamily: titleFontFamily, fontWeight: FontWeight.w600),
      titleLarge: const TextStyle(fontFamily: titleFontFamily, fontWeight: FontWeight.w600),
      titleMedium: const TextStyle(fontFamily: titleFontFamily, fontWeight: FontWeight.w500),
      titleSmall: const TextStyle(fontFamily: titleFontFamily, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontFamily: bodyFontFamily, color: defaultTextColor),
      bodyMedium: TextStyle(fontFamily: bodyFontFamily, color: defaultTextColor),
      bodySmall: TextStyle(fontFamily: bodyFontFamily, color: defaultTextColor),
      labelLarge: const TextStyle(fontFamily: bodyFontFamily, fontWeight: FontWeight.w500),
      labelMedium: const TextStyle(fontFamily: bodyFontFamily, fontWeight: FontWeight.w500),
      labelSmall: const TextStyle(fontFamily: bodyFontFamily),
    );
  }

  /// Light theme based on `:root` tokens in tokens.css.
  static ThemeData get lightTheme {
    const semantic = AppSemanticColors.light;

    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: semantic.bgBrand, // primary-600 (#911CFF)
      onPrimary: semantic.textOnBrand, // primary-50 (#F7F4FF)
      primaryContainer: AppColors.primary100, // #EEE7FF
      onPrimaryContainer: AppColors.primary900, // #43007C
      secondary: semantic.bgAccent, // accent-600 (#DA0000)
      onSecondary: semantic.textOnAccent, // accent-50 (#FFF3F0)
      secondaryContainer: AppColors.accent100, // #FFE4E0
      onSecondaryContainer: AppColors.accent900, // #670100
      tertiary: semantic.bgTertiary, // accent-2-700 (#2552BE)
      onTertiary: semantic.textOnTertiary, // accent-2-50 (#F1F6FF)
      tertiaryContainer: AppColors.accent2_100, // #E2ECFF
      onTertiaryContainer: AppColors.accent2_900, // #0C2A77
      error: semantic.textError, // error-700 (#A42144)
      onError: semantic.textOnError, // error-50 (#FFF2F3)
      errorContainer: semantic.bgErrorSubtle, // error-100 (#FFE3E6)
      onErrorContainer: AppColors.error900, // #640222
      surface: semantic.bgSurface, // neutral-50 (#F6F5F9)
      onSurface: semantic.textPrimary, // neutral-900 (#343237)
      onSurfaceVariant: semantic.textSecondary, // neutral-800 (#47464B)
      outline: semantic.borderDefault, // neutral-300 (#C1BFC5)
      outlineVariant: semantic.borderSubtle, // neutral-200 (#DAD8DE)
      inverseSurface: semantic.bgInverse, // neutral-900 (#343237)
      onInverseSurface: semantic.textInverse, // neutral-50 (#F6F5F9)
      inversePrimary: AppColors.primary300, // #CAB0FF
      shadow: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: semantic.bgCanvas, // neutral-100 (#ECEAEF)
      fontFamily: bodyFontFamily,
      textTheme: _buildTextTheme(semantic.textPrimary),
      appBarTheme: AppBarTheme(
        backgroundColor: semantic.bgSurface,
        foregroundColor: semantic.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        color: semantic.bgSurfaceRaised,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: semantic.borderSubtle),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        semantic,
      ],
    );
  }

  /// Dark theme based on `.dark` tokens in tokens.css.
  static ThemeData get darkTheme {
    const semantic = AppSemanticColors.dark;

    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: semantic.bgBrand, // primary-500 (#A15EFF)
      onPrimary: semantic.textOnBrand, // primary-950 (#29004F)
      primaryContainer: AppColors.primary800, // #5B00A6
      onPrimaryContainer: AppColors.primary100, // #EEE7FF
      secondary: semantic.bgAccent, // accent-400 (#FF6D5C)
      onSecondary: semantic.textOnAccent, // accent-950 (#410000)
      secondaryContainer: AppColors.accent800, // #8A0000
      onSecondaryContainer: AppColors.accent100, // #FFE4E0
      tertiary: semantic.bgTertiary, // accent-2-500 (#4C83FF)
      onTertiary: semantic.textOnTertiary, // accent-2-950 (#021652)
      tertiaryContainer: AppColors.accent2_800, // #173D9A
      onTertiaryContainer: AppColors.accent2_100, // #E2ECFF
      error: semantic.textError, // error-400 (#FA6D86)
      onError: semantic.textOnError, // error-950 (#3F0012)
      errorContainer: AppColors.error900, // #640222
      onErrorContainer: AppColors.error100, // #FFE3E6
      surface: semantic.bgSurface, // neutral-900 (#343237)
      onSurface: semantic.textPrimary, // neutral-100 (#ECEAEF)
      onSurfaceVariant: semantic.textSecondary, // neutral-300 (#C1BFC5)
      outline: semantic.borderDefault, // neutral-700 (#5D5B61)
      outlineVariant: semantic.borderSubtle, // neutral-800 (#47464B)
      inverseSurface: semantic.bgInverse, // neutral-100 (#ECEAEF)
      onInverseSurface: semantic.textInverse, // neutral-900 (#343237)
      inversePrimary: AppColors.primary700, // #7601D3
      shadow: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: semantic.bgCanvas, // neutral-950 (#1E1D21)
      fontFamily: bodyFontFamily,
      textTheme: _buildTextTheme(semantic.textPrimary),
      appBarTheme: AppBarTheme(
        backgroundColor: semantic.bgSurface,
        foregroundColor: semantic.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        color: semantic.bgSurfaceRaised,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: semantic.borderSubtle),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        semantic,
      ],
    );
  }
}
