import 'package:flutter/foundation.dart';

import '../../core/models/song.dart';

class FavoritesController extends ChangeNotifier {
  final List<Song> _songs = [];

  /// Favorit terbaru di paling atas.
  List<Song> get songs => List.unmodifiable(_songs);

  bool isFavorite(Song song) => _songs.any((s) => s.id == song.id);

  void toggle(Song song) {
    if (isFavorite(song)) {
      _songs.removeWhere((s) => s.id == song.id);
    } else {
      _songs.insert(0, song);
    }
    notifyListeners();
  }
}
