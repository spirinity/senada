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

  // Dipakai bersama oleh artwork dan overlay "sedang diputar" supaya ukurannya selalu sama.
  static const _artworkSize = 52.0;
  static const _artworkRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    return Pressable(
      onTap: onTap,
      scale: 0.98,
      // ListTile membagi lebar leading, teks, dan trailing sendiri.
      child: ListTile(
        // Tanpa trailing, sisi kanan diberi jarak lebih lebar.
        contentPadding: EdgeInsets.fromLTRB(
          20,
          0,
          trailing == null ? 20 : 8,
          0,
        ),
        minVerticalPadding: 6,
        minTileHeight: 64,
        horizontalTitleGap: 14,
        leading: Stack(
          alignment: Alignment.center,
          children: [
            Artwork(song.artwork, size: _artworkSize, radius: _artworkRadius),
            if (isActive)
              Container(
                width: _artworkSize,
                height: _artworkSize,
                decoration: BoxDecoration(
                  color: AppColors.neutral950.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(_artworkRadius),
                ),
                child: const Icon(
                  Icons.graphic_eq_rounded,
                  color: AppColors.neutral50,
                  size: 22,
                ),
              ),
          ],
        ),
        title: Text(
          song.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.labelLarge?.copyWith(
            color: isActive ? colors.textLink : colors.textPrimary,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            subtitle ?? '${song.artist} · ${formatDuration(song.duration)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(color: colors.textTertiary),
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
