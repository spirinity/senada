import 'package:flutter/material.dart';

/// Design token color ramps imported and converted from `tokens.css`.
///
/// Contains primitive color scales (50-950) for primary, accent,
/// accent-2, neutral, success, warning, error, and info.
abstract final class AppColors {
  // ---------------------------------------------------------------------------
  // Primary Ramp (Violet / Purple)
  // ---------------------------------------------------------------------------
  /// `primary-50`: `oklch(97.3% 0.015 298.6)` -> `#F7F4FF`
  static const Color primary50 = Color(0xFFF7F4FF);

  /// `primary-100`: `oklch(94.1% 0.033 299.1)` -> `#EEE7FF`
  static const Color primary100 = Color(0xFFEEE7FF);

  /// `primary-200`: `oklch(88.4% 0.066 298.7)` -> `#DED0FF`
  static const Color primary200 = Color(0xFFDED0FF);

  /// `primary-300`: `oklch(80.8% 0.113 299)` -> `#CAB0FF`
  static const Color primary300 = Color(0xFFCAB0FF);

  /// `primary-400`: `oklch(71.1% 0.176 298.9)` -> `#B285FF`
  static const Color primary400 = Color(0xFFB285FF);

  /// `primary-500`: `oklch(63.6% 0.228 298.9)` -> `#A15EFF`
  static const Color primary500 = Color(0xFFA15EFF);

  /// `primary-600`: `oklch(55.8% 0.286 298.8)` -> `#911CFF`
  static const Color primary600 = Color(0xFF911CFF);

  /// `primary-700`: `oklch(47.6% 0.255 299)` -> `#7601D3`
  static const Color primary700 = Color(0xFF7601D3);

  /// `primary-800`: `oklch(39.7% 0.213 298.8)` -> `#5B00A6`
  static const Color primary800 = Color(0xFF5B00A6);

  /// `primary-900`: `oklch(32.2% 0.173 299.1)` -> `#43007C`
  static const Color primary900 = Color(0xFF43007C);

  /// `primary-950`: `oklch(23.5% 0.126 299.4)` -> `#29004F`
  static const Color primary950 = Color(0xFF29004F);

  // ---------------------------------------------------------------------------
  // Accent Ramp (Warm / Red-Orange)
  // ---------------------------------------------------------------------------
  /// `accent-50`: `oklch(97.3% 0.014 34.3)` -> `#FFF3F0`
  static const Color accent50 = Color(0xFFFFF3F0);

  /// `accent-100`: `oklch(94% 0.03 27.8)` -> `#FFE4E0`
  static const Color accent100 = Color(0xFFFFE4E0);

  /// `accent-200`: `oklch(88.5% 0.061 29.7)` -> `#FFCBC2`
  static const Color accent200 = Color(0xFFFFCBC2);

  /// `accent-300`: `oklch(80.8% 0.109 29.3)` -> `#FFA597`
  static const Color accent300 = Color(0xFFFFA597);

  /// `accent-400`: `oklch(71.2% 0.181 29.1)` -> `#FF6D5C`
  static const Color accent400 = Color(0xFFFF6D5C);

  /// `accent-500`: `oklch(63.7% 0.249 29.2)` -> `#FF2017`
  static const Color accent500 = Color(0xFFFF2017);

  /// `accent-600`: `oklch(55.8% 0.229 29.2)` -> `#DA0000`
  static const Color accent600 = Color(0xFFDA0000);

  /// `accent-700`: `oklch(47.5% 0.195 29.2)` -> `#B00000`
  static const Color accent700 = Color(0xFFB00000);

  /// `accent-800`: `oklch(39.8% 0.163 29.2)` -> `#8A0000`
  static const Color accent800 = Color(0xFF8A0000);

  /// `accent-900`: `oklch(32.3% 0.132 29.2)` -> `#670100`
  static const Color accent900 = Color(0xFF670100);

  /// `accent-950`: `oklch(23.6% 0.097 29.2)` -> `#410000`
  static const Color accent950 = Color(0xFF410000);

  // ---------------------------------------------------------------------------
  // Accent 2 Ramp (Blue / Indigo)
  // ---------------------------------------------------------------------------
  /// `accent-2-50`: `oklch(97.2% 0.013 262.4)` -> `#F1F6FF`
  static const Color accent2_50 = Color(0xFFF1F6FF);

  /// `accent-2-100`: `oklch(94.1% 0.028 263.4)` -> `#E2ECFF`
  static const Color accent2_100 = Color(0xFFE2ECFF);

  /// `accent-2-200`: `oklch(88.5% 0.056 262.8)` -> `#C6DAFF`
  static const Color accent2_200 = Color(0xFFC6DAFF);

  /// `accent-2-300`: `oklch(80.8% 0.096 264.1)` -> `#A1C0FF`
  static const Color accent2_300 = Color(0xFFA1C0FF);

