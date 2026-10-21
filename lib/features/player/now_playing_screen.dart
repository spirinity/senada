import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/app_scope.dart';
import '../../core/models/song.dart';
import '../../core/theme/theme.dart';
import '../../core/utils/format.dart';
import '../../core/widgets/artwork.dart';
import '../../core/widgets/pressable.dart';
import '../favorites/widgets/favorite_button.dart';
import 'player_controller.dart';
import 'widgets/lyrics_view.dart';

// Layar ini selalu di atas artwork gelap, jadi pakai palet netral tetap,
// bukan token semantic yang berubah mengikuti light/dark mode.
const _onMedia = AppColors.neutral50;

/// Layar pemutar penuh dengan dua mode: artwork dan lirik.
class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({super.key});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  bool _showLyrics = false;

  @override
  Widget build(BuildContext context) {
    final player = AppScope.of(context).player;

    return ListenableBuilder(
      listenable: player,
      builder: (context, _) {
        final song = player.current;
        if (song == null) return const Scaffold(backgroundColor: AppColors.neutral950);

        return Scaffold(
          backgroundColor: AppColors.neutral950,
          body: GestureDetector(
            // Geser ke bawah untuk menutup, seperti sheet di iOS.
            onVerticalDragEnd: (d) {
              if ((d.primaryVelocity ?? 0) > 400) Navigator.pop(context);
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                _BlurredBackdrop(song: song),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _TopBar(
                          album: song.album,
                          showLyrics: _showLyrics,
                          onToggleLyrics: () => setState(() => _showLyrics = !_showLyrics),
                        ),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 280),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            child: _showLyrics
                                ? LyricsView(key: const ValueKey('lyrics'), player: player)
                                : _ArtworkView(
                                    key: const ValueKey('artwork'),
                                    song: song,
                                    isPlaying: player.isPlaying,
                                  ),
                          ),
                        ),
                        _TitleRow(song: song),
                        const SizedBox(height: 8),
                        _ProgressBar(player: player, song: song),
                        const SizedBox(height: 8),
                        _Controls(player: player),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Artwork diperbesar dan diburamkan sebagai latar, seperti Apple Music.
class _BlurredBackdrop extends StatelessWidget {
  const _BlurredBackdrop({required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: Transform.scale(
            key: ValueKey(song.id),
            scale: 1.5,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Image.asset(song.artwork, fit: BoxFit.cover, excludeFromSemantics: true),
            ),
          ),
        ),
        ColoredBox(color: AppColors.neutral950.withValues(alpha: 0.45)),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.album, required this.showLyrics, required this.onToggleLyrics});

  final String album;
  final bool showLyrics;
  final VoidCallback onToggleLyrics;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Tutup',
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 32, color: _onMedia),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'SEDANG DIPUTAR',
                  style: textTheme.labelSmall?.copyWith(color: _onMedia.withValues(alpha: 0.6)),
                ),
                Text(
                  album,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelLarge?.copyWith(color: _onMedia),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: showLyrics ? 'Sembunyikan lirik' : 'Tampilkan lirik',
            onPressed: onToggleLyrics,
            style: IconButton.styleFrom(
              backgroundColor: showLyrics ? _onMedia.withValues(alpha: 0.2) : Colors.transparent,
            ),
            icon: Icon(
              showLyrics ? Icons.lyrics_rounded : Icons.lyrics_outlined,
              color: _onMedia,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArtworkView extends StatelessWidget {
  const _ArtworkView({super.key, required this.song, required this.isPlaying});

  final Song song;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        // Artwork mengecil saat dijeda, membesar lagi saat diputar.
        child: AnimatedScale(
          scale: isPlaying ? 1 : 0.82,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          child: AspectRatio(
            aspectRatio: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.4),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Hero(
                tag: 'now-playing-artwork',
                child: Artwork(song.artwork, radius: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                song.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineSmall?.copyWith(color: _onMedia),
              ),
              const SizedBox(height: 2),
              Text(
                song.artist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyLarge?.copyWith(color: _onMedia.withValues(alpha: 0.7)),
              ),
            ],
          ),
        ),
        FavoriteButton(song: song, color: _onMedia, size: 26),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.player, required this.song});

  final PlayerController player;
  final Song song;

  @override
  Widget build(BuildContext context) {
    final timeStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      fontFeatures: const [FontFeature.tabularFigures()],
      color: _onMedia.withValues(alpha: 0.6),
    );

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            activeTrackColor: _onMedia,
            inactiveTrackColor: _onMedia.withValues(alpha: 0.25),
            thumbColor: _onMedia,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
            overlayColor: _onMedia.withValues(alpha: 0.12),
            trackShape: const RoundedRectSliderTrackShape(),
          ),
          child: Slider(
            value: player.progress.clamp(0, 1),
            onChanged: (v) => player.seek(song.duration * v),
            semanticFormatterCallback: (_) => formatDuration(player.position),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatDuration(player.position), style: timeStyle),
              Text('-${formatDuration(song.duration - player.position)}', style: timeStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({required this.player});

  final PlayerController player;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          tooltip: 'Sebelumnya',
          onPressed: player.previous,
          iconSize: 44,
          icon: const Icon(Icons.skip_previous_rounded, color: _onMedia),
        ),
        Semantics(
          button: true,
          label: player.isPlaying ? 'Jeda' : 'Putar',
          child: Pressable(
            onTap: () {
              HapticFeedback.selectionClick();
              player.togglePlay();
            },
            scale: 0.9,
            borderRadius: BorderRadius.circular(40),
            child: Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(color: _onMedia, shape: BoxShape.circle),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                transitionBuilder: (child, a) => ScaleTransition(scale: a, child: child),
                child: Icon(
                  player.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  key: ValueKey(player.isPlaying),
                  size: 42,
                  color: AppColors.neutral950,
                ),
              ),
            ),
          ),
        ),
        IconButton(
          tooltip: 'Berikutnya',
          onPressed: player.next,
          iconSize: 44,
          icon: const Icon(Icons.skip_next_rounded, color: _onMedia),
        ),
      ],
    );
  }
}
