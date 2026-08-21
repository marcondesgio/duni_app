import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';

/// Chip base do DUNI Design System — bloco de construção reutilizado por
/// [DuniInterestChip] e demais representações compactas (seção 12/17).
class DuniChip extends StatelessWidget {
  const DuniChip({
    super.key,
    required this.label,
    this.icon,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final Widget? icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(DuniRadius.pill),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DuniSpacing.sm,
          vertical: DuniSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: selected ? DuniColors.purple500 : Colors.white,
          borderRadius: BorderRadius.circular(DuniRadius.pill),
          border: Border.all(
            color: selected ? DuniColors.purple500 : DuniColors.gray200,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: DuniSpacing.xxs),
            ],
            Text(
              label,
              style: DuniTypography.label.copyWith(
                color: selected ? DuniColors.white : DuniColors.purple500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