  /// `accent-2-400`: `oklch(71.2% 0.149 263.7)` -> `#719FFF`
  static const Color accent2_400 = Color(0xFF719FFF);

  /// `accent-2-500`: `oklch(63.8% 0.194 263.8)` -> `#4C83FF`
  static const Color accent2_500 = Color(0xFF4C83FF);

  /// `accent-2-600`: `oklch(55.8% 0.19 263.8)` -> `#376AE1`
  static const Color accent2_600 = Color(0xFF376AE1);

  /// `accent-2-700`: `oklch(47.5% 0.177 263.8)` -> `#2552BE`
  static const Color accent2_700 = Color(0xFF2552BE);

  /// `accent-2-800`: `oklch(39.7% 0.158 263.8)` -> `#173D9A`
  static const Color accent2_800 = Color(0xFF173D9A);

  /// `accent-2-900`: `oklch(32.1% 0.136 263.9)` -> `#0C2A77`
  static const Color accent2_900 = Color(0xFF0C2A77);

  /// `accent-2-950`: `oklch(23.6% 0.112 263.5)` -> `#021652`
  static const Color accent2_950 = Color(0xFF021652);

  // ---------------------------------------------------------------------------
  // Neutral Ramp
  // ---------------------------------------------------------------------------
  /// `neutral-50`: `oklch(97.2% 0.005 297.7)` -> `#F6F5F9`
  static const Color neutral50 = Color(0xFFF6F5F9);

  /// `neutral-100`: `oklch(94% 0.007 304.2)` -> `#ECEAEF`
  static const Color neutral100 = Color(0xFFECEAEF);

  /// `neutral-200`: `oklch(88.6% 0.008 301.3)` -> `#DAD8DE`
  static const Color neutral200 = Color(0xFFDAD8DE);

  /// `neutral-300`: `oklch(80.8% 0.009 301.3)` -> `#C1BFC5`
  static const Color neutral300 = Color(0xFFC1BFC5);

  /// `neutral-400`: `oklch(71.3% 0.01 299.2)` -> `#A3A1A8`
  static const Color neutral400 = Color(0xFFA3A1A8);

  /// `neutral-500`: `oklch(63.7% 0.011 299.1)` -> `#8C8A91`
  static const Color neutral500 = Color(0xFF8C8A91);

  /// `neutral-600`: `oklch(55.8% 0.009 293.8)` -> `#747379`
  static const Color neutral600 = Color(0xFF747379);

  /// `neutral-700`: `oklch(47.5% 0.01 301.2)` -> `#5D5B61`
  static const Color neutral700 = Color(0xFF5D5B61);

  /// `neutral-800`: `oklch(39.7% 0.008 295.2)` -> `#47464B`
  static const Color neutral800 = Color(0xFF47464B);

  /// `neutral-900`: `oklch(32.1% 0.009 303.9)` -> `#343237`
  static const Color neutral900 = Color(0xFF343237);

  /// `neutral-950`: `oklch(23.4% 0.008 297.2)` -> `#1E1D21`
  static const Color neutral950 = Color(0xFF1E1D21);

  // ---------------------------------------------------------------------------
  // Success Ramp (Green)
  // ---------------------------------------------------------------------------
  /// `success-50`: `oklch(97.2% 0.045 150.2)` -> `#E1FFE6`
  static const Color success50 = Color(0xFFE1FFE6);

  /// `success-100`: `oklch(94% 0.074 149.6)` -> `#C9FAD1`
  static const Color success100 = Color(0xFFC9FAD1);

  /// `success-200`: `oklch(88.5% 0.109 150)` -> `#A4EEB3`
  static const Color success200 = Color(0xFFA4EEB3);

  /// `success-300`: `oklch(80.8% 0.145 149.9)` -> `#75DA8D`
  static const Color success300 = Color(0xFF75DA8D);

  /// `success-400`: `oklch(71.1% 0.168 150)` -> `#3EBE66`
  static const Color success400 = Color(0xFF3EBE66);

  /// `success-500`: `oklch(63.7% 0.176 149.9)` -> `#00A74C`
  static const Color success500 = Color(0xFF00A74C);

  /// `success-600`: `oklch(55.9% 0.155 149.8)` -> `#008C3E`
  static const Color success600 = Color(0xFF008C3E);

  /// `success-700`: `oklch(47.6% 0.132 149.7)` -> `#007030`
  static const Color success700 = Color(0xFF007030);

  /// `success-800`: `oklch(39.6% 0.109 150)` -> `#005624`
  static const Color success800 = Color(0xFF005624);

  /// `success-900`: `oklch(32.1% 0.089 149.8)` -> `#003F18`
  static const Color success900 = Color(0xFF003F18);

  /// `success-950`: `oklch(23.5% 0.065 150)` -> `#00260C`
  static const Color success950 = Color(0xFF00260C);

