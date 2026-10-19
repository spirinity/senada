import 'package:flutter/foundation.dart';

import '../../core/models/play_history.dart';
import '../../core/models/song.dart';

class HistoryController extends ChangeNotifier {
  final List<PlayHistory> _entries = [];

  /// Terbaru di paling atas, satu entri per lagu.
  List<PlayHistory> get entries => List.unmodifiable(_entries);

  void add(Song song) {
    _entries.removeWhere((e) => e.song.id == song.id);
    _entries.insert(0, PlayHistory(song, DateTime.now()));
    notifyListeners();
  }

  void clear() {
    _entries.clear();
    notifyListeners();
  }
}
