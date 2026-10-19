import 'package:flutter/foundation.dart';

import '../../core/data/sample_songs.dart';
import '../../core/models/song.dart';

class ExploreController extends ChangeNotifier {
  ExploreController({this.songs = sampleSongs});

  final List<Song> songs;

  String _query = '';
  String get query => _query;

  bool get isSearching => _query.trim().isNotEmpty;

  /// Lagu yang judul, artis, atau albumnya cocok dengan [query].
  List<Song> get results {
    final q = _query.trim().toLowerCase();
    return songs
        .where((s) =>
            s.title.toLowerCase().contains(q) ||
            s.artist.toLowerCase().contains(q) ||
            s.album.toLowerCase().contains(q))
        .toList();
  }

  void search(String query) {
    if (query == _query) return;
    _query = query;
    notifyListeners();
  }
}
