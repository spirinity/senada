import 'package:flutter/material.dart';

import '../features/onboarding/welcome_screen.dart';
import '../features/player/now_playing_screen.dart';
import 'app_routes.dart';
import 'main_shell.dart';

/// Satu tempat yang memetakan nama route ke screen.
abstract final class AppRouter {
  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(settings: settings, builder: (_) => const MainShell());
      case AppRoutes.player:
        return _slideUp(settings, const NowPlayingScreen());
      default:
        return MaterialPageRoute(settings: settings, builder: (_) => const WelcomeScreen());
    }
  }

  /// Player muncul dari bawah seperti sheet, menutupi tab yang sedang aktif.
  static Route<void> _slideUp(RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 420),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) => SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutQuart,
            reverseCurve: Curves.easeInCubic,
          ),
        ),
        child: child,
      ),
    );
  }
}
