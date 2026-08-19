import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../group_details_state.dart';

class GroupDetailsParticipantTile extends StatelessWidget {
  const GroupDetailsParticipantTile({super.key, required this.participant});

  final GroupParticipant participant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DuniSpacing.xs),
      child: Row(
        children: [
          DuniAvatar(
            initials: participant.initials,
            size: DuniAvatarSize.small,
          ),
          const SizedBox(width: DuniSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      participant.name,
                      style: DuniTypography.body.copyWith(
                        color: DuniColors.purple500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (participant.isCurrentUser) ...[
                      const SizedBox(width: DuniSpacing.xxs),
                      Text(
                        '· você',
                        style: DuniTypography.bodySmall.copyWith(
                          color: DuniColors.purple200,
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  participant.role,
                  style: DuniTypography.bodySmall.copyWith(
                    color: DuniColors.purpleGray100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
