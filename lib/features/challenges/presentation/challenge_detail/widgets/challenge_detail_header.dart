import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/challenges/shared/shared.dart';
import 'package:flutter/material.dart';

/// Conteúdo do cabeçalho dos Detalhes/Ranking do desafio: chip de interesse
/// translúcido, nome, período/vagas e descrição — sobre o gradiente de
/// marca. Usado como `background` de um `FlexibleSpaceBar` (ver
/// `ChallengeDetailView`), por isso não inclui botão de voltar nem barra de
/// título — isso é responsabilidade do `SliverAppBar` que minimiza este
/// cabeçalho ao rolar a tela.
class ChallengeDetailHeader extends StatelessWidget {
  const ChallengeDetailHeader({
    super.key,
    required this.challenge,
    required this.subtitle,
    required this.description,
  });

  final ChallengeRef challenge;
  final String subtitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: DuniGradients.navy),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            DuniSpacing.md,
            kToolbarHeight + DuniSpacing.xs,
            DuniSpacing.md,
            DuniSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DuniSpacing.xs,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DuniSpacing.sm,
                  vertical: DuniSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: DuniColors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(DuniRadius.pill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: DuniSpacing.xxs,
                  children: [
                    Text(challenge.interestEmoji, style: DuniTypography.label),
                    Text(
                      challenge.interestLabel,
                      style: DuniTypography.label.copyWith(
                        color: DuniColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                challenge.name,
                style: DuniTypography.heading2.copyWith(
                  color: DuniColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: DuniTypography.bodySmall.copyWith(
                  color: DuniColors.white.withAlpha(200),
                ),
              ),
              Text(
                description,
                style: DuniTypography.body.copyWith(
                  color: DuniColors.white.withAlpha(230),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
