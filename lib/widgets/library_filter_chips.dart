import 'package:flutter/material.dart';
import '../theme/theme.dart';

class FilterChipData {
  const FilterChipData({
    required this.id,
    required this.label,
    this.count,
    this.icon,
    this.avatarUrl,
    this.avatarInitials,
    this.isFilterButton = false,
  });

  final String id;
  final String label;
  final int? count;
  final IconData? icon;
  final String? avatarUrl;
  final String? avatarInitials;
  final bool isFilterButton;
}

class LibraryFilterChips extends StatelessWidget {
  const LibraryFilterChips({
    super.key,
    required this.selectedId,
    required this.onSelected,
    this.onFilterTap,
  });

  final String selectedId;
  final ValueChanged<String> onSelected;
  final VoidCallback? onFilterTap;

  static const List<FilterChipData> items = [
    FilterChipData(
      id: 'filter_btn',
      label: '',
      isFilterButton: true,
      icon: Icons.tune_rounded,
    ),
    FilterChipData(
      id: 'you',
      label: 'You',
      count: 12,
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&q=80',
      avatarInitials: 'U',
    ),
    FilterChipData(
      id: 'natalia',
      label: 'Natalia',
      count: 20,
      avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&q=80',
      avatarInitials: 'N',
    ),
    FilterChipData(
      id: 'favorites',
      label: 'Favorites',
      count: 0,
      icon: Icons.star_rounded,
    ),
    FilterChipData(
      id: 'vinyls',
      label: 'Vinyl & Playlists',
      count: 15,
      icon: Icons.album_rounded,
    ),
    FilterChipData(
      id: 'downloaded',
      label: 'Downloaded',
      icon: Icons.arrow_downward_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = items[index];

          if (item.isFilterButton) {
            return InkWell(
              onTap: onFilterTap ?? () {},
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: colors.borderSubtle.withValues(alpha: 0.8),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x06000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  item.icon,
                  size: 19,
                  color: colors.textPrimary,
                ),
              ),
            );
          }

          final isSelected = selectedId == item.id;

          return InkWell(
            onTap: () => onSelected(item.id),
            borderRadius: BorderRadius.circular(30),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? colors.bgBrand.withValues(alpha: 0.08) : Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected ? colors.bgBrand : colors.borderSubtle.withValues(alpha: 0.8),
                  width: isSelected ? 1.5 : 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x06000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.avatarUrl != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.avatarUrl!,
                        width: 22,
                        height: 22,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 22,
                          height: 22,
                          color: colors.bgBrand.withValues(alpha: 0.2),
                          alignment: Alignment.center,
                          child: Text(
                            item.avatarInitials ?? '?',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: colors.bgBrand,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                  ] else if (item.icon != null) ...[
                    Icon(
                      item.icon,
                      size: 16,
                      color: item.icon == Icons.star_rounded
                          ? const Color(0xFFF59E0B)
                          : (isSelected ? colors.bgBrand : colors.textSecondary),
                    ),
                    const SizedBox(width: 5),
                  ],
                  Text(
                    item.count != null ? '${item.label} (${item.count})' : item.label,
                    style: TextStyle(
                      fontFamily: AppTheme.bodyFontFamily,
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? colors.bgBrand : colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
