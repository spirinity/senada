import 'package:flutter/material.dart';

import '../../app/app_scope.dart';
import '../../core/utils/format.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/screen_header.dart';
import '../../core/widgets/song_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Future<void> _confirmClear(BuildContext context) async {
    final history = AppScope.of(context).history;
    final ok = await showAdaptiveDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('Hapus riwayat?'),
        content: const Text('Semua lagu di riwayat akan dihapus.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Hapus')),
        ],
      ),
    );
    if (ok ?? false) history.clear();
  }

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);

    return SafeArea(
      bottom: false,
      child: ListenableBuilder(
        listenable: Listenable.merge([scope.history, scope.player]),
        builder: (context, _) {
          final entries = scope.history.entries;
          final songs = [for (final e in entries) e.song];
          return Column(
            children: [
              ScreenHeader(
                title: 'Riwayat',
                trailing: entries.isEmpty
                    ? null
                    : TextButton(onPressed: () => _confirmClear(context), child: const Text('Hapus')),
              ),
              Expanded(
                child: entries.isEmpty
                    ? const EmptyState(
                        icon: Icons.history_rounded,
                        title: 'Belum ada riwayat',
                        message: 'Lagu yang kamu putar akan muncul di sini.',
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom + 16),
                        itemCount: entries.length,
                        itemBuilder: (context, i) {
                          final entry = entries[i];
                          return SongTile(
                            key: ValueKey(entry.song.id),
                            song: entry.song,
                            subtitle: '${entry.song.artist} · ${timeAgo(entry.playedAt)}',
                            isActive: scope.player.current?.id == entry.song.id,
                            onTap: () => scope.player.play(entry.song, queue: songs),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
