import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final _yt = YoutubeExplode();

/// Sumber audio untuk [videoId]. URL kedaluwarsa dalam beberapa jam, jadi
/// ambil setiap kali lagu mulai diputar.
// shortcut: meniru klien YouTube lewat youtube_explode_dart, bisa rusak bila YouTube berubah, update package-nya.
Future<AudioSource> fetchAudioSource(String videoId) async {
  final manifest = await _yt.videos.streamsClient.getManifest(videoId);
  final audio = manifest.audioOnly;
  // Utamakan AAC (mp4) karena iOS tidak bisa memutar opus/webm.
  final aac = audio.where((s) => s.container == StreamContainer.mp4);
  return _YoutubeAudioSource((aac.isNotEmpty ? aac : audio).withHighestBitrate());
}

/// googlevideo menolak (403) request tanpa batas akhir Range, padahal itu cara
/// ExoPlayer meminta file, jadi unduh sendiri per potongan dengan Range eksplisit.
class _YoutubeAudioSource extends StreamAudioSource {
  _YoutubeAudioSource(this._info);

  final AudioOnlyStreamInfo _info;
  static const _chunk = 1 << 20;

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    final total = _info.size.totalBytes;
    start ??= 0;
    end = min(end ?? total, total);
    return StreamAudioResponse(
      sourceLength: total,
      contentLength: end - start,
      offset: start,
      stream: _download(start, end),
      contentType: _info.codec.mimeType,
    );
  }

  Stream<List<int>> _download(int start, int end) async* {
    for (var pos = start; pos < end; pos += _chunk) {
      final last = min(pos + _chunk, end) - 1;
      final res = await http.get(_info.url, headers: {'Range': 'bytes=$pos-$last'});
      if (res.statusCode != 206) {
        throw Exception('Stream YouTube ditolak (${res.statusCode})');
      }
      yield res.bodyBytes;
    }
  }
}
