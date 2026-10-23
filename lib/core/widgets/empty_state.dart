import 'package:flutter/material.dart';

import '../theme/theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      // Geser ke atas sebesar bar bawah supaya terlihat di tengah area yang terlihat.
      padding: EdgeInsets.fromLTRB(
        40,
        0,
        40,
        MediaQuery.paddingOf(context).bottom,
      ),
      // Dua Spacer memusatkan isi secara vertikal; hanya dipakai di SliverFillRemaining.
      child: Column(
        children: [
          const Spacer(),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: colors.bgMuted.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: colors.textTertiary),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: colors.textTertiary),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
