import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Permukaan kaca buram mengambang, dipakai oleh bottom bar dan MiniPlayer.
class GlassSurface extends StatelessWidget {
  const GlassSurface({super.key, required this.child, this.radius = 28});

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final shape = BorderRadius.circular(radius);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: shape,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.12),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: shape,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.bgSurface.withValues(alpha: 0.82),
              borderRadius: shape,
              border: Border.all(color: colors.borderSubtle.withValues(alpha: 0.6)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
