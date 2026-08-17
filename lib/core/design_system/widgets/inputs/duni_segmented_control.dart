import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';

class DuniSegment<T> {
  const DuniSegment({required this.value, required this.label});

  final T value;
  final String label;
}

/// Controle segmentado genérico do DUNI Design System — usado, por exemplo,
/// para escolher a frequência de check-in de um desafio (seção 29/30).
class DuniSegmentedControl<T> extends StatelessWidget {
  const DuniSegmentedControl({
    super.key,
    required this.segments,
    required this.value,
    required this.onChanged,
  });

  final List<DuniSegment<T>> segments;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DuniSpacing.xxl + 2,
      padding: const EdgeInsets.all(DuniSpacing.xxs),
      decoration: BoxDecoration(
        color: DuniColors.gray100,
        borderRadius: BorderRadius.circular(DuniRadius.small),
      ),
      child: Row(
        children: [
          for (final segment in segments)
            Expanded(
              child: _Segment(
                label: segment.label,
                selected: segment.value == value,
                onTap: () => onChanged(segment.value),
              ),
            ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(DuniRadius.pill),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: DuniSpacing.xs),
        decoration: BoxDecoration(
          color: selected ? DuniColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(DuniRadius.small),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: DuniTypography.button.copyWith(
            color: selected ? DuniColors.purple500 : DuniColors.purpleGray100,
          ),
        ),
      ),
    );
  }
}
