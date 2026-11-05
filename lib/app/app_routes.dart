/// Nama route aplikasi, dipakai dengan `Navigator.pushNamed(context, AppRoutes.x)`.
abstract final class AppRoutes {
  static const welcome = '/';
  static const home = '/home';
  static const player = '/player';

  /// Argument: [Album].
  static const album = '/album';

  /// Argument: [Artist].
  static const artist = '/artist';
}
