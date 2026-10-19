import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/music_item.dart';
import '../theme/theme.dart';

class PlaylistVibeCard extends StatelessWidget {
  const PlaylistVibeCard({
    super.key,
    required this.playlist,
    required this.onTap,
    this.onAddTrackTap,
  });

  final LibraryPlaylistItem playlist;
  final VoidCallback onTap;
  final VoidCallback? onAddTrackTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        decoration: BoxDecoration(
          color: playlist.cardBackgroundColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral950.withValues(alpha: 0.04),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row of fanned album art cards + Add track button
            SizedBox(
              height: 104,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate dynamic card width to fit 4 items comfortably
                  final availableWidth = constraints.maxWidth;
                  final cardWidth = math.min(76.0, (availableWidth - 24) / 4);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...playlist.covers.take(3).map((cover) {
                        return _RotatedAlbumCard(
                          cover: cover,
                          width: cardWidth,
                        );
                      }),
                      // "+ Add track" card matching reference UI
                      _AddTrackCard(
                        width: cardWidth,
                        onTap: onAddTrackTap ?? onTap,
                        accentColor: playlist.accentColor,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 14),

            // Bottom metadata row (clean music playlist context)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        playlist.title,
                        style: const TextStyle(
                          fontFamily: AppTheme.bodyFontFamily,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${playlist.trackCount} Tracks • ${playlist.durationText}',
                        style: const TextStyle(
                          fontFamily: AppTheme.bodyFontFamily,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Play icon button
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: 24,
                      color: playlist.accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RotatedAlbumCard extends StatelessWidget {
  const _RotatedAlbumCard({
    required this.cover,
    required this.width,
  });

  final DeckCoverItem cover;
  final double width;

  @override
  Widget build(BuildContext context) {
    final radians = cover.rotationDegrees * (math.pi / 180.0);

    return Transform.rotate(
      angle: radians,
      child: Container(
        width: width,
        height: 94,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x18000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // High quality album image (local asset or network)
              cover.imageUrl.startsWith('assets/')
                  ? Image.asset(
                      cover.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildFallback(cover),
                    )
                  : Image.network(
                      cover.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildFallback(cover),
                    ),

              // Subtle vinyl groove gloss overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.15),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.15),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallback(DeckCoverItem cover) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: cover.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          cover.icon ?? Icons.album_rounded,
          color: Colors.white.withValues(alpha: 0.9),
          size: 24,
        ),
      ),
    );
  }
}

class _AddTrackCard extends StatelessWidget {
  const _AddTrackCard({
    required this.width,
    required this.onTap,
    required this.accentColor,
  });

  final double width;
  final VoidCallback onTap;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.04,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: width,
          height: 94,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x10000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_rounded,
                size: 28,
                color: accentColor,
              ),
              const SizedBox(height: 4),
              Text(
                'Add\ntrack',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppTheme.bodyFontFamily,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  height: 1.15,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
