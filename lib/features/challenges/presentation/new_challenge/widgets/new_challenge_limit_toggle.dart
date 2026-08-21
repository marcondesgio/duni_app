import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Card "Limitar participantes" — toggle + legenda com o valor atual
/// (seção 31 da documentação: quando desativado, não exibir quantidade).
class NewChallengeLimitToggle extends StatelessWidget {
  const NewChallengeLimitToggle({
    super.key,
    required this.enabled,
    required this.maxParticipants,
    required this.onChanged,
  });

  final bool enabled;
  final int maxParticipants;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return DuniCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Limitar participantes',
                  style: DuniTypography.bodyLarge.copyWith(
                    color: DuniColors.purple500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (enabled)
                  Text(
                    'Máximo de $maxParticipants pessoas',
                    style: DuniTypography.bodySmall.copyWith(
                      color: DuniColors.purpleGray100,
                    ),
                  ),
              ],
            ),
          ),
          DuniSwitch(value: enabled, onChanged: onChanged),
        ],
      ),
    );
  }
}