  // ---------------------------------------------------------------------------
  // Warning Ramp (Amber / Yellow)
  // ---------------------------------------------------------------------------
  /// `warning-50`: `oklch(97.2% 0.03 85.6)` -> `#FFF5E0`
  static const Color warning50 = Color(0xFFFFF5E0);

  /// `warning-100`: `oklch(94% 0.055 85.1)` -> `#FCE9C2`
  static const Color warning100 = Color(0xFFFCE9C2);

  /// `warning-200`: `oklch(88.5% 0.081 86.1)` -> `#F1D69B`
  static const Color warning200 = Color(0xFFF1D69B);

  /// `warning-300`: `oklch(80.8% 0.107 84.9)` -> `#E0BB6C`
  static const Color warning300 = Color(0xFFE0BB6C);

  /// `warning-400`: `oklch(71.1% 0.125 85.3)` -> `#C59B37`
  static const Color warning400 = Color(0xFFC59B37);

  /// `warning-500`: `oklch(63.8% 0.131 85.5)` -> `#AF8400`
  static const Color warning500 = Color(0xFFAF8400);

  /// `warning-600`: `oklch(55.9% 0.114 85.8)` -> `#926E02`
  static const Color warning600 = Color(0xFF926E02);

  /// `warning-700`: `oklch(47.5% 0.097 85.3)` -> `#755701`
  static const Color warning700 = Color(0xFF755701);

  /// `warning-800`: `oklch(39.8% 0.082 85.3)` -> `#5B4300`
  static const Color warning800 = Color(0xFF5B4300);

  /// `warning-900`: `oklch(32.1% 0.066 85.8)` -> `#423000`
  static const Color warning900 = Color(0xFF423000);

  /// `warning-950`: `oklch(23.5% 0.048 86.2)` -> `#281C00`
  static const Color warning950 = Color(0xFF281C00);

  // ---------------------------------------------------------------------------
  // Error Ramp (Red / Crimson)
  // ---------------------------------------------------------------------------
  /// `error-50`: `oklch(97.2% 0.014 12)` -> `#FFF2F3`
  static const Color error50 = Color(0xFFFFF2F3);

  /// `error-100`: `oklch(93.9% 0.031 10.3)` -> `#FFE3E6`
  static const Color error100 = Color(0xFFFFE3E6);

  /// `error-200`: `oklch(88.5% 0.062 10.9)` -> `#FFC9CF`
  static const Color error200 = Color(0xFFFFC9CF);

  /// `error-300`: `oklch(80.8% 0.111 11.5)` -> `#FFA2AE`
  static const Color error300 = Color(0xFFFFA2AE);

  /// `error-400`: `oklch(71.3% 0.173 11.7)` -> `#FA6D86`
  static const Color error400 = Color(0xFFFA6D86);

  /// `error-500`: `oklch(63.7% 0.18 11.4)` -> `#E2516F`
  static const Color error500 = Color(0xFFE2516F);

  /// `error-600`: `oklch(55.7% 0.176 11.3)` -> `#C43859`
  static const Color error600 = Color(0xFFC43859);

  /// `error-700`: `oklch(47.6% 0.166 11.4)` -> `#A42144`
  static const Color error700 = Color(0xFFA42144);

  /// `error-800`: `oklch(39.7% 0.148 11.4)` -> `#830F32`
  static const Color error800 = Color(0xFF830F32);

  /// `error-900`: `oklch(32.2% 0.127 11.7)` -> `#640222`
  static const Color error900 = Color(0xFF640222);

  /// `error-950`: `oklch(23.5% 0.094 11.8)` -> `#3F0012`
  static const Color error950 = Color(0xFF3F0012);

  // ---------------------------------------------------------------------------
  // Info Ramp (Blue)
  // ---------------------------------------------------------------------------
  /// `info-50`: `oklch(97.1% 0.014 258.3)` -> `#F0F6FF`
  static const Color info50 = Color(0xFFF0F6FF);

  /// `info-100`: `oklch(94.1% 0.029 254.7)` -> `#DFEDFF`
  static const Color info100 = Color(0xFFDFEDFF);

  /// `info-200`: `oklch(88.5% 0.057 254.1)` -> `#C0DCFF`
  static const Color info200 = Color(0xFFC0DCFF);

  /// `info-300`: `oklch(80.9% 0.098 254.5)` -> `#95C4FF`
  static const Color info300 = Color(0xFF95C4FF);

  /// `info-400`: `oklch(71.2% 0.153 255)` -> `#5BA4FF`
  static const Color info400 = Color(0xFF5BA4FF);

  /// `info-500`: `oklch(63.8% 0.18 254.9)` -> `#2F8BF5`
  static const Color info500 = Color(0xFF2F8BF5);

  /// `info-600`: `oklch(55.8% 0.176 254.8)` -> `#0F72D7`
  static const Color info600 = Color(0xFF0F72D7);

