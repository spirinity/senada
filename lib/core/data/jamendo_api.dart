import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/album.dart';
import '../models/artist.dart';
import '../models/song.dart';

/// Client ID aplikasi dari devportal.jamendo.com.
const _clientId = '29fc26a8';

/// Cari lagu di Jamendo. [Song.id] berisi id lagu Jamendo, yang dipakai untuk streaming.
Future<List<Song>> searchSongs(String query) async {
  final tracks = await _get('/tracks/', {
    'search': query,
    'type': 'single albumtrack',
    'imagesize': '500',
    'limit': '30',
  });
  return tracks.map(_song).toList();
}

/// Lagu terpopuler Jamendo untuk dashboard, satu lagu per artis.
Future<List<Song>> fetchPopularSongs() async {
  final tracks = await _get('/tracks/', {
    'order': 'popularity_total',
    'groupby': 'artist_id',
    'type': 'single albumtrack',
    'imagesize': '500',
    'limit': '20',
  });
  return tracks.map(_song).toList();
}

/// Cari album. [Album.id] dipakai untuk mengambil daftar lagunya.
Future<List<Album>> searchAlbums(String query) async {
  List<dynamic> items;
  try {
    items = await _once('/albums/', {
      'namesearch': query,
      'imagesize': '500',
      'limit': '30',
    });
  } catch (_) {
    // /albums/ sering membalas Internal Error; susun album dari hasil lagu.
    final tracks = await _get('/tracks/', {
      'search': query,
      'type': 'albumtrack',
      'groupby': 'album_id',
      'imagesize': '500',
      'limit': '30',
    });
    items = [
      for (final t in tracks)
        if ('${t['album_id'] ?? ''}'.isNotEmpty)
          {
            'id': t['album_id'],
            'name': t['album_name'],
            'artist_name': t['artist_name'],
            'releasedate': t['releasedate'],
            'image': t['album_image'],
          },
    ];
  }
  return items
      .map(
        (item) => Album(
          id: '${item['id']}',
          title: _text(item['name']),
          artist: _text(item['artist_name']),
          // releasedate berbentuk "2019-05-01"; ambil tahunnya saja.
          year: '${item['releasedate'] ?? ''}'.split('-').first,
          artwork: item['image'] ?? '',
        ),
      )
      .toList();
}

Future<List<Artist>> searchArtists(String query) async {
  List<dynamic> items;
  try {
    items = await _once('/artists/', {'namesearch': query, 'limit': '30'});
  } catch (_) {
    // Sama seperti album: /artists/ sering error. Fotonya diganti sampul album.
    final tracks = await _get('/tracks/', {
      'search': query,
      'groupby': 'artist_id',
      'imagesize': '500',
      'limit': '30',
    });
    items = [
      for (final t in tracks)
        {
          'id': t['artist_id'],
          'name': t['artist_name'],
          'image': t['album_image'] ?? t['image'],
        },
    ];
  }
  return items
      .map(
        (item) => Artist(
          id: '${item['id']}',
          name: _text(item['name']),
          photo: item['image'] ?? '',
        ),
      )
      .toList();
}

/// Daftar lagu dalam [album].
Future<List<Song>> fetchAlbumTracks(Album album) async {
  List<dynamic> tracks;
  try {
    final results = await _once('/albums/tracks/', {'id': album.id});
    tracks = results.first['tracks'] as List;
    if (tracks.isEmpty) throw Exception('Jamendo: album tanpa lagu');
  } catch (_) {
    // Cadangan lewat /tracks/; urutkan sesuai nomor lagu di album.
    final found = await _get('/tracks/', {
      'album_id': album.id,
      'type': 'albumtrack',
      'limit': '100',
    });
    tracks = [...found]
      ..sort(
        (a, b) => ((a['position'] ?? 0) as num).compareTo(
          (b['position'] ?? 0) as num,
        ),
      );
  }
  return tracks
      .map(
        (track) => Song(
          id: '${track['id']}',
          title: _text(track['name']),
          // Lagu di dalam album tidak membawa artis dan gambar, jadi pakai milik album.
          artist: album.artist,
          album: album.title,
          artwork: album.artwork,
          duration: Duration(seconds: (track['duration'] as num).toInt()),
        ),
      )
      .toList();
}

/// Lagu milik [artist].
Future<List<Song>> fetchArtistSongs(Artist artist) async {
  final tracks = await _get('/tracks/', {
    'artist_id': artist.id,
    'type': 'single albumtrack',
    'imagesize': '500',
    'limit': '50',
  });
  return tracks.map(_song).toList();
}

Song _song(dynamic item) => Song(
  id: '${item['id']}',
  title: _text(item['name']),
  artist: _text(item['artist_name']),
  album: _text(item['album_name']),
  artwork: item['image'] ?? '',
  duration: Duration(seconds: (item['duration'] as num).toInt()),
);

String _text(dynamic value) => unescapeHtml('${value ?? ''}');

/// Jamendo mengirim teks ter-escape HTML ("John &amp; Jane"); kembalikan ke aslinya.
/// Satu kali lewat, supaya "&amp;lt;" menjadi "&lt;" dan bukan "<".
@visibleForTesting
String unescapeHtml(String text) => text.replaceAllMapped(
  RegExp(r'&(#\d+|#x[0-9a-fA-F]+|amp|lt|gt|quot|apos);'),
  (match) {
    final entity = match[1]!;
    final code = entity.startsWith('#x')
        ? int.tryParse(entity.substring(2), radix: 16)
        : entity.startsWith('#')
        ? int.tryParse(entity.substring(1))
        : null;
    // Kode di luar Unicode dibiarkan apa adanya daripada melempar error.
    if (code != null) return code <= 0x10FFFF ? String.fromCharCode(code) : match[0]!;
    return const {'amp': '&', 'lt': '<', 'gt': '>', 'quot': '"', 'apos': "'"}[entity]!;
  },
);

/// Jamendo kadang membalas Internal Error, atau kosong (sekitar 25% panggilan) untuk
/// query yang sebenarnya ada hasilnya, jadi coba ulang sampai 4 kali.
/// Hasil kosong yang sungguhan hanya memakan beberapa detik ekstra.
Future<List<dynamic>> _get(String path, Map<String, String> params) async {
  const attempts = 4;
  for (var attempt = 1; ; attempt++) {
    try {
      final results = await _request(path, params);
      if (results.isNotEmpty || attempt >= attempts) return results;
    } catch (_) {
      if (attempt >= attempts) rethrow;
    }
    await Future.delayed(const Duration(milliseconds: 400));
  }
}

/// Satu kali coba ke endpoint utama; error atau kosong dianggap gagal supaya
/// pemanggil langsung beralih ke cadangan lewat /tracks/.
Future<List<dynamic>> _once(String path, Map<String, String> params) async {
  final results = await _request(path, params);
  if (results.isEmpty) throw Exception('Jamendo: hasil kosong');
  return results;
}

Future<List<dynamic>> _request(String path, Map<String, String> params) async {
  final response = await http.get(
    Uri.https('api.jamendo.com', '/v3.0$path', {
      'client_id': _clientId,
      'format': 'json',
      ...params,
    }),
  );
  if (response.statusCode != 200) {
    throw Exception('Jamendo error ${response.statusCode}');
  }
  final data = jsonDecode(utf8.decode(response.bodyBytes));
  // Jamendo membalas HTTP 200 walau gagal (mis. client ID salah); statusnya ada di headers.
  final headers = data['headers'];
  if (headers['status'] != 'success') {
    throw Exception('Jamendo: ${headers['error_message']}');
  }
  return data['results'] as List;
}
