import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/song.dart';

/// Ambil lirik sinkron [song] dari LRCLIB (gratis, tanpa API key).
/// Hasil kosong berarti lirik tidak ditemukan atau tidak ada internet.
Future<List<LyricLine>> fetchLyrics(Song song) async {
  final url = Uri.https('lrclib.net', '/api/get', {
    'track_name': song.title,
    'artist_name': song.artist,
    'album_name': song.album,
    'duration': '${song.duration.inSeconds}',
  });

  try {
    // LRCLIB meminta setiap aplikasi menyebutkan namanya.
    final response = await http.get(url, headers: {'Lrclib-Client': 'Senada/1.0'});
    // 404 = lagu tidak ada di LRCLIB, 429 = terlalu banyak request.
    if (response.statusCode != 200) return const [];

    final data = jsonDecode(utf8.decode(response.bodyBytes));
    final synced = data['syncedLyrics'] as String?;
    return synced == null ? const [] : parseLrc(synced);
  } catch (_) {
    return const []; // tidak ada internet
  }
}

/// Ubah teks LRC, misalnya "[01:23.45] Halo", menjadi daftar [LyricLine].
List<LyricLine> parseLrc(String lrc) {
  final pattern = RegExp(r'^\[(\d+):(\d+\.\d+)\](.*)');
  final lines = <LyricLine>[];

  for (final row in lrc.split('\n')) {
    final match = pattern.firstMatch(row);
    if (match == null) continue;

    final minutes = int.parse(match[1]!);
    final seconds = double.parse(match[2]!);
    final time = Duration(milliseconds: ((minutes * 60 + seconds) * 1000).round());
    final text = match[3]!.trim();
    // Baris kosong di LRC berarti jeda musik.
    lines.add(LyricLine(time, text.isEmpty ? '♪' : text));
  }
  return lines;
}
