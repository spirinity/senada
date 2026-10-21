import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/pressable.dart';
import '../player_controller.dart';

/// Lirik yang mengikuti posisi lagu; baris aktif digulir ke tengah. Ketuk baris untuk lompat.
class LyricsView extends StatefulWidget {
  const LyricsView({super.key, required this.player});

  final PlayerController player;

  @override
  State<LyricsView> createState() => _LyricsViewState();
}

class _LyricsViewState extends State<LyricsView> {
  final _keys = <GlobalKey>[];
  int _scrolledTo = -1;

  void _scrollTo(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final lineContext = _keys[index].currentContext;
      if (lineContext == null) return;
      Scrollable.ensureVisible(
        lineContext,
        alignment: 0.35,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.player;
    final lines = player.current?.lyrics ?? const [];
    final active = player.lyricIndex;

    final textTheme = Theme.of(context).textTheme;

    if (lines.isEmpty) {
      return Center(
        child: Text(
          'Lirik belum tersedia',
          style: textTheme.bodyLarge?.copyWith(color: AppColors.neutral50.withValues(alpha: 0.7)),
        ),
      );
    }

    if (_keys.length != lines.length) {
      _keys
        ..clear()
        ..addAll(List.generate(lines.length, (_) => GlobalKey()));
    }
    if (active != _scrolledTo && active >= 0) {
      _scrolledTo = active;
      _scrollTo(active);
    }

    // Pudarkan tepi atas dan bawah supaya lirik terlihat muncul dan menghilang.
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (rect) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
        stops: [0, 0.12, 0.85, 1],
      ).createShader(rect),
      // Semua baris dibangun sekaligus agar ensureVisible selalu menemukan barisnya.
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final (i, line) in lines.indexed)
              Pressable(
                key: _keys[i],
                onTap: () => player.seek(line.time),
                scale: 0.98,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      style: textTheme.headlineSmall!.copyWith(
                        color: i == active
                            ? AppColors.neutral50
                            : AppColors.neutral50.withValues(alpha: 0.32),
                      ),
                      child: Text(line.text),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
