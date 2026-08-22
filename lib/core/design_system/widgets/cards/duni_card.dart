import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Card base do DUNI Design System — fundação visual (radius, sombra,
/// fundo branco) reutilizada pelos demais cards (InterestCard, GroupCard,
/// ChallengeCard, StreakCard).
class DuniCard extends StatelessWidget {
  const DuniCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(DuniSpacing.md),
    this.onTap,
    this.backgroundColor,
    this.boxShadow = true,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final bool boxShadow;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? DuniColors.surface,
        borderRadius: BorderRadius.circular(DuniRadius.card),
        boxShadow: boxShadow ? DuniShadows.card : null,
        border: !boxShadow ? BoxBorder.all(color: DuniColors.gray100) : null,
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
