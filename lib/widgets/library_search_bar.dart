import 'package:flutter/material.dart';
import '../theme/theme.dart';

class LibrarySearchBar extends StatelessWidget {
  const LibrarySearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onClear,
    this.onFilterTap,
    this.hintText = 'Search playlists, artists, songs...',
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onFilterTap;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final hasText = controller.text.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: colors.bgSurfaceRaised,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: colors.borderSubtle.withValues(alpha: 0.8),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            // Search Icon
            Icon(
              Icons.search_rounded,
              size: 22,
              color: colors.textTertiary,
            ),
            const SizedBox(width: 10),

            // Text input field
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                style: TextStyle(
                  fontFamily: AppTheme.bodyFontFamily,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: colors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontFamily: AppTheme.bodyFontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: colors.textDisabled,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),

            // Clear Button (when text typed)
            if (hasText)
              GestureDetector(
                onTap: onClear ?? () {
                  controller.clear();
                  onChanged('');
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: colors.borderSubtle,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 14,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ),

            // Optional Filter / Equalizer button
            if (onFilterTap != null)
              GestureDetector(
                onTap: onFilterTap,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colors.bgSurface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: colors.borderSubtle,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.tune_rounded,
                    size: 17,
                    color: colors.textPrimary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
