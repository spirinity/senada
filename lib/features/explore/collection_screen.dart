import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_scope.dart';
import '../../core/models/song.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/artwork.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/song_tile.dart';
import '../favorites/widgets/favorite_button.dart';
import '../player/widgets/mini_player.dart';

/// Halaman daftar lagu milik satu album atau satu artis.
class CollectionScreen extends StatefulWidget {
  const CollectionScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.artwork,
    required this.loadSongs,
    this.circle = false,
  });

  final String title;
  final String subtitle;
  final String artwork;

  /// Mengambil daftar lagu dari Muzo.
  final Future<List<Song>> Function() loadSongs;

  /// Foto artis dibuat bulat.
  final bool circle;

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  // late: dibuat saat pertama dipakai, jadi request hanya dikirim sekali.
  late final Future<List<Song>> _songs = widget.loadSongs();

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: SafeArea(
        top: false,
        child: MiniPlayer(
          onTap: () => Navigator.pushNamed(context, AppRoutes.player),
        ),
      ),
      body: FutureBuilder(
        future: _songs,
        builder: (context, snapshot) => ListenableBuilder(
          listenable: scope.player,
          builder: (context, _) {
            final songs = snapshot.data ?? const <Song>[];
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    child: Column(
                      children: [
                        Artwork(
                          widget.artwork,
                          size: 180,
                          radius: widget.circle ? 90 : 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: textTheme.headlineSmall,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            widget.subtitle,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colors.textTertiary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (snapshot.connectionState != ConnectionState.done)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (snapshot.hasError)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyState(
                      icon: Icons.wifi_off_rounded,
                      title: 'Gagal memuat',
                      message: 'Periksa koneksi internet lalu coba lagi.',
                    ),
                  )
                else if (songs.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyState(
                      icon: Icons.music_off_rounded,
                      title: 'Belum ada lagu',
                      message: 'Lagu untuk halaman ini tidak ditemukan.',
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 16),
                    sliver: SliverList.builder(
                      itemCount: songs.length,
                      itemBuilder: (context, i) => SongTile(
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
      ),
    );
  }
}
