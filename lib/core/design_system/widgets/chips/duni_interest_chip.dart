import 'package:flutter/material.dart';

import '../../typography/duni_typography.dart';
import 'duni_chip.dart';

/// Representação compacta de um interesse (ex.: "💪 Academia"), usada em
/// desafios, filtros, detalhes e cards (seção 17 da documentação).
class DuniInterestChip extends StatelessWidget {
  const DuniInterestChip({
    super.key,
    required this.emoji,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final String emoji;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DuniChip(
      label: label,
      selected: selected,
      onTap: onTap,
      icon: Text(emoji, style: DuniTypography.label),
    );
  }
}
