import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../typography/duni_typography.dart';

/// Badge numérico/dot do DUNI Design System — usado, por exemplo, para
/// mensagens não lidas no [DuniGroupCard] (seção 18).
class DuniBadge extends StatelessWidget {
  const DuniBadge({super.key, required this.count})
      : assert(count > 0, 'DuniBadge só deve ser exibido quando count > 0');

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: DuniColors.pink,
        borderRadius: BorderRadius.circular(DuniRadius.pill),
      ),
      alignment: Alignment.center,
      child: Text(
        count > 99 ? '99+' : '$count',
        style: DuniTypography.caption.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
