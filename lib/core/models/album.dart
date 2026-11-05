class Album {
  const Album({
    required this.id,
    required this.title,
    required this.artist,
    required this.year,
    required this.artwork,
  });

  /// browseId YouTube Music, dipakai untuk mengambil daftar lagu album.
  final String id;
  final String title;
  final String artist;
  final String year;

  /// URL gambar sampul.
  final String artwork;

  /// "Bruno Mars · 2016"; tahun dilewati bila kosong.
  String get subtitle => year.isEmpty ? artist : '$artist · $year';
}
