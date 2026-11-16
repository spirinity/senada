import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/data/lyrics_api.dart';
import '../../core/data/stream_api.dart';
import '../../core/models/song.dart';
import '../history/history_controller.dart';

/// Satu-satunya sumber state pemutaran, dipakai bersama oleh MiniPlayer dan NowPlayingScreen.
// shortcut: tanpa audio_service, jadi pemutaran berhenti saat app ditutup dan belum ada kontrol notifikasi.
class PlayerController extends ChangeNotifier {
  PlayerController({required HistoryController history}) : _history = history {
    _subs = [
      _audio.positionStream.listen((p) {
        // Selama lagu baru dimuat, posisi lama masih terkirim; abaikan.
        if (_loading) return;
        _position = p;
        notifyListeners();
      }),
      _audio.playingStream.listen((playing) {
        _isPlaying = playing;
        notifyListeners();
      }),
      _audio.processingStateStream.listen((state) {
        if (state == ProcessingState.completed) next();
      }),
    ];
  }

  final HistoryController _history;
  final _audio = AudioPlayer();
  late final List<StreamSubscription<Object>> _subs;

  List<Song> _queue = const [];
  int _index = -1;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  List<LyricLine>? _lyrics;
  // Penanda permintaan terbaru, supaya lagu yang terlambat dimuat tidak menimpa lagu baru.
  int _loadId = 0;
  bool _loading = false;

  Song? get current => _index < 0 ? null : _queue[_index];
  bool get isPlaying => _isPlaying;
  Duration get position => _position;

  /// Lirik lagu yang sedang diputar; null selama masih dimuat dari LRCLIB.
  List<LyricLine>? get lyrics => _lyrics;

  double get progress {
    final song = current;
    if (song == null) return 0;
    return _position.inMilliseconds / song.duration.inMilliseconds;
  }

  /// Indeks baris lirik yang sedang dinyanyikan, -1 bila belum ada.
  int get lyricIndex =>
      (_lyrics ?? const <LyricLine>[]).lastIndexWhere((l) => l.time <= _position);

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
    if (current == null) return;
    _isPlaying ? _audio.pause() : _audio.play();
  }

  void seek(Duration position) {
    final song = current;
    if (song == null) return;
    _position = Duration(
      milliseconds: position.inMilliseconds.clamp(0, song.duration.inMilliseconds),
    );
    _audio.seek(_position);
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

  Future<void> _start() async {
    final song = current!;
    final id = ++_loadId;
    _loading = true;
    _position = Duration.zero;
    _lyrics = null;
    _isPlaying = true;
    _history.add(song);
    notifyListeners();
    _loadLyrics(song);
    try {
      await _audio.setAudioSource(await fetchAudioSource(song.id));
      if (id != _loadId) return;
      _loading = false;
      _audio.play();
    } catch (e) {
      // Permintaan lama yang dibatalkan lagu baru bukan error.
      if (id != _loadId) return;
      _loading = false;
      _isPlaying = false;
      notifyListeners();
      debugPrint('Gagal memutar ${song.title}: $e');
    }
  }

  /// Ambil lirik di latar belakang supaya lagu tetap langsung diputar.
  Future<void> _loadLyrics(Song song) async {
    final lines = await fetchLyrics(song);
    // Abaikan hasil lama bila user sudah pindah lagu sebelum request selesai.
    if (current?.id != song.id) return;
    _lyrics = lines;
    notifyListeners();
  }

  @override
  void dispose() {
    for (final sub in _subs) {
      sub.cancel();
    }
    _audio.dispose();
    super.dispose();
  }
}
