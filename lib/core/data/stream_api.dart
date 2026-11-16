import 'package:just_audio/just_audio.dart';

/// Sumber audio untuk lagu Jamendo [trackId]; just_audio memutar MP3-nya langsung.
// shortcut: URL storage dipakai langsung dari contoh di dokumentasi Jamendo, bukan dari field `audio`; bila berhenti jalan, ambil `audio` lewat /tracks/?id=.
Future<AudioSource> fetchAudioSource(String trackId) async => AudioSource.uri(
  Uri.https('prod-1.storage.jamendo.com', '/', {
    'trackid': trackId,
    'format': 'mp32',
  }),
);
