import 'package:flutter/material.dart';

import '../../../app/app_scope.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/artwork.dart';
import '../../../core/widgets/glass_surface.dart';
import '../../../core/widgets/pressable.dart';
import '../now_playing_screen.dart';

/// Player kecil di atas bottom bar; hanya muncul bila ada lagu aktif.
class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final player = AppScope.of(context).player;
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    return ListenableBuilder(
      listenable: player,
      builder: (context, _) {
        final song = player.current;
        return AnimatedSize(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          child: song == null
              // Penuh lebar, tinggi 0: AnimatedSize hanya menganimasikan tinggi.
              ? Container(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Pressable(
                    onTap: onTap,
                    scale: 0.98,
                    borderRadius: BorderRadius.circular(20),
                    child: GlassSurface(
                      radius: 20,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 62),
                        child: Stack(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.fromLTRB(
                                9,
                                0,
                                4,
                                0,
                              ),
                              minVerticalPadding: 0,
                              minTileHeight: 62,
                              horizontalTitleGap: 12,
                              leading: Hero(
                                tag: nowPlayingArtworkTag,
                                child: Artwork(
                                  song.artwork,
                                  size: 44,
                                  radius: 10,
                                ),
                              ),
                              title: Text(
                                song.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.labelLarge?.copyWith(
                                  color: colors.textPrimary,
                                ),
                              ),
                              subtitle: Text(
                                song.artist,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.copyWith(
                                  color: colors.textTertiary,
                                ),
                              ),
                              // Wrap membungkus kedua tombol sesempit isinya di dalam trailing.
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                    tooltip: player.isPlaying
                                        ? 'Jeda'
                                        : 'Putar',
                                    onPressed: player.togglePlay,
                                    icon: Icon(
                                      player.isPlaying
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                      size: 30,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: 'Berikutnya',
                                    onPressed: player.next,
                                    icon: Icon(
                                      Icons.skip_next_rounded,
                                      size: 28,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 20,
                              right: 20,
                              bottom: 0,
                              child: LinearProgressIndicator(
                                value: player.progress.clamp(0, 1),
                                minHeight: 2,
                                color: colors.bgBrand,
                                backgroundColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
