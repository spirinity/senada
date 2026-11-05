import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/data/muzo_api.dart';
import '../../core/data/sample_songs.dart';
import '../../core/models/song.dart';

class ExploreController extends ChangeNotifier {
  ExploreController({this.songs = sampleSongs});

  /// Lagu contoh untuk dashboard.
  final List<Song> songs;

  String _query = '';
  List<Song> _results = const [];
  bool _isLoading = false;
  bool _hasError = false;
  Timer? _debounce;

  String get query => _query;
  List<Song> get results => _results;
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
      _debounce = Timer(const Duration(milliseconds: 600), () => _fetch(query.trim()));
    }
  }

  Future<void> _fetch(String query) async {
    List<Song> songs = const [];
    var failed = false;
    try {
      songs = await searchSongs(query);
    } catch (_) {
      failed = true;
    }
    // Abaikan hasil lama bila user sudah mengetik kata kunci lain.
    if (query != _query.trim()) return;
    _results = songs;
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
