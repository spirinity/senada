import 'package:flutter/material.dart';

/// Gambar album persegi dengan sudut membulat.
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
      child: Image.asset(
        path,
        width: size,
        height: size,
        fit: BoxFit.cover,
        excludeFromSemantics: true,
      ),
    );
  }
}
