import 'package:flutter/material.dart';
import '../models/music_item.dart';
import '../theme/theme.dart';

class ArtistsRow extends StatelessWidget {
  const ArtistsRow({
    super.key,
    required this.artists,
    required this.onArtistTap,
    this.onViewAllTap,
  });

  final List<ArtistItem> artists;
  final ValueChanged<ArtistItem> onArtistTap;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Favorite Artists',
                style: TextStyle(
                  fontFamily: AppTheme.bodyFontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
              InkWell(
                onTap: onViewAllTap ?? () {},
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View all',
                        style: TextStyle(
                          fontFamily: AppTheme.bodyFontFamily,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: colors.textLink,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: colors.textLink,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Horizontal artist avatars list
        SizedBox(
          height: 92,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: artists.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final artist = artists[index];

              return InkWell(
                onTap: () => onArtistTap(artist),
                borderRadius: BorderRadius.circular(32),
                child: SizedBox(
                  width: 60,
                  child: Column(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.5,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x12000000),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            artist.avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: artist.accentColor.withValues(alpha: 0.2),
                              alignment: Alignment.center,
                              child: Text(
                                artist.initials ?? artist.name.substring(0, 1),
                                style: TextStyle(
                                  fontFamily: AppTheme.bodyFontFamily,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: artist.accentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        artist.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTheme.bodyFontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: colors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
