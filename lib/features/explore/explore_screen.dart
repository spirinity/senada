import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../core/models/song.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/artwork.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/pressable.dart';
import '../../core/widgets/screen_header.dart';
import '../../core/widgets/search_field.dart';
import '../../core/widgets/song_tile.dart';
import '../favorites/widgets/favorite_button.dart';
import 'explore_controller.dart';

/// Dashboard; berganti ke hasil pencarian saat ada kata kunci.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _explore = ExploreController();
  final _search = TextEditingController();

  @override
  void dispose() {
    _explore.dispose();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);

    return SafeArea(
      bottom: false,
      child: ListenableBuilder(
        listenable: Listenable.merge([_explore, scope.player, scope.history]),
        // Satu scroll view: header, pencarian, dan isi bergulir bersama.
        builder: (context, _) => CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            const SliverToBoxAdapter(child: ScreenHeader(title: 'Explore')),
            SliverToBoxAdapter(
              child: SearchField(
                controller: _search,
                onChanged: _explore.search,
                hintText: 'Cari lagu, artis, atau album',
              ),
            ),
            if (_explore.isSearching)
              _SearchResults(explore: _explore)
            else
              _Dashboard(songs: _explore.songs),
          ],
        ),
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard({required this.songs});

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final recent = scope.history.entries.take(8).map((e) => e.song).toList();
    final current = scope.player.current;

    return SliverPadding(
      padding: EdgeInsets.only(
        top: 16,
        bottom: MediaQuery.paddingOf(context).bottom + 16,
      ),
      sliver: SliverList.list(
        children: [
          if (recent.isNotEmpty) ...[
            const _SectionTitle('Baru Diputar'),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _AlbumRow(songs: recent, size: 128),
            ),
          ],
          const _SectionTitle('Album Pilihan'),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _AlbumRow(songs: songs, size: 156),
          ),
          const _SectionTitle('Lagu Populer'),
          for (final song in songs.take(8))
            SongTile(
              song: song,
              isActive: current?.id == song.id,
              onTap: () => scope.player.play(song, queue: songs),
              trailing: FavoriteButton(song: song),
            ),
        ],
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.explore});

  final ExploreController explore;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final results = explore.results;
    final colors = context.appColors;

    if (results.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyState(
          icon: Icons.search_off_rounded,
          title: 'Tidak ada hasil',
          message: 'Coba kata kunci lain untuk "${explore.query.trim()}".',
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.only(
        top: 12,
        bottom: MediaQuery.paddingOf(context).bottom + 16,
      ),
      sliver: SliverList.list(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: Text(
              '${results.length} hasil',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.textTertiary),
            ),
          ),
          for (final song in results)
            SongTile(
              song: song,
              isActive: scope.player.current?.id == song.id,
              onTap: () => scope.player.play(song, queue: results),
              trailing: FavoriteButton(song: song),
            ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

/// Deretan album horizontal; ketuk untuk memutar dengan antrean deretan tersebut.
class _AlbumRow extends StatelessWidget {
  const _AlbumRow({required this.songs, required this.size});

  final List<Song> songs;
  final double size;

  @override
  Widget build(BuildContext context) {
    final player = AppScope.of(context).player;
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: size + 48),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: songs.length,
        itemBuilder: (context, i) {
          final song = songs[i];
          // Jarak antar-kartu lewat padding; kartu terakhir tidak diberi jarak.
          return Padding(
            padding: EdgeInsets.only(right: i == songs.length - 1 ? 0 : 14),
            child: Pressable(
              onTap: () => player.play(song, queue: songs),
              borderRadius: BorderRadius.circular(14),
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: size),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Artwork(song.artwork, size: size, radius: 14),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        song.album,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.labelLarge?.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    Text(
                      song.artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
