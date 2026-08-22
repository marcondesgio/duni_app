import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';

/// Seletor de mídia usado na criação de desafios (seção 29 da documentação).
///
/// É puramente apresentacional: exibe as mídias já selecionadas e um tile de
/// "adicionar". A escolha real do arquivo (câmera/galeria) é responsabilidade
/// da camada de feature — o Design System não deve depender de um plugin de
/// picker específico.
class DuniMediaPicker extends StatelessWidget {
  const DuniMediaPicker({
    super.key,
    required this.imageUrls,
    required this.onAdd,
    required this.onRemove,
    this.tileSize = 88,
  });

  final List<String> imageUrls;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final double tileSize;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: DuniSpacing.xs,
      runSpacing: DuniSpacing.xs,
      children: [
        for (var i = 0; i < imageUrls.length; i++)
          _SelectedTile(
            size: tileSize,
            url: imageUrls[i],
            onRemove: () => onRemove(i),
          ),
        _AddTile(size: tileSize, onTap: onAdd),
      ],
    );
  }
}

class _SelectedTile extends StatelessWidget {
  const _SelectedTile({
    required this.size,
    required this.url,
    required this.onRemove,
  });

  final double size;
  final String url;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(DuniRadius.small),
            child: Image.network(
              url,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: DuniColors.gray200),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: DuniColors.purple500,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 14,
                  color: DuniColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  const _AddTile({required this.size, required this.onTap});

  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(DuniRadius.small),
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: DuniColors.gray50,
          borderRadius: BorderRadius.circular(DuniRadius.small),
          border: Border.all(color: DuniColors.gray200),
        ),
        child: Icon(
          Icons.add_photo_alternate_outlined,
          color: DuniColors.textPrimary.withAlpha(160),
        ),
      ),
    );
  }
}
