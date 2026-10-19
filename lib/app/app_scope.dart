import 'package:flutter/widgets.dart';

import '../features/favorites/favorites_controller.dart';
import '../features/history/history_controller.dart';
import '../features/player/player_controller.dart';

/// Menyediakan controller yang dipakai lintas layar: `AppScope.of(context).player`.
class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.player,
    required this.favorites,
    required this.history,
    required super.child,
  });

  final PlayerController player;
  final FavoritesController favorites;
  final HistoryController history;

  static AppScope of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<AppScope>()!;

  // Controller tidak pernah diganti; widget mendengarkan perubahannya lewat ListenableBuilder.
  @override
  bool updateShouldNotify(AppScope oldWidget) => false;
}
