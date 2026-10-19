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

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 11) return 'Selamat pagi';
    if (hour < 15) return 'Selamat siang';
    if (hour < 18) return 'Selamat sore';
    return 'Selamat malam';
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);

    return SafeArea(
      bottom: false,
      child: ListenableBuilder(
        listenable: Listenable.merge([_explore, scope.player, scope.history]),
        builder: (context, _) => Column(
          children: [
            ScreenHeader(caption: _greeting, title: 'Explore'),
            SearchField(
              controller: _search,
              onChanged: _explore.search,
              hintText: 'Cari lagu, artis, atau album',
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _explore.isSearching
                    ? _SearchResults(key: const ValueKey('results'), explore: _explore)
                    : _Dashboard(key: const ValueKey('dashboard'), songs: _explore.songs),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard({super.key, required this.songs});

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final recent = scope.history.entries.take(8).map((e) => e.song).toList();
    final current = scope.player.current;

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.only(top: 8, bottom: MediaQuery.paddingOf(context).bottom + 16),
      children: [
        if (recent.isNotEmpty) ...[
          const _SectionTitle('Baru diputar'),
          _AlbumRow(songs: recent, size: 128),
          const SizedBox(height: 20),
        ],
        const _SectionTitle('Album pilihan'),
        _AlbumRow(songs: songs, size: 156),
        const SizedBox(height: 20),
        const _SectionTitle('Lagu populer'),
        for (final song in songs.take(8))
          SongTile(
            song: song,
            isActive: current?.id == song.id,
            onTap: () => scope.player.play(song, queue: songs),
            trailing: FavoriteButton(song: song),
          ),
      ],
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({super.key, required this.explore});

  final ExploreController explore;

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final results = explore.results;
    final colors = context.appColors;

    if (results.isEmpty) {
      return EmptyState(
        icon: Icons.search_off_rounded,
        title: 'Tidak ada hasil',
        message: 'Coba kata kunci lain untuk "${explore.query.trim()}".',
      );
    }

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.only(top: 4, bottom: MediaQuery.paddingOf(context).bottom + 16),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
          child: Text(
            '${results.length} hasil',
            style: TextStyle(fontSize: 13, color: colors.textTertiary),
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
      child: Text(
        text,
        style: TextStyle(
          fontFamily: AppTheme.titleFontFamily,
          fontSize: 21,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          color: context.appColors.textPrimary,
        ),
      ),
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

    return SizedBox(
      height: size + 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: songs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, i) {
          final song = songs[i];
          return Pressable(
            onTap: () => player.play(song, queue: songs),
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: size,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Artwork(song.artwork, size: size, radius: 14),
                  const SizedBox(height: 8),
                  Text(
                    song.album,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  Text(
                    song.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.5, color: colors.textTertiary),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
