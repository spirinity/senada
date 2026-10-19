import 'package:flutter/material.dart';
import '../models/music_item.dart';
import '../theme/theme.dart';

class StackedDeckView extends StatelessWidget {
  const StackedDeckView({
    super.key,
    required this.playlist,
    required this.onExploreTap,
    this.onBackTap,
    this.onMenuTap,
  });

  final LibraryPlaylistItem playlist;
  final VoidCallback onExploreTap;
  final VoidCallback? onBackTap;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Stacked Cards Deck
            SizedBox(
              width: 290,
              height: 330,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Layer 3 (furthest top peeking layer)
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 240,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFDDD2), // warm peach top
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Layer 2 (middle dark blue/gradient peeking layer)
                  Positioned(
                    top: 14,
                    child: Container(
                      width: 260,
                      height: 32,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Front Hero Card
                  Positioned(
                    top: 28,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.white, width: 6),
                        boxShadow: [
                          BoxShadow(
                            color: playlist.accentColor.withValues(alpha: 0.16),
                            blurRadius: 36,
                            offset: const Offset(0, 18),
                          ),
                          const BoxShadow(
                            color: Color(0x15000000),
                            blurRadius: 24,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(26),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Hero Image (local asset or network)
                            playlist.heroImageUrl.startsWith('assets/')
                                ? Image.asset(
                                    playlist.heroImageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => _buildHeroFallback(playlist),
                                  )
                                : Image.network(
                                    playlist.heroImageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => _buildHeroFallback(playlist),
                                  ),

                            // Gradient overlay for contrast
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              height: 120,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.65),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),

                            // Inset Bottom Info Bar inside Card (pure music context)
                            Positioned(
                              bottom: 12,
                              left: 14,
                              right: 14,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.94),
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x15000000),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            playlist.genre,
                                            style: const TextStyle(
                                              fontFamily: AppTheme.bodyFontFamily,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF1F2937),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '${playlist.trackCount} Tracks • ${playlist.durationText}',
                                            style: TextStyle(
                                              fontFamily: AppTheme.bodyFontFamily,
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Music play indicator icon
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF3B82F6),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.play_arrow_rounded,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Playlist Title
            Text(
              playlist.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppTheme.titleFontFamily,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
                letterSpacing: -0.6,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 6),

            // Subtitle
            Text(
              '${playlist.trackCount} Tracks • ${playlist.durationText}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppTheme.bodyFontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: colors.textTertiary,
              ),
            ),
            const SizedBox(height: 22),

            // Gradient "Explore Playlist" button
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x403B82F6),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: onExploreTap,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Explore Playlist',
                  style: TextStyle(
                    fontFamily: AppTheme.bodyFontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroFallback(LibraryPlaylistItem playlist) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [playlist.accentColor, const Color(0xFF1E1B4B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.queue_music_rounded,
          color: Colors.white,
          size: 64,
        ),
      ),
    );
  }
}
