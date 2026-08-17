import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';

enum DuniMediaGridMode { grid, list }

/// Grid de mídia — 3 colunas no mobile, com suporte a modo lista (seção 33
/// da documentação).
class DuniMediaGrid extends StatelessWidget {
  const DuniMediaGrid({
    super.key,
    required this.items,
    this.mode = DuniMediaGridMode.grid,
    this.onItemTap,
  });

  final List<String> items;
  final DuniMediaGridMode mode;
  final ValueChanged<int>? onItemTap;

  static const _mobileColumns = 3;

  @override
  Widget build(BuildContext context) {
    if (mode == DuniMediaGridMode.list) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: DuniSpacing.xs),
        itemBuilder: (context, index) => _MediaTile(
          url: items[index],
          onTap: onItemTap == null ? null : () => onItemTap!(index),
          height: 96,
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _mobileColumns,
        crossAxisSpacing: DuniSpacing.xxs,
        mainAxisSpacing: DuniSpacing.xxs,
      ),
      itemBuilder: (context, index) => _MediaTile(
        url: items[index],
        onTap: onItemTap == null ? null : () => onItemTap!(index),
      ),
    );
  }
}

class _MediaTile extends StatelessWidget {
  const _MediaTile({required this.url, required this.onTap, this.height});

  final String url;
  final VoidCallback? onTap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(DuniRadius.small),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: DuniColors.gray200),
          ),
        ),
      ),
    );
  }
}
