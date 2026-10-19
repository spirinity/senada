import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:senada/theme/theme.dart';

void main() {
  group('AppColors design tokens', () {
    test('primary ramp has valid colors matching tokens.css', () {
      expect(AppColors.primary50, const Color(0xFFF7F4FF));
      expect(AppColors.primary500, const Color(0xFFA15EFF));
      expect(AppColors.primary600, const Color(0xFF911CFF));
      expect(AppColors.primary, AppColors.primary600);
    });

    test('accent ramp has valid colors matching tokens.css', () {
      expect(AppColors.accent50, const Color(0xFFFFF3F0));
      expect(AppColors.accent600, const Color(0xFFDA0000));
      expect(AppColors.accent, AppColors.accent600);
    });

    test('accent-2 ramp has valid colors matching tokens.css', () {
      expect(AppColors.accent2_50, const Color(0xFFF1F6FF));
      expect(AppColors.accent2_700, const Color(0xFF2552BE));
      expect(AppColors.accent2, AppColors.accent2_700);
    });

    test('neutral ramp has valid colors matching tokens.css', () {
      expect(AppColors.neutral50, const Color(0xFFF6F5F9));
      expect(AppColors.neutral100, const Color(0xFFECEAEF));
      expect(AppColors.neutral900, const Color(0xFF343237));
      expect(AppColors.neutral950, const Color(0xFF1E1D21));
    });

    test('semantic colors light matches :root tokens', () {
      const light = AppSemanticColors.light;
      expect(light.bgCanvas, const Color(0xFFECEAEF));
      expect(light.bgSurface, const Color(0xFFF6F5F9));
      expect(light.bgBrand, const Color(0xFF911CFF));
      expect(light.bgAccent, const Color(0xFFDA0000));
      expect(light.textPrimary, const Color(0xFF343237));
      expect(light.textOnBrand, const Color(0xFFF7F4FF));
    });

    test('semantic colors dark matches .dark tokens', () {
      const dark = AppSemanticColors.dark;
      expect(dark.bgCanvas, const Color(0xFF1E1D21));
      expect(dark.bgSurface, const Color(0xFF343237));
      expect(dark.bgBrand, const Color(0xFFA15EFF));
      expect(dark.bgAccent, const Color(0xFFFF6D5C));
      expect(dark.textPrimary, const Color(0xFFECEAEF));
      expect(dark.textOnBrand, const Color(0xFF29004F));
    });

    test('semantic colors lerp interpolates smoothly', () {
      const light = AppSemanticColors.light;
      const dark = AppSemanticColors.dark;
      final mid = light.lerp(dark, 0.5);

      expect(mid.bgCanvas, Color.lerp(light.bgCanvas, dark.bgCanvas, 0.5));
      expect(mid.bgBrand, Color.lerp(light.bgBrand, dark.bgBrand, 0.5));
    });
  });

  group('AppTheme setup', () {
    test('lightTheme has correct ColorScheme and AppSemanticColors extension', () {
      final theme = AppTheme.lightTheme;
      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.primary, AppSemanticColors.light.bgBrand);
      expect(theme.scaffoldBackgroundColor, AppSemanticColors.light.bgCanvas);
      expect(theme.extension<AppSemanticColors>(), AppSemanticColors.light);
    });

    test('darkTheme has correct ColorScheme and AppSemanticColors extension', () {
      final theme = AppTheme.darkTheme;
      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.primary, AppSemanticColors.dark.bgBrand);
      expect(theme.scaffoldBackgroundColor, AppSemanticColors.dark.bgCanvas);
      expect(theme.extension<AppSemanticColors>(), AppSemanticColors.dark);
    });

    testWidgets('context.appColors resolves semantic colors correctly', (tester) async {
      late AppSemanticColors resolvedColors;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (context) {
              resolvedColors = context.appColors;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(resolvedColors, AppSemanticColors.light);
    });
  });
}
