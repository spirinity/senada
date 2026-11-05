import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/data/muzo_api.dart';
import '../../core/data/sample_songs.dart';
import '../../core/models/album.dart';
import '../../core/models/artist.dart';
import '../../core/models/song.dart';

class ExploreController extends ChangeNotifier {
  ExploreController({this.songs = sampleSongs});

  /// Lagu contoh untuk dashboard.
  final List<Song> songs;

  String _query = '';
  List<Song> _songResults = const [];
  List<Album> _albumResults = const [];
  List<Artist> _artistResults = const [];
  bool _isLoading = false;
  bool _hasError = false;
  Timer? _debounce;

  String get query => _query;
  List<Song> get songResults => _songResults;
  List<Album> get albumResults => _albumResults;
  List<Artist> get artistResults => _artistResults;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get isSearching => _query.trim().isNotEmpty;

  /// Dipanggil setiap ketikan. Muzo lambat (bisa sampai 5 detik), jadi request
  /// baru dikirim setelah user berhenti mengetik sebentar.
  void search(String query) {
    if (query == _query) return;
    _query = query;
    _debounce?.cancel();
    _isLoading = isSearching;
    _hasError = false;
    notifyListeners();
    if (isSearching) {
      _debounce = Timer(
        const Duration(milliseconds: 600),
        () => _fetch(query.trim()),
      );
    }
  }

  Future<void> _fetch(String query) async {
    List<Song> songs = const [];
    List<Album> albums = const [];
    List<Artist> artists = const [];
    var failed = false;
    try {
      // Tiga pencarian berjalan bersamaan, jadi pindah tab tidak perlu menunggu lagi.
      (songs, albums, artists) = await (
        searchSongs(query),
        searchAlbums(query),
        searchArtists(query),
      ).wait;
    } catch (_) {
      failed = true;
    }
    // Abaikan hasil lama bila user sudah mengetik kata kunci lain.
    if (query != _query.trim()) return;
    _songResults = songs;
    _albumResults = albums;
    _artistResults = artists;
    _hasError = failed;
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
