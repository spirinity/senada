import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Judul besar di atas tiap tab, gaya "large title" iOS.
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.title,
    this.caption,
    this.trailing,
  });

  final String title;

  /// Teks kecil di atas judul.
  final String? caption;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(20, 16, 16, 12),
      minVerticalPadding: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (caption != null)
            Text(
              caption!.toUpperCase(),
              style: textTheme.labelMedium?.copyWith(
                color: colors.textTertiary,
              ),
            ),
          Text(title, style: textTheme.headlineLarge),
        ],
      ),
      trailing: trailing,
    );
  }
}
