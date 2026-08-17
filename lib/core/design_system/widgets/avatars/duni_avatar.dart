import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';

enum DuniAvatarSize {
  xs,
  small,
  medium,
  large,
  profile;

  /// Placeholder: a documentação não define os tamanhos em px de cada
  /// variante — confirmar com o Figma.
  double get diameter {
    switch (this) {
      case DuniAvatarSize.xs:
        return 24;
      case DuniAvatarSize.small:
        return 32;
      case DuniAvatarSize.medium:
        return 48;
      case DuniAvatarSize.large:
        return 64;
      case DuniAvatarSize.profile:
        return 96;
    }
  }
}

/// Avatar do DUNI Design System — usado em perfil, grupos, chat, ranking,
/// participantes e dashboard (seção 15 da documentação).
class DuniAvatar extends StatelessWidget {
  const DuniAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = DuniAvatarSize.medium,
  });

  final String? imageUrl;
  final String? initials;
  final DuniAvatarSize size;

  @override
  Widget build(BuildContext context) {
    final diameter = size.diameter;
    return ClipOval(
      child: Container(
        width: diameter,
        height: diameter,
        color: DuniColors.gray200,
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _Fallback(initials: initials, diameter: diameter),
              )
            : _Fallback(initials: initials, diameter: diameter),
      ),
    );
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback({required this.initials, required this.diameter});

  final String? initials;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    if (initials == null || initials!.isEmpty) {
      return Icon(
        Icons.person,
        color: DuniColors.purple500.withAlpha(150),
        size: diameter * 0.55,
      );
    }
    return Center(
      child: Text(
        initials!,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: diameter * 0.4,
          color: DuniColors.purple500,
        ),
      ),
    );
  }
}
