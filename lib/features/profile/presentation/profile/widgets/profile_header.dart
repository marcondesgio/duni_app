import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'profile_stats_row.dart';

/// Conteúdo do cabeçalho do Perfil: foto (editável), nome, e-mail/empresa e
/// as métricas de interesses/desafios/check-ins — sobre o gradiente de
/// marca. Usado como `background` de um `FlexibleSpaceBar` (ver
/// `ProfileView`, mesmo padrão do `ChallengeDetailView`), por isso não
/// inclui botão de voltar — isso é responsabilidade do `SliverAppBar` que
/// minimiza este cabeçalho ao rolar a tela.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.company,
    required this.avatarUrl,
    required this.onEditAvatar,
    required this.interestsCount,
    required this.challengesCount,
    required this.checkinsCount,
  });

  final String name;
  final String email;
  final String company;
  final String? avatarUrl;
  final VoidCallback onEditAvatar;
  final int interestsCount;
  final int challengesCount;
  final int checkinsCount;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: DuniGradients.purple),
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
            spacing: DuniSpacing.xs,
            children: [
              DuniAvatarPicker(
                initials: name.isNotEmpty ? name[0].toUpperCase() : null,
                imageUrl: avatarUrl,
                onTap: onEditAvatar,
                badgeIcon: Icons.edit,
                size: 88,
              ),
              Text(
                name,
                style: DuniTypography.heading2.copyWith(
                  color: DuniColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '$email · $company',
                style: DuniTypography.bodySmall.copyWith(
                  color: DuniColors.white.withAlpha(200),
                ),
              ),
              const SizedBox(height: DuniSpacing.sm),
              ProfileStatsRow(
                interests: interestsCount,
                challenges: challengesCount,
                checkins: checkinsCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
