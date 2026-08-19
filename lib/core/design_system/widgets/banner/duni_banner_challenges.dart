import 'package:flutter/material.dart';
import 'package:duni_app/core/design_system/design_system.dart';

class DuniBannerChallenges extends StatelessWidget {
  const DuniBannerChallenges({
    super.key,
    required this.title,
    required this.text,
    this.onPressed,
  });

  final String title;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 75,
        padding: const EdgeInsets.symmetric(
          vertical: DuniSpacing.md,
          horizontal: DuniSpacing.sm,
        ),
        decoration: BoxDecoration(
          gradient: DuniGradients.navy,
          borderRadius: BorderRadius.circular(DuniRadius.card),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: DuniSpacing.sm,
          children: [
            Row(
              spacing: DuniSpacing.xs,
              children: [
                Text('🏆', style: const TextStyle(fontSize: DuniSpacing.lg)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: DuniSpacing.xxs,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: DuniTypography.body.copyWith(
                        color: DuniColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.left,
                      style: DuniTypography.bodySmall.copyWith(
                        color: DuniColors.purpleGray50,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.chevron_right_outlined,
              size: DuniSpacing.lg,
              color: DuniColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
