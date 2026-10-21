import 'package:flutter/material.dart';

import '../models/song.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import 'artwork.dart';
import 'pressable.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.onTap,
    this.isActive = false,
    this.subtitle,
    this.trailing,
  });

  final Song song;
  final VoidCallback onTap;

  /// Lagu ini yang sedang diputar.
  final bool isActive;

  /// Default: "Artis · 3:20".
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    return Pressable(
      onTap: onTap,
      scale: 0.98,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 6, 8, 6),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Artwork(song.artwork, size: 52),
                if (isActive)
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.neutral950.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.graphic_eq_rounded, color: AppColors.neutral50, size: 22),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelLarge?.copyWith(
                      color: isActive ? colors.textLink : colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle ?? '${song.artist} · ${formatDuration(song.duration)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(color: colors.textTertiary),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing! else const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
