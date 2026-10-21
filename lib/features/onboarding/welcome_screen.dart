import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/artwork.dart';
import '../../core/widgets/pressable.dart';

class _OnboardingPage {
  const _OnboardingPage(this.title, this.message, this.covers);

  final String title;
  final String message;

  /// Tiga cover album yang ditumpuk sebagai visual utama.
  final List<String> covers;
}

const _pages = [
  _OnboardingPage(
    'Dengarkan sepenuh hati',
    'Temukan lagu dari artis favoritmu, putar kapan saja, dan nikmati setiap nadanya.',
    [
      'assets/albums/dua_lipa_future_nostalgia.jpg',
      'assets/albums/taylor_swift_1989.jpg',
      'assets/albums/the_weeknd_after_hours.jpg',
    ],
  ),
  _OnboardingPage(
    'Ikuti setiap lirik',
    'Lirik bergulir mengikuti lagu, jadi kamu bisa ikut bernyanyi tanpa tertinggal satu baris pun.',
    [
      'assets/albums/sza_sos.jpg',
      'assets/albums/frank_ocean_blonde.jpg',
      'assets/albums/billie_eilish_hit_me_hard_and_soft.jpg',
    ],
  ),
  _OnboardingPage(
    'Simpan yang kamu suka',
    'Tandai lagu favorit dan lihat lagi riwayat putarmu kapan pun kamu mau.',
    [
      'assets/albums/olivia_rodrigo_sour.jpg',
      'assets/albums/silk_sonic.jpg',
      'assets/albums/harry_styles_harrys_house.jpg',
    ],
  ),
];

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _pageController = PageController();
  int _page = 0;

  bool get _isLast => _page == _pages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finish() => Navigator.pushReplacementNamed(context, AppRoutes.home);

  void _next() {
    if (_isLast) return _finish();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.bgCanvas,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: AnimatedOpacity(
                  opacity: _isLast ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: TextButton(
                    onPressed: _isLast ? null : _finish,
                    style: TextButton.styleFrom(
                      foregroundColor: colors.textPrimary,
                    ),
                    child: const Text('Lewati'),
                  ),
                ),
              ),
            ),
            Text(
              'Senada',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, i) => _PageContent(page: _pages[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 24, 24),
              child: Row(
                children: [
                  _Dots(count: _pages.length, index: _page),
                  const Spacer(),
                  _NextButton(isLast: _isLast, onTap: _next),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent({required this.page});

  final _OnboardingPage page;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(child: _CoverFan(covers: page.covers)),
              ),
              Text(
                page.title,
                style: TextStyle(
                  fontFamily: AppTheme.titleFontFamily,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                  height: 1.15,
                  color: colors.bgBrand,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                page.message,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tiga cover album yang mengipas keluar saat halaman muncul, melayang di atas bayangan lembut.
class _CoverFan extends StatelessWidget {
  const _CoverFan({required this.covers});

  final List<String> covers;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(200.0, constraints.maxHeight * 0.6);

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          builder: (context, t, _) => SizedBox(
            width: size * 2,
            height: size * 1.5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Bayangan lonjong di "lantai", seperti objek yang melayang.
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: size * 1.2,
                    height: size * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.18 * t),
                          blurRadius: 30,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
                // Kiri, kanan, lalu tengah, supaya cover tengah tergambar paling atas.
                for (final i in const [0, 2, 1])
                  Transform.translate(
                    offset: Offset(
                      (i - 1) * size * 0.42 * t,
                      -size * 0.12 + (i == 1 ? -10 * t : 0),
                    ),
                    child: Transform.rotate(
                      angle: (i - 1) * 0.16 * t,
                      child: Opacity(
                        opacity: i == 1 ? 1 : t,
                        child: _CoverCard(
                          path: covers[i],
                          size: i == 1 ? size : size * 0.86,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CoverCard extends StatelessWidget {
  const _CoverCard({required this.path, required this.size});

  final String path;
  final double size;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Artwork(path, size: size, radius: 18),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Semantics(
      label: 'Halaman ${index + 1} dari $count',
      child: Row(
        children: [
          for (var i = 0; i < count; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              margin: const EdgeInsets.only(right: 6),
              width: i == index ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: i == index ? colors.bgBrand : colors.borderDefault,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
        ],
      ),
    );
  }
}

/// Tombol bulat panah; di halaman terakhir melebar menjadi "Mulai".
class _NextButton extends StatelessWidget {
  const _NextButton({required this.isLast, required this.onTap});

  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Semantics(
      button: true,
      label: isLast ? 'Mulai' : 'Berikutnya',
      child: Pressable(
        onTap: onTap,
        scale: 0.94,
        borderRadius: BorderRadius.circular(28),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          width: isLast ? 136 : 56,
          height: 56,
          decoration: BoxDecoration(
            color: colors.bgBrand,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: colors.bgBrand.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRect(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLast) ...[
                  Flexible(
                    child: Text(
                      'Mulai',
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colors.textOnBrand,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
                Icon(Icons.arrow_forward_rounded, color: colors.textOnBrand),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
