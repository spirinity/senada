import 'song.dart';

class PlayHistory {
  const PlayHistory(this.song, this.playedAt);

  final Song song;
  final DateTime playedAt;
}
