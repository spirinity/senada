class LyricLine {
  const LyricLine(this.time, this.text);

  /// Waktu baris ini mulai dinyanyikan.
  final Duration time;
  final String text;
}

class Song {
  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.artwork,
    required this.duration,
    this.lyrics = const [],
  });

  final String id;
  final String title;
  final String artist;
  final String album;

  /// Path asset gambar album.
  final String artwork;
  final Duration duration;
  final List<LyricLine> lyrics;
}
