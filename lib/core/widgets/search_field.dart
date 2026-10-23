import 'package:flutter/material.dart';

import '../theme/theme.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Cari',
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: colors.bgMuted.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            style: textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textTheme.bodyLarge?.copyWith(
                color: colors.textTertiary,
              ),
              border: InputBorder.none,
              isDense: true,
              // Ikon dan tombol hapus ditangani TextField, jadi tidak perlu Row.
              prefixIconConstraints: const BoxConstraints(),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 14, right: 8),
                child: Icon(
                  Icons.search_rounded,
                  size: 21,
                  color: colors.textTertiary,
                ),
              ),
              suffixIconConstraints: const BoxConstraints(),
              suffixIcon: controller.text.isEmpty
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: IconButton(
                        tooltip: 'Hapus pencarian',
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.cancel_rounded,
                          size: 18,
                          color: colors.textTertiary,
                        ),
                        onPressed: () {
                          controller.clear();
                          onChanged('');
                        },
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
