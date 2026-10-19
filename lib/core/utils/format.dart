/// 3:07
String formatDuration(Duration d) {
  final s = d.inSeconds;
  return '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';
}

/// "Baru saja", "5 mnt lalu", "2 jam lalu", "3 hari lalu".
String timeAgo(DateTime time, [DateTime? now]) {
  final diff = (now ?? DateTime.now()).difference(time);
  if (diff.inMinutes < 1) return 'Baru saja';
  if (diff.inHours < 1) return '${diff.inMinutes} mnt lalu';
  if (diff.inDays < 1) return '${diff.inHours} jam lalu';
  return '${diff.inDays} hari lalu';
}
