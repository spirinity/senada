import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/screen_header.dart';
import '../../core/widgets/song_tile.dart';
import 'widgets/favorite_button.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);

    return SafeArea(
      bottom: false,
      child: ListenableBuilder(
        listenable: Listenable.merge([scope.favorites, scope.player]),
        builder: (context, _) {
          final songs = scope.favorites.songs;
          return Column(
            children: [
              ScreenHeader(
                caption: '${songs.length} lagu',
                title: 'Favorit',
                trailing: songs.isEmpty
                    ? null
                    : FilledButton.icon(
                        onPressed: () => scope.player.play(songs.first, queue: songs),
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('Putar'),
                      ),
              ),
              Expanded(
                child: songs.isEmpty
                    ? const EmptyState(
                        icon: Icons.favorite_outline_rounded,
                        title: 'Belum ada favorit',
                        message: 'Ketuk ikon hati pada lagu untuk menyimpannya di sini.',
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom + 16),
                        itemCount: songs.length,
                        itemBuilder: (context, i) => SongTile(
                          key: ValueKey(songs[i].id),
                          song: songs[i],
                          isActive: scope.player.current?.id == songs[i].id,
                          onTap: () => scope.player.play(songs[i], queue: songs),
                          trailing: FavoriteButton(song: songs[i]),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
