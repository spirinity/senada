import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/app_scope.dart';
import '../../../core/models/song.dart';
import '../../../core/theme/theme.dart';

/// Ikon hati yang membaca dan mengubah FavoritesController bersama.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.song, this.color, this.size = 22});

  final Song song;

  /// Warna ikon saat belum difavoritkan.
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final favorites = AppScope.of(context).favorites;
    final colors = context.appColors;

    return ListenableBuilder(
      listenable: favorites,
      builder: (context, _) {
        final isFavorite = favorites.isFavorite(song);
        return IconButton(
          tooltip: isFavorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
          onPressed: () {
            HapticFeedback.lightImpact();
            favorites.toggle(song);
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              child: child,
            ),
            child: Icon(
              isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
              key: ValueKey(isFavorite),
              size: size,
              color: isFavorite ? colors.bgAccent : (color ?? colors.textTertiary),
            ),
          ),
        );
      },
    );
  }
}