  /// `info-700`: `oklch(47.5% 0.156 255)` -> `#015AB1`
  static const Color info700 = Color(0xFF015AB1);

  /// `info-800`: `oklch(39.6% 0.13 254.9)` -> `#00458A`
  static const Color info800 = Color(0xFF00458A);

  /// `info-900`: `oklch(32.2% 0.105 254.8)` -> `#003267`
  static const Color info900 = Color(0xFF003267);

  /// `info-950`: `oklch(23.4% 0.077 255)` -> `#001D41`
  static const Color info950 = Color(0xFF001D41);

  // ---------------------------------------------------------------------------
  // Main Brand & Semantic Color Anchors
  // ---------------------------------------------------------------------------
  static const Color primary = primary600;
  static const Color accent = accent600;
  static const Color accent2 = accent2_700;
  static const Color neutral = neutral900;
  static const Color success = success700;
  static const Color warning = warning500;
  static const Color error = error600;
  static const Color info = info700;
}

/// Semantic design tokens for Senada, matching the light (`:root`) and dark (`.dark`)
/// semantic definitions from `tokens.css`.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.bgCanvas,
    required this.bgSurface,
    required this.bgSurfaceRaised,
    required this.bgMuted,
    required this.bgBrand,
    required this.bgBrandHover,
    required this.bgBrandActive,
    required this.bgAccent,
    required this.bgAccentHover,
    required this.bgAccentActive,
    required this.bgTertiary,
    required this.bgTertiaryHover,
    required this.bgSuccess,
    required this.bgSuccessSubtle,
    required this.bgWarning,
    required this.bgWarningSubtle,
    required this.bgError,
    required this.bgErrorSubtle,
    required this.bgInfo,
    required this.bgInfoSubtle,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.textLink,
    required this.textOnBrand,
    required this.textOnAccent,
    required this.textOnTertiary,
    required this.textOnSuccess,
    required this.textOnWarning,
    required this.textOnError,
    required this.textOnInfo,
    required this.textSuccess,
    required this.textError,
    required this.textWarning,
    required this.textInfo,
    required this.borderSubtle,
    required this.borderDefault,
    required this.borderStrong,
    required this.borderActive,
    required this.borderError,
    required this.bgInverse,
    required this.textInverse,
    required this.ringFocus,
  });

  /// `color-bg-canvas`
  final Color bgCanvas;

  /// `color-bg-surface`
  final Color bgSurface;

  /// `color-bg-surface-raised`
  final Color bgSurfaceRaised;

  /// `color-bg-muted`
  final Color bgMuted;

  /// `color-bg-brand`
  final Color bgBrand;

  /// `color-bg-brand-hover`
  final Color bgBrandHover;

  /// `color-bg-brand-active`
  final Color bgBrandActive;

  /// `color-bg-accent`
  final Color bgAccent;

  /// `color-bg-accent-hover`
  final Color bgAccentHover;

  /// `color-bg-accent-active`
  final Color bgAccentActive;

  /// `color-bg-tertiary`
  final Color bgTertiary;

  /// `color-bg-tertiary-hover`
  final Color bgTertiaryHover;

  /// `color-bg-success`
  final Color bgSuccess;

  /// `color-bg-success-subtle`
  final Color bgSuccessSubtle;

  /// `color-bg-warning`
  final Color bgWarning;

  /// `color-bg-warning-subtle`
  final Color bgWarningSubtle;

  /// `color-bg-error`
  final Color bgError;

  /// `color-bg-error-subtle`
  final Color bgErrorSubtle;

  /// `color-bg-info`
  final Color bgInfo;

  /// `color-bg-info-subtle`
  final Color bgInfoSubtle;

  /// `color-text-primary`
  final Color textPrimary;

  /// `color-text-secondary`
  final Color textSecondary;

  /// `color-text-tertiary`
  final Color textTertiary;

  /// `color-text-disabled`
  final Color textDisabled;

  /// `color-text-link`
  final Color textLink;

  /// `color-text-on-brand`
  final Color textOnBrand;

  /// `color-text-on-accent`
  final Color textOnAccent;

  /// `color-text-on-tertiary`
  final Color textOnTertiary;

  /// `color-text-on-success`
  final Color textOnSuccess;

  /// `color-text-on-warning`
  final Color textOnWarning;

  /// `color-text-on-error`
  final Color textOnError;

  /// `color-text-on-info`
  final Color textOnInfo;

  /// `color-text-success`
  final Color textSuccess;

  /// `color-text-error`
  final Color textError;

  /// `color-text-warning`
  final Color textWarning;

  /// `color-text-info`
  final Color textInfo;

  /// `color-border-subtle`
  final Color borderSubtle;

  /// `color-border-default`
  final Color borderDefault;

  /// `color-border-strong`
  final Color borderStrong;

  /// `color-border-active`
  final Color borderActive;

  /// `color-border-error`
  final Color borderError;

  /// `color-bg-inverse`
  final Color bgInverse;

  /// `color-text-inverse`
  final Color textInverse;

  /// `color-ring-focus`
  final Color ringFocus;

  /// Light mode semantic tokens (:root in tokens.css)
  static const light = AppSemanticColors(
    bgCanvas: Color(0xFFECEAEF), // color-bg-canvas: oklch(94% 0.007 304.2)
    bgSurface: Color(0xFFF6F5F9), // color-bg-surface: oklch(97.2% 0.005 297.7)
    bgSurfaceRaised: Color(
      0xFFF6F5F9,
    ), // color-bg-surface-raised: oklch(97.2% 0.005 297.7)
    bgMuted: Color(0xFFDAD8DE), // color-bg-muted: oklch(88.6% 0.008 301.3)
    bgBrand: Color(0xFF911CFF), // color-bg-brand: oklch(55.8% 0.286 298.8)
    bgBrandHover: Color(
      0xFF7601D3,
    ), // color-bg-brand-hover: oklch(47.6% 0.255 299)
    bgBrandActive: Color(
      0xFF5B00A6,
    ), // color-bg-brand-active: oklch(39.7% 0.213 298.8)
    bgAccent: Color(0xFFDA0000), // color-bg-accent: oklch(55.8% 0.229 29.2)
    bgAccentHover: Color(
      0xFFB00000,
    ), // color-bg-accent-hover: oklch(47.5% 0.195 29.2)
    bgAccentActive: Color(
      0xFF8A0000,
    ), // color-bg-accent-active: oklch(39.8% 0.163 29.2)
    bgTertiary: Color(
      0xFF2552BE,
    ), // color-bg-tertiary: oklch(47.5% 0.177 263.8)
    bgTertiaryHover: Color(
      0xFF173D9A,
    ), // color-bg-tertiary-hover: oklch(39.7% 0.158 263.8)
    bgSuccess: Color(0xFF007030), // color-bg-success: oklch(47.6% 0.132 149.7)
    bgSuccessSubtle: Color(
      0xFFC9FAD1,
    ), // color-bg-success-subtle: oklch(94% 0.074 149.6)
    bgWarning: Color(0xFFAF8400), // color-bg-warning: oklch(63.8% 0.131 85.5)
    bgWarningSubtle: Color(
      0xFFFCE9C2,
    ), // color-bg-warning-subtle: oklch(94% 0.055 85.1)
    bgError: Color(0xFFC43859), // color-bg-error: oklch(55.7% 0.176 11.3)
    bgErrorSubtle: Color(
      0xFFFFE3E6,
    ), // color-bg-error-subtle: oklch(93.9% 0.031 10.3)
    bgInfo: Color(0xFF015AB1), // color-bg-info: oklch(47.5% 0.156 255)
    bgInfoSubtle: Color(
      0xFFDFEDFF,
    ), // color-bg-info-subtle: oklch(94.1% 0.029 254.7)
    textPrimary: Color(
      0xFF343237,
    ), // color-text-primary: oklch(32.1% 0.009 303.9)
    textSecondary: Color(
      0xFF47464B,
    ), // color-text-secondary: oklch(39.7% 0.008 295.2)
    textTertiary: Color(
      0xFF5D5B61,
    ), // color-text-tertiary: oklch(47.5% 0.01 301.2)
    textDisabled: Color(
      0xFFA3A1A8,
    ), // color-text-disabled: oklch(71.3% 0.01 299.2)
    textLink: Color(0xFF911CFF), // color-text-link: oklch(55.8% 0.286 298.8)
    textOnBrand: Color(
      0xFFF7F4FF,
    ), // color-text-on-brand: oklch(97.3% 0.015 298.6)
    textOnAccent: Color(
      0xFFFFF3F0,
    ), // color-text-on-accent: oklch(97.3% 0.014 34.3)
    textOnTertiary: Color(
      0xFFF1F6FF,
    ), // color-text-on-tertiary: oklch(97.2% 0.013 262.4)
    textOnSuccess: Color(
      0xFFE1FFE6,
    ), // color-text-on-success: oklch(97.2% 0.045 150.2)
    textOnWarning: Color(
      0xFF281C00,
    ), // color-text-on-warning: oklch(23.5% 0.048 86.2)
    textOnError: Color(
      0xFFFFF2F3,
    ), // color-text-on-error: oklch(97.2% 0.014 12)
    textOnInfo: Color(
      0xFFF0F6FF,
    ), // color-text-on-info: oklch(97.1% 0.014 258.3)
    textSuccess: Color(
      0xFF007030,
    ), // color-text-success: oklch(47.6% 0.132 149.7)
    textError: Color(0xFFA42144), // color-text-error: oklch(47.6% 0.166 11.4)
    textWarning: Color(
      0xFF755701,
    ), // color-text-warning: oklch(47.5% 0.097 85.3)
    textInfo: Color(0xFF015AB1), // color-text-info: oklch(47.5% 0.156 255)
    borderSubtle: Color(
      0xFFDAD8DE,
    ), // color-border-subtle: oklch(88.6% 0.008 301.3)
    borderDefault: Color(
      0xFFC1BFC5,
    ), // color-border-default: oklch(80.8% 0.009 301.3)
    borderStrong: Color(
      0xFFA3A1A8,
    ), // color-border-strong: oklch(71.3% 0.01 299.2)
    borderActive: Color(
      0xFF911CFF,
    ), // color-border-active: oklch(55.8% 0.286 298.8)
    borderError: Color(
      0xFFE2516F,
    ), // color-border-error: oklch(63.7% 0.18 11.4)
    bgInverse: Color(0xFF343237), // color-bg-inverse: oklch(32.1% 0.009 303.9)
    textInverse: Color(
      0xFFF6F5F9,
    ), // color-text-inverse: oklch(97.2% 0.005 297.7)
    ringFocus: Color(0xFFA15EFF), // color-ring-focus: oklch(63.6% 0.228 298.9)
  );

  /// Dark mode semantic tokens (.dark in tokens.css)
  static const dark = AppSemanticColors(
    bgCanvas: Color(0xFF1E1D21), // color-bg-canvas: oklch(23.4% 0.008 297.2)
    bgSurface: Color(0xFF343237), // color-bg-surface: oklch(32.1% 0.009 303.9)
    bgSurfaceRaised: Color(
      0xFF47464B,
    ), // color-bg-surface-raised: oklch(39.7% 0.008 295.2)
    bgMuted: Color(0xFF5D5B61), // color-bg-muted: oklch(47.5% 0.01 301.2)
    bgBrand: Color(0xFFA15EFF), // color-bg-brand: oklch(63.6% 0.228 298.9)
    bgBrandHover: Color(
      0xFFB285FF,
    ), // color-bg-brand-hover: oklch(71.1% 0.176 298.9)
    bgBrandActive: Color(
      0xFFCAB0FF,
    ), // color-bg-brand-active: oklch(80.8% 0.113 299)
    bgAccent: Color(0xFFFF6D5C), // color-bg-accent: oklch(71.2% 0.181 29.1)
    bgAccentHover: Color(
      0xFFFFA597,
    ), // color-bg-accent-hover: oklch(80.8% 0.109 29.3)
    bgAccentActive: Color(
      0xFFFFCBC2,
    ), // color-bg-accent-active: oklch(88.5% 0.061 29.7)
    bgTertiary: Color(
      0xFF4C83FF,
    ), // color-bg-tertiary: oklch(63.8% 0.194 263.8)
    bgTertiaryHover: Color(
      0xFF719FFF,
    ), // color-bg-tertiary-hover: oklch(71.2% 0.149 263.7)
    bgSuccess: Color(0xFF00A74C), // color-bg-success: oklch(63.7% 0.176 149.9)
    bgSuccessSubtle: Color(
      0xFF003F18,
    ), // color-bg-success-subtle: oklch(32.1% 0.089 149.8)
    bgWarning: Color(0xFFC59B37), // color-bg-warning: oklch(71.1% 0.125 85.3)
    bgWarningSubtle: Color(
      0xFF423000,
    ), // color-bg-warning-subtle: oklch(32.1% 0.066 85.8)
    bgError: Color(0xFFE2516F), // color-bg-error: oklch(63.7% 0.18 11.4)
    bgErrorSubtle: Color(
      0xFF640222,
    ), // color-bg-error-subtle: oklch(32.2% 0.127 11.7)
    bgInfo: Color(0xFF2F8BF5), // color-bg-info: oklch(63.8% 0.18 254.9)
    bgInfoSubtle: Color(
      0xFF003267,
    ), // color-bg-info-subtle: oklch(32.2% 0.105 254.8)
    textPrimary: Color(
      0xFFECEAEF,
    ), // color-text-primary: oklch(94% 0.007 304.2)
    textSecondary: Color(
      0xFFC1BFC5,
    ), // color-text-secondary: oklch(80.8% 0.009 301.3)
    textTertiary: Color(
      0xFFA3A1A8,
    ), // color-text-tertiary: oklch(71.3% 0.01 299.2)
    textDisabled: Color(
      0xFF747379,
    ), // color-text-disabled: oklch(55.8% 0.009 293.8)
    textLink: Color(0xFFB285FF), // color-text-link: oklch(71.1% 0.176 298.9)
    textOnBrand: Color(
      0xFF29004F,
    ), // color-text-on-brand: oklch(23.5% 0.126 299.4)
    textOnAccent: Color(
      0xFF410000,
    ), // color-text-on-accent: oklch(23.6% 0.097 29.2)
    textOnTertiary: Color(
      0xFF021652,
    ), // color-text-on-tertiary: oklch(23.6% 0.112 263.5)
    textOnSuccess: Color(
      0xFF00260C,
    ), // color-text-on-success: oklch(23.5% 0.065 150)
    textOnWarning: Color(
      0xFF281C00,
    ), // color-text-on-warning: oklch(23.5% 0.048 86.2)
    textOnError: Color(
      0xFF3F0012,
    ), // color-text-on-error: oklch(23.5% 0.094 11.8)
    textOnInfo: Color(0xFF001D41), // color-text-on-info: oklch(23.4% 0.077 255)
    textSuccess: Color(
      0xFF3EBE66,
    ), // color-text-success: oklch(71.1% 0.168 150)
    textError: Color(0xFFFA6D86), // color-text-error: oklch(71.3% 0.173 11.7)
    textWarning: Color(
      0xFFC59B37,
    ), // color-text-warning: oklch(71.1% 0.125 85.3)
    textInfo: Color(0xFF5BA4FF), // color-text-info: oklch(71.2% 0.153 255)
    borderSubtle: Color(
      0xFF47464B,
    ), // color-border-subtle: oklch(39.7% 0.008 295.2)
    borderDefault: Color(
      0xFF5D5B61,
    ), // color-border-default: oklch(47.5% 0.01 301.2)
    borderStrong: Color(
      0xFF747379,
    ), // color-border-strong: oklch(55.8% 0.009 293.8)
    borderActive: Color(
      0xFFA15EFF,
    ), // color-border-active: oklch(63.6% 0.228 298.9)
    borderError: Color(
      0xFFE2516F,
    ), // color-border-error: oklch(63.7% 0.18 11.4)
    bgInverse: Color(0xFFECEAEF), // color-bg-inverse: oklch(94% 0.007 304.2)
    textInverse: Color(
      0xFF343237,
    ), // color-text-inverse: oklch(32.1% 0.009 303.9)
    ringFocus: Color(0xFFB285FF), // color-ring-focus: oklch(71.1% 0.176 298.9)
  );

  @override
  AppSemanticColors copyWith({
    Color? bgCanvas,
    Color? bgSurface,
    Color? bgSurfaceRaised,
    Color? bgMuted,
    Color? bgBrand,
    Color? bgBrandHover,
    Color? bgBrandActive,
    Color? bgAccent,
    Color? bgAccentHover,
    Color? bgAccentActive,
    Color? bgTertiary,
    Color? bgTertiaryHover,
    Color? bgSuccess,
    Color? bgSuccessSubtle,
    Color? bgWarning,
    Color? bgWarningSubtle,
    Color? bgError,
    Color? bgErrorSubtle,
    Color? bgInfo,
    Color? bgInfoSubtle,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? textLink,
    Color? textOnBrand,
    Color? textOnAccent,
    Color? textOnTertiary,
    Color? textOnSuccess,
    Color? textOnWarning,
    Color? textOnError,
    Color? textOnInfo,
    Color? textSuccess,
    Color? textError,
    Color? textWarning,
    Color? textInfo,
    Color? borderSubtle,
    Color? borderDefault,
    Color? borderStrong,
    Color? borderActive,
    Color? borderError,
    Color? bgInverse,
    Color? textInverse,
    Color? ringFocus,
  }) {
    return AppSemanticColors(
      bgCanvas: bgCanvas ?? this.bgCanvas,
      bgSurface: bgSurface ?? this.bgSurface,
      bgSurfaceRaised: bgSurfaceRaised ?? this.bgSurfaceRaised,
      bgMuted: bgMuted ?? this.bgMuted,
      bgBrand: bgBrand ?? this.bgBrand,
      bgBrandHover: bgBrandHover ?? this.bgBrandHover,
      bgBrandActive: bgBrandActive ?? this.bgBrandActive,
      bgAccent: bgAccent ?? this.bgAccent,
      bgAccentHover: bgAccentHover ?? this.bgAccentHover,
      bgAccentActive: bgAccentActive ?? this.bgAccentActive,
      bgTertiary: bgTertiary ?? this.bgTertiary,
      bgTertiaryHover: bgTertiaryHover ?? this.bgTertiaryHover,
      bgSuccess: bgSuccess ?? this.bgSuccess,
      bgSuccessSubtle: bgSuccessSubtle ?? this.bgSuccessSubtle,
      bgWarning: bgWarning ?? this.bgWarning,
      bgWarningSubtle: bgWarningSubtle ?? this.bgWarningSubtle,
      bgError: bgError ?? this.bgError,
      bgErrorSubtle: bgErrorSubtle ?? this.bgErrorSubtle,
      bgInfo: bgInfo ?? this.bgInfo,
      bgInfoSubtle: bgInfoSubtle ?? this.bgInfoSubtle,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      textLink: textLink ?? this.textLink,
      textOnBrand: textOnBrand ?? this.textOnBrand,
      textOnAccent: textOnAccent ?? this.textOnAccent,
      textOnTertiary: textOnTertiary ?? this.textOnTertiary,
      textOnSuccess: textOnSuccess ?? this.textOnSuccess,
      textOnWarning: textOnWarning ?? this.textOnWarning,
      textOnError: textOnError ?? this.textOnError,
      textOnInfo: textOnInfo ?? this.textOnInfo,
      textSuccess: textSuccess ?? this.textSuccess,
      textError: textError ?? this.textError,
      textWarning: textWarning ?? this.textWarning,
      textInfo: textInfo ?? this.textInfo,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderDefault: borderDefault ?? this.borderDefault,
      borderStrong: borderStrong ?? this.borderStrong,
      borderActive: borderActive ?? this.borderActive,
      borderError: borderError ?? this.borderError,
      bgInverse: bgInverse ?? this.bgInverse,
      textInverse: textInverse ?? this.textInverse,
      ringFocus: ringFocus ?? this.ringFocus,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) {
      return this;
    }
    return AppSemanticColors(
      bgCanvas: Color.lerp(bgCanvas, other.bgCanvas, t)!,
      bgSurface: Color.lerp(bgSurface, other.bgSurface, t)!,
      bgSurfaceRaised: Color.lerp(bgSurfaceRaised, other.bgSurfaceRaised, t)!,
      bgMuted: Color.lerp(bgMuted, other.bgMuted, t)!,
      bgBrand: Color.lerp(bgBrand, other.bgBrand, t)!,
      bgBrandHover: Color.lerp(bgBrandHover, other.bgBrandHover, t)!,
      bgBrandActive: Color.lerp(bgBrandActive, other.bgBrandActive, t)!,
      bgAccent: Color.lerp(bgAccent, other.bgAccent, t)!,
      bgAccentHover: Color.lerp(bgAccentHover, other.bgAccentHover, t)!,
      bgAccentActive: Color.lerp(bgAccentActive, other.bgAccentActive, t)!,
      bgTertiary: Color.lerp(bgTertiary, other.bgTertiary, t)!,
      bgTertiaryHover: Color.lerp(bgTertiaryHover, other.bgTertiaryHover, t)!,
      bgSuccess: Color.lerp(bgSuccess, other.bgSuccess, t)!,
      bgSuccessSubtle: Color.lerp(bgSuccessSubtle, other.bgSuccessSubtle, t)!,
      bgWarning: Color.lerp(bgWarning, other.bgWarning, t)!,
      bgWarningSubtle: Color.lerp(bgWarningSubtle, other.bgWarningSubtle, t)!,
      bgError: Color.lerp(bgError, other.bgError, t)!,
      bgErrorSubtle: Color.lerp(bgErrorSubtle, other.bgErrorSubtle, t)!,
      bgInfo: Color.lerp(bgInfo, other.bgInfo, t)!,
      bgInfoSubtle: Color.lerp(bgInfoSubtle, other.bgInfoSubtle, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      textLink: Color.lerp(textLink, other.textLink, t)!,
      textOnBrand: Color.lerp(textOnBrand, other.textOnBrand, t)!,
      textOnAccent: Color.lerp(textOnAccent, other.textOnAccent, t)!,
      textOnTertiary: Color.lerp(textOnTertiary, other.textOnTertiary, t)!,
      textOnSuccess: Color.lerp(textOnSuccess, other.textOnSuccess, t)!,
      textOnWarning: Color.lerp(textOnWarning, other.textOnWarning, t)!,
      textOnError: Color.lerp(textOnError, other.textOnError, t)!,
      textOnInfo: Color.lerp(textOnInfo, other.textOnInfo, t)!,
      textSuccess: Color.lerp(textSuccess, other.textSuccess, t)!,
      textError: Color.lerp(textError, other.textError, t)!,
      textWarning: Color.lerp(textWarning, other.textWarning, t)!,
      textInfo: Color.lerp(textInfo, other.textInfo, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      borderActive: Color.lerp(borderActive, other.borderActive, t)!,
      borderError: Color.lerp(borderError, other.borderError, t)!,
      bgInverse: Color.lerp(bgInverse, other.bgInverse, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      ringFocus: Color.lerp(ringFocus, other.ringFocus, t)!,
    );
  }
}

/// Convenience extension on [BuildContext] to access semantic design tokens.
extension AppSemanticColorsBuildContextExtension on BuildContext {
  /// Returns the current [AppSemanticColors] registered on the active theme.
  AppSemanticColors get appColors =>
      Theme.of(this).extension<AppSemanticColors>() ?? AppSemanticColors.light;
}

/// Convenience extension on [ThemeData] to access semantic design tokens.
extension AppSemanticColorsThemeDataExtension on ThemeData {
  /// Returns the [AppSemanticColors] registered on this [ThemeData].
  AppSemanticColors get appColors =>
      extension<AppSemanticColors>() ?? AppSemanticColors.light;
}
