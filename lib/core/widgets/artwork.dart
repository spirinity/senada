import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Gambar album persegi dengan sudut membulat.
/// [path] bisa asset lokal (lagu contoh) atau URL (hasil pencarian Muzo).
class Artwork extends StatelessWidget {
  const Artwork(this.path, {super.key, this.size, this.radius = 10});

  final String path;

  /// null = ikuti lebar parent.
  final double? size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image(
        image: path.startsWith('http') ? NetworkImage(path) : AssetImage(path),
        width: size,
        height: size,
        fit: BoxFit.cover,
        excludeFromSemantics: true,
        // Gambar gagal dimuat (misalnya offline): tampilkan kotak polos.
        errorBuilder: (context, error, stackTrace) => SizedBox(
          width: size,
          height: size,
          child: ColoredBox(color: context.appColors.bgMuted),
        ),
      ),
    );
  }
}
