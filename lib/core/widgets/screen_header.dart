import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Judul besar di atas tiap tab, gaya "large title" iOS.
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({super.key, required this.title, this.caption, this.trailing});

  final String title;

  /// Teks kecil di atas judul.
  final String? caption;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (caption != null)
                  Text(
                    caption!.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      color: colors.textTertiary,
                    ),
                  ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppTheme.titleFontFamily,
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.8,
                    height: 1.15,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
