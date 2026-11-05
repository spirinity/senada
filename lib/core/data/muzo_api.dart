import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/song.dart';

/// Cari lagu di YouTube Music lewat Muzo. [Song.id] berisi videoId YouTube,
/// yang nanti dipakai untuk streaming.
Future<List<Song>> searchSongs(String query) async {
  final url = Uri.https('muzo-backend.vercel.app', '/api/search', {
    'q': query,
    'filter': 'songs',
  });
  final response = await http.get(url);
  if (response.statusCode != 200) {
    throw Exception('Muzo error ${response.statusCode}');
  }

  final data = jsonDecode(utf8.decode(response.bodyBytes));
  final results = data['results'] as List;
  return results
      // Lewati hasil yang tidak bisa diputar.
      .where((item) => item['videoId'] != null && item['duration_seconds'] != null)
      .map((item) => _toSong(item))
      .toList();
}

Song _toSong(Map<String, dynamic> item) {
  final artists = item['artists'] as List;
  final thumbnails = item['thumbnails'] as List;

  return Song(
    id: item['videoId'],
    title: item['title'],
    artist: artists.map((a) => a['name']).join(', '),
    album: item['album']?['name'] ?? '',
    // Gambar terbesar dari Muzo hanya 120px; ubah ukuran di URL supaya tajam.
    artwork: thumbnails.isEmpty
        ? ''
        : (thumbnails.last['url'] as String).replaceFirst(RegExp(r'=w\d+-h\d+'), '=w544-h544'),
    duration: Duration(seconds: item['duration_seconds']),
  );
}
