import 'package:flutter/material.dart';
import 'package:duni_app/core/design_system/design_system.dart';

/// Card de interesse usado principalmente no onboarding (seção 16 da
/// documentação): apresenta o interesse, permite seleção e reflete o estado
/// selecionado.
///
/// Segue o mesmo padrão visual do [DuniCard] (radius + sombra, sem borda) —
/// a seleção é indicada só pela mudança de cor de fundo.
class DuniInterestCard extends StatelessWidget {
  const DuniInterestCard({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    this.onTap,
    this.enabled = true,
  });

  final String icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: DuniCard(
        onTap: enabled ? onTap : null,
        backgroundColor: selected ? DuniColors.purple50 : DuniColors.surface,
        boxShadow: false,
        padding: const EdgeInsets.symmetric(
          vertical: DuniSpacing.md,
          horizontal: DuniSpacing.sm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: DuniSpacing.xs,
          children: [
            Text(icon, style: const TextStyle(fontSize: DuniSpacing.md)),
            Text(
              label,
              textAlign: TextAlign.center,
              style: DuniTypography.bodySmall.copyWith(
                color: DuniColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
