import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

class GroupDetailsMediaPreview extends StatelessWidget {
  const GroupDetailsMediaPreview({
    super.key,
    required this.previewUrls,
    required this.mediaCount,
    required this.onViewAll,
  });

  final List<String> previewUrls;
  final int mediaCount;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mídias',
              style: DuniTypography.bodyLarge.copyWith(
                color: DuniColors.purple500,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: onViewAll,
              child: Text(
                'Ver todas · $mediaCount',
                style: DuniTypography.bodySmall.copyWith(
                  color: DuniColors.purple200,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: DuniSpacing.sm),
        Row(
          children: [
            for (var i = 0; i < previewUrls.length; i++) ...[
              if (i > 0) const SizedBox(width: DuniSpacing.xs),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(DuniRadius.small),
                    child: Image.network(
                      previewUrls[i],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: DuniColors.gray200),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
