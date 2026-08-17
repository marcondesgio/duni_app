import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';

/// Mídia enviada no chat: imagem, preview, descrição e callback de abertura
/// (seção 21 da documentação).
class DuniMediaMessage extends StatelessWidget {
  const DuniMediaMessage({
    super.key,
    required this.imageUrl,
    this.description,
    this.onTap,
  });

  final String imageUrl;
  final String? description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(DuniRadius.small),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 220, maxHeight: 220),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 220,
                  height: 160,
                  color: DuniColors.gray200,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: DuniColors.purple500.withAlpha(120),
                  ),
                ),
              ),
            ),
          ),
          if (description != null && description!.isNotEmpty) ...[
            const SizedBox(height: DuniSpacing.xxs),
            Text(
              description!,
              style: DuniTypography.bodySmall.copyWith(
                color: DuniColors.purple500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
