import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'glass_surface.dart';
import 'pressable.dart';

class FloatingBottomBar extends StatelessWidget {
  const FloatingBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    (Icons.explore_outlined, Icons.explore_rounded, 'Explore'),
    (Icons.favorite_outline_rounded, Icons.favorite_rounded, 'Favorit'),
    (Icons.history_rounded, Icons.history_rounded, 'Riwayat'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GlassSurface(
          radius: 32,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              children: [
                for (final (i, (icon, activeIcon, label)) in _items.indexed)
                  Expanded(
                    child: _NavItem(
                      icon: icon,
                      activeIcon: activeIcon,
                      label: label,
                      isSelected: i == currentIndex,
                      onTap: () => onTap(i),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final color = isSelected ? colors.textLink : colors.textTertiary;

    return Semantics(
      selected: isSelected,
      child: Pressable(
        onTap: onTap,
        scale: 0.94,
        borderRadius: BorderRadius.circular(26),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          height: 52,
          decoration: BoxDecoration(
            color: isSelected
                ? colors.bgBrand.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isSelected ? activeIcon : icon, size: 22, color: color),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
