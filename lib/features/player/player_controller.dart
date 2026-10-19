import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/models/song.dart';
import '../history/history_controller.dart';

/// Satu-satunya sumber state pemutaran, dipakai bersama oleh MiniPlayer dan NowPlayingScreen.
// shortcut: progres disimulasikan dengan Timer tanpa audio, ganti dengan AudioService (just_audio) saat streaming dibuat.
class PlayerController extends ChangeNotifier {
  PlayerController({required HistoryController history}) : _history = history;

  final HistoryController _history;
  static const _tick = Duration(milliseconds: 250);

  List<Song> _queue = const [];
  int _index = -1;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Timer? _timer;

  Song? get current => _index < 0 ? null : _queue[_index];
  bool get isPlaying => _isPlaying;
  Duration get position => _position;

  double get progress {
    final song = current;
    if (song == null) return 0;
    return _position.inMilliseconds / song.duration.inMilliseconds;
  }

  /// Indeks baris lirik yang sedang dinyanyikan, -1 bila belum ada.
  int get lyricIndex =>
      (current?.lyrics ?? const <LyricLine>[]).lastIndexWhere((l) => l.time <= _position);

  /// Putar [song]; [queue] menentukan urutan lagu untuk next/previous.
  void play(Song song, {List<Song>? queue}) {
    _queue = List.of(queue ?? [song]);
    _index = _queue.indexWhere((s) => s.id == song.id);
    if (_index < 0) {
      _queue = [song];
      _index = 0;
    }
    _start();
  }

  void togglePlay() {
    if (current != null) _setPlaying(!_isPlaying);
  }

  void seek(Duration position) {
    final song = current;
    if (song == null) return;
    _position = Duration(
      milliseconds: position.inMilliseconds.clamp(0, song.duration.inMilliseconds),
    );
    notifyListeners();
  }

  void next() {
    if (_queue.isEmpty) return;
    _index = (_index + 1) % _queue.length;
    _start();
  }

  /// Seperti Apple Music: kembali ke awal lagu dulu bila sudah lewat 3 detik.
  void previous() {
    if (_queue.isEmpty) return;
    if (_position > const Duration(seconds: 3)) return seek(Duration.zero);
    _index = (_index - 1 + _queue.length) % _queue.length;
    _start();
  }

  void _start() {
    _position = Duration.zero;
    _history.add(current!);
    _setPlaying(true);
  }

  void _setPlaying(bool playing) {
    _isPlaying = playing;
    _timer?.cancel();
    if (playing) _timer = Timer.periodic(_tick, (_) => _onTick());
    notifyListeners();
  }

  void _onTick() {
    _position += _tick;
    if (_position >= current!.duration) {
      next();
    } else {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
