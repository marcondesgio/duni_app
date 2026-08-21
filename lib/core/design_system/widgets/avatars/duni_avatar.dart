import 'dart:math';

import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

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
  DuniAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = DuniAvatarSize.medium,
    this.isYourUser = false,
  });

  final String? imageUrl;
  final String? initials;
  final DuniAvatarSize size;
  final bool isYourUser;

  @override
  Widget build(BuildContext context) {
    final diameter = size.diameter;
    return ClipOval(
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          gradient: _gradient,
          borderRadius: BorderRadius.circular(DuniRadius.pill),
          color: _sorted,
        ),
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

  Gradient? get _gradient => (isYourUser) ? DuniGradients.avatar : null;

  Color get _sorted => sortColors(_myColors);

  final List<Color> _myColors = [
    DuniColors.teal200,
    DuniColors.pink,
    DuniColors.yellow200,
    DuniColors.purple200,
  ];

  Color sortColors(List<Color> colors) {
    // Use a cascade operator to copy and sort the list
    final randomColor = Random();
    return colors[randomColor.nextInt(_myColors.length)];
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback({required this.initials, required this.diameter});

  final String? initials;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    if (initials == null || initials!.isEmpty) {
      return Icon(Icons.person, color: DuniColors.white, size: diameter * 0.55);
    }
    return Center(
      child: Text(
        initials!,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: diameter * 0.4,
          color: DuniColors.white,
        ),
      ),
    );
  }
}
