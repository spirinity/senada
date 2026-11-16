import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/album.dart';
import '../models/artist.dart';
import '../models/song.dart';

/// Cari lagu di YouTube Music lewat Muzo. [Song.id] berisi videoId YouTube,
/// yang nanti dipakai untuk streaming.
Future<List<Song>> searchSongs(String query) async {
  final results = await _search(query, 'songs');
  return results
      // Lewati hasil yang tidak bisa diputar.
      .where(
        (item) => item['videoId'] != null && item['duration_seconds'] != null,
      )
      .map(
        (item) => Song(
          id: item['videoId'],
          title: item['title'],
          artist: _artistNames(item['artists']),
          album: item['album']?['name'] ?? '',
          artwork: _artwork(item['thumbnails']),
          duration: Duration(seconds: item['duration_seconds']),
        ),
      )
      .toList();
}

/// Cari album. [Album.id] dipakai untuk mengambil daftar lagunya.
Future<List<Album>> searchAlbums(String query) async {
  final results = await _search(query, 'albums');
  return results
      .where((item) => item['browseId'] != null)
      .map(
        (item) => Album(
          id: item['browseId'],
          title: item['title'],
          artist: _artistNames(item['artists']),
          year: item['year'] ?? '',
          artwork: _artwork(item['thumbnails']),
        ),
      )
      .toList();
}

Future<List<Artist>> searchArtists(String query) async {
  final results = await _search(query, 'artists');
  return results
      .where((item) => item['browseId'] != null)
      .map(
        (item) => Artist(
          id: item['browseId'],
          name: item['title'],
          photo: _artwork(item['thumbnails']),
        ),
      )
      .toList();
}

/// Daftar lagu dalam [album].
Future<List<Song>> fetchAlbumTracks(Album album) async {
  final data = await _get('/api/albums/${album.id}');
  final tracks = data['tracks'] as List;
  return tracks
      .where(
        (track) => track['videoId'] != null && (track['duration'] ?? '') != '',
      )
      .map(
        (track) => Song(
          id: track['videoId'],
          title: track['title'],
          // Muzo tidak mengisi artis dan gambar per lagu, jadi pakai milik album.
          artist: album.artist,
          album: album.title,
          artwork: album.artwork,
          duration: _parseDuration(track['duration']),
        ),
      )
      .toList();
}

/// Lagu milik [artist]. Halaman artis di Muzo tidak punya durasi lagu, jadi
/// cari lagu dengan nama artis lalu ambil yang memang dinyanyikan artis itu.
Future<List<Song>> fetchArtistSongs(Artist artist) async {
  final songs = await searchSongs(artist.name);
  return songs.where((song) => song.artist.contains(artist.name)).toList();
}

Future<List<dynamic>> _search(String query, String filter) async {
  final data = await _get('/api/search', {'q': query, 'filter': filter});
  return data['results'] as List;
}

Future<dynamic> _get(String path, [Map<String, String>? params]) async {
  final response = await http.get(
    Uri.https('muzo-backend.vercel.app', path, params),
  );
  if (response.statusCode != 200) {
    throw Exception('Muzo error ${response.statusCode}');
  }
  return jsonDecode(utf8.decode(response.bodyBytes));
}

/// Gabungkan nama artis. Artis pada hasil album diawali jenisnya
/// ("Album", "Single", "EP"), jadi label itu dibuang.
String _artistNames(List<dynamic> artists) => artists
    .map((artist) => artist['name'] as String)
    .where((name) => !const ['Album', 'Single', 'EP'].contains(name))
    .join(', ');

/// Gambar dari Muzo kecil (maksimal 226px); ubah ukuran di URL supaya tajam.
String _artwork(List<dynamic> thumbnails) => thumbnails.isEmpty
    ? ''
    : (thumbnails.last['url'] as String).replaceFirst(
        RegExp(r'=w\d+-h\d+'),
        '=w544-h544',
      );

/// "3:25" atau "1:02:03" menjadi Duration.
Duration _parseDuration(String text) => Duration(
  seconds: text
      .split(':')
      .fold(0, (total, part) => total * 60 + int.parse(part)),
);
