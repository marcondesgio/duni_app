import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../gradients/duni_gradients.dart';

/// Seletor de foto de perfil: anel com o gradiente de marca
/// ([DuniGradients.avatar]) e um badge de câmera para adicionar/trocar a
/// imagem. Usado na etapa de foto do onboarding (seção 28) e reutilizável em
/// telas de edição de perfil.
class DuniAvatarPicker extends StatelessWidget {
  const DuniAvatarPicker({
    super.key,
    required this.onTap,
    this.imageUrl,
    this.initials,
    this.size = 140,
    this.badgeIcon = Icons.camera_alt_outlined,
  });

  final VoidCallback onTap;
  final String? imageUrl;
  final String? initials;
  final double size;
  final IconData badgeIcon;

  static const _ringWidth = 4.0;

  @override
  Widget build(BuildContext context) {
    final badgeSize = size * 0.3;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(_ringWidth),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: DuniGradients.avatar,
              ),
              child: ClipOval(
                child: ColoredBox(
                  color: DuniColors.purple50,
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _Fallback(initials: initials, size: size),
                        )
                      : _Fallback(initials: initials, size: size),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: badgeSize,
                height: badgeSize,
                decoration: const BoxDecoration(
                  color: DuniColors.purple500,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  badgeIcon,
                  color: DuniColors.white,
                  size: badgeSize * 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback({required this.initials, required this.size});

  final String? initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (initials == null || initials!.isEmpty) {
      return Icon(Icons.person, color: DuniColors.purple200, size: size * 0.4);
    }
    return Center(
      child: Text(
        initials!,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: size * 0.32,
          color: DuniColors.purple200,
        ),
      ),
    );
  }
}
