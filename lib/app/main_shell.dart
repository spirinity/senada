import 'package:flutter/material.dart';

import '../core/widgets/floating_bottom_bar.dart';
import '../features/explore/explore_screen.dart';
import '../features/favorites/favorites_screen.dart';
import '../features/history/history_screen.dart';
import '../features/player/widgets/mini_player.dart';
import 'app_routes.dart';

/// Tiga tab utama + MiniPlayer. IndexedStack menjaga state tiap tab saat berpindah.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Konten mengalir di belakang bar kaca; tinggi bar masuk ke MediaQuery padding bawah.
      extendBody: true,
      body: IndexedStack(
        index: _index,
        // Urutan harus sama dengan item di FloatingBottomBar.
        children: const [ExploreScreen(), FavoritesScreen(), HistoryScreen()],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MiniPlayer(
            onTap: () => Navigator.pushNamed(context, AppRoutes.player),
          ),
          FloatingBottomBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
          ),
        ],
      ),
    );
  }
}
