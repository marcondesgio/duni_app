import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';

enum BannerType { success, warning, error }

class DuniBanner extends StatelessWidget {
  const DuniBanner({
    super.key,
    required this.icon,
    required this.text,
    required this.type,
  });

  final String icon;
  final String text;
  final BannerType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: DuniSpacing.md,
        horizontal: DuniSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(DuniRadius.card),
        border: Border.all(color: _borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: DuniSpacing.sm,
        children: [
          Text(icon, style: const TextStyle(fontSize: DuniSpacing.md)),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: DuniTypography.bodySmall.copyWith(
                color: _textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color get _backgroundColor {
    switch (type) {
      case BannerType.success:
        return DuniColors.teal50;
      case BannerType.warning:
        return DuniColors.yellow50;
      case BannerType.error:
        return DuniColors.red50;
    }
  }

  Color get _borderColor {
    switch (type) {
      case BannerType.success:
        return DuniColors.teal100;
      case BannerType.warning:
        return DuniColors.yellow100;
      case BannerType.error:
        return DuniColors.red100;
    }
  }

  Color get _textColor {
    switch (type) {
      case BannerType.success:
        return DuniColors.success;
      case BannerType.warning:
        return DuniColors.warning;
      case BannerType.error:
        return DuniColors.error;
    }
  }
}
