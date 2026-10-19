import 'package:flutter/material.dart';
import '../theme/theme.dart';

class FloatingBottomBar extends StatelessWidget {
  const FloatingBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onCenterActionTap,
    this.userAvatarUrl = 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&q=80',
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onCenterActionTap;
  final String userAvatarUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.98),
          borderRadius: BorderRadius.circular(36),
          border: Border.all(
            color: colors.borderSubtle.withValues(alpha: 0.7),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Home
            _NavItem(
              index: 0,
              icon: Icons.home_outlined,
              activeIcon: Icons.home_rounded,
              label: 'Home',
              isSelected: currentIndex == 0,
              onTap: () => onTap(0),
            ),

            // Library
            _NavItem(
              index: 1,
              icon: Icons.library_music_outlined,
              activeIcon: Icons.library_music_rounded,
              label: 'Library',
              isSelected: currentIndex == 1,
              onTap: () => onTap(1),
            ),

            // Center Action Button (+)
            Transform.translate(
              offset: const Offset(0, -6),
              child: GestureDetector(
                onTap: onCenterActionTap,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF60A5FA),
                        Color(0xFF3B82F6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x403B82F6),
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),

            // Profiles / Discover
            _NavItem(
              index: 2,
              icon: Icons.groups_outlined,
              activeIcon: Icons.groups_rounded,
              label: 'Profiles',
              isSelected: currentIndex == 2,
              onTap: () => onTap(2),
            ),

            // Account
            _NavAccountItem(
              isSelected: currentIndex == 3,
              avatarUrl: userAvatarUrl,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final int index;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 22,
              color: isSelected ? colors.textPrimary : colors.textDisabled,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontFamily: AppTheme.bodyFontFamily,
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? colors.textPrimary : colors.textDisabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavAccountItem extends StatelessWidget {
  const _NavAccountItem({
    required this.isSelected,
    required this.avatarUrl,
    required this.onTap,
  });

  final bool isSelected;
  final String avatarUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? colors.textPrimary : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  avatarUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.person_rounded,
                    size: 16,
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'Account',
              style: TextStyle(
                fontFamily: AppTheme.bodyFontFamily,
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? colors.textPrimary : colors.textDisabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
