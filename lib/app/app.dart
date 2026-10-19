import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../core/theme/theme.dart';
import '../features/favorites/favorites_controller.dart';
import '../features/history/history_controller.dart';
import '../features/player/player_controller.dart';
import 'app_router.dart';
import 'app_routes.dart';
import 'app_scope.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _history = HistoryController();
  final _favorites = FavoritesController();
  late final _player = PlayerController(history: _history);

  @override
  void dispose() {
    _player.dispose();
    _favorites.dispose();
    _history.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      player: _player,
      favorites: _favorites,
      history: _history,
      child: MaterialApp(
        title: 'Senada',
        debugShowCheckedModeBanner: false,
        theme: _withIosFeel(AppTheme.lightTheme),
        darkTheme: _withIosFeel(AppTheme.darkTheme),
        themeMode: ThemeMode.system,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          dragDevices: PointerDeviceKind.values.toSet(),
        ),
        initialRoute: AppRoutes.welcome,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}

/// Transisi halaman gaya iOS di semua platform.
ThemeData _withIosFeel(ThemeData theme) => theme.copyWith(
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        for (final platform in TargetPlatform.values)
          platform: const CupertinoPageTransitionsBuilder(),
      }),
    );
