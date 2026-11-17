import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/data/jamendo_api.dart';
import '../../core/models/album.dart';
import '../../core/models/artist.dart';
import '../../core/models/song.dart';

class ExploreController extends ChangeNotifier {
  ExploreController() {
    loadPopular();
  }

  List<Song> _songs = const [];
  bool _isLoadingPopular = true;
  bool _popularFailed = false;
  bool _disposed = false;

  /// Lagu populer Jamendo untuk dashboard; kosong selama dimuat atau bila gagal.
  List<Song> get songs => _songs;
  bool get isLoadingPopular => _isLoadingPopular;
  bool get popularFailed => _popularFailed;

  Future<void> loadPopular() async {
    _isLoadingPopular = true;
    _popularFailed = false;
    notifyListeners();
    try {
      _songs = await fetchPopularSongs();
      _popularFailed = _songs.isEmpty;
    } catch (_) {
      _popularFailed = true;
    }
    // User bisa pindah tab sebelum request selesai.
    if (_disposed) return;
    _isLoadingPopular = false;
    notifyListeners();
  }

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

  /// Dipanggil setiap ketikan. Request jaringan bisa lambat, jadi request
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
    _disposed = true;
    _debounce?.cancel();
    super.dispose();
  }
}
