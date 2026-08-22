import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Linha de métricas do perfil: interesses/desafios/check-ins.
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.interests,
    required this.challenges,
    required this.checkins,
  });

  final int interests;
  final int challenges;
  final int checkins;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _Stat(value: interests, label: 'interesses'),
        _Stat(value: challenges, label: 'desafios'),
        _Stat(value: checkins, label: 'check-ins'),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$value',
          style: DuniTypography.heading3.copyWith(
            color: DuniColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: DuniTypography.bodySmall.copyWith(
            color: DuniColors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }
}
