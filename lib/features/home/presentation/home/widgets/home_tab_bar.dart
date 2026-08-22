import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Substituto do [DuniSegmentedControl] usado especificamente na Home:
/// tabs com texto + indicador de sublinhado (ao invés do pill com fundo
/// cinza), conforme o node 12-530 do Figma. Mesmo comportamento genérico
/// (segments/value/onChanged) — vive aqui, e não no Design System, porque só
/// é usado nesta tela.
class HomeTabBar<T> extends StatelessWidget {
  const HomeTabBar({
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (final segment in segments)
              _Tab(
                label: segment.label,
                selected: segment.value == value,
                onTap: () => onChanged(segment.value),
              ),
          ],
        ),
        DuniDivider(),
      ],
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const _indicatorHeight = 3.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DuniSpacing.sm,
                vertical: DuniSpacing.sm,
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: DuniTypography.body.copyWith(
                  color: selected
                      ? DuniColors.textPrimary
                      : DuniColors.textSecondary,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: _indicatorHeight,
              decoration: BoxDecoration(
                color: selected ? DuniColors.purple200 : Colors.transparent,
                borderRadius: BorderRadius.circular(DuniRadius.pill),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
