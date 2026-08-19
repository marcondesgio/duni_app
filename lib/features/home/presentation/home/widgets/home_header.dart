import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: DuniSpacing.xs,
      children: [
        DuniAvatar(
          initials: userName.isNotEmpty ? userName[0].toUpperCase() : null,
          size: DuniAvatarSize.medium,
          isYourUser: true,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: DuniTypography.bodyLarge.copyWith(
                color: DuniColors.purple500,
              ),
            ),
            Text(
              'Diletta Solutions',
              style: DuniTypography.bodySmall.copyWith(
                color: DuniColors.purpleGray100,
              ),
            ),
          ],
        ),
        Spacer(),
        DuniIconButton(
          icon: Icons.notifications_rounded,
          onPressed: () {},
          variant: DuniIconButtonVariant.secundary,
        ),
      ],
    );
  }
}
