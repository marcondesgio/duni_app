import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/groups/shared/shared.dart';
import 'package:flutter/material.dart';

import '../home_state.dart';

class HomeGroupsSection extends StatelessWidget {
  const HomeGroupsSection({super.key, required this.groups});

  final List<HomeGroupPreview> groups;

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: DuniSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seus interesses',
                style: DuniTypography.bodySmall.copyWith(
                  color: DuniColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                child: Text(
                  'Gerenciar',
                  style: DuniTypography.bodySmall.copyWith(
                    color: DuniColors.purple200,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(GroupsRouter.listPage);
                },
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: DuniSpacing.xs,
            mainAxisSpacing: DuniSpacing.xs,
            childAspectRatio: 1.25,
          ),
          itemCount: groups.length,
          itemBuilder: (context, index) => _GroupCard(group: groups[index]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: DuniSpacing.lg),
          child: DuniBannerChallenges(
            title: '5 dias de atividade física',
            text: 'Você está em 3º · falta 1 check-in',
          ),
        ),
      ],
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.group});

  final HomeGroupPreview group;

  @override
  Widget build(BuildContext context) {
    return DuniGroupCard(
      icon: group.icon,
      interestName: group.interestName,
      participantCount: group.participantCount,
      unreadCount: group.unreadCount,
      onTap: () => Navigator.of(context).pushNamed(
        GroupsRouter.chatPage,
        arguments: GroupRef(
          id: group.id,
          icon: group.icon,
          interestName: group.interestName,
          participantCount: group.participantCount,
        ),
      ),
    );
  }
}
