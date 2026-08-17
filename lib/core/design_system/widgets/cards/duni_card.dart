import 'package:flutter/material.dart';

import '../../radius/duni_radius.dart';
import '../../shadows/duni_shadows.dart';
import '../../spacing/duni_spacing.dart';

/// Card base do DUNI Design System — fundação visual (radius, sombra,
/// fundo branco) reutilizada pelos demais cards (InterestCard, GroupCard,
/// ChallengeCard, StreakCard).
class DuniCard extends StatelessWidget {
  const DuniCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(DuniSpacing.md),
    this.onTap,
    this.backgroundColor = Colors.white,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(DuniRadius.card),
        boxShadow: DuniShadows.card,
      ),
      child: child,
    );

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(DuniRadius.card),
      child: InkWell(
        borderRadius: BorderRadius.circular(DuniRadius.card),
        onTap: onTap,
        child: content,
      ),
    );
  }
}
