import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Área de envio de imagem com borda pontilhada — usada tanto para a
/// "Imagem de capa" de um desafio (ícone + label) quanto para a
/// "Comprovação" de um check-in (ícone + botões de ação + legenda), via os
/// parâmetros opcionais [actionLabels]/[caption]. Mostra a imagem escolhida
/// no lugar da dropzone quando [imageUrl] não é nulo.
///
/// Placeholder: sem plugin de câmera/galeria integrado ainda — quem chama
/// [onTap] decide o que "selecionar uma imagem" significa hoje (mesma
/// convenção do `DuniAvatarPicker`/`DuniMediaPicker`).
class DuniImageDropzone extends StatelessWidget {
  const DuniImageDropzone({
    super.key,
    required this.onTap,
    this.imageUrl,
    this.onRemove,
    this.icon = Icons.cloud_upload_outlined,
    this.label,
    this.caption,
    this.actionLabels = const [],
    this.backgroundColor,
    this.height = 160,
  });

  final VoidCallback onTap;
  final String? imageUrl;
  final VoidCallback? onRemove;
  final IconData icon;
  final String? label;
  final String? caption;
  final List<String> actionLabels;
  final Color? backgroundColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return _SelectedImage(
        imageUrl: imageUrl!,
        height: height,
        onTap: onTap,
        onRemove: onRemove,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(color: DuniColors.purple100),
        child: Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.all(DuniSpacing.md),
          decoration: BoxDecoration(
            color: backgroundColor ?? DuniColors.gray50,
            borderRadius: BorderRadius.circular(DuniRadius.medium),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: DuniColors.surface,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: DuniColors.purple200),
              ),
              const SizedBox(height: DuniSpacing.sm),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: DuniSpacing.xs,
                children: [
                  for (final actionLabel in actionLabels)
                    DuniButton(
                      label: actionLabel,
                      variant: DuniButtonVariant.text,
                      expand: false,
                      onPressed: onTap,
                    ),
                ],
              ),
              if (caption != null) ...[
                const SizedBox(height: DuniSpacing.xs),
                Text(
                  caption!,
                  textAlign: TextAlign.center,
                  style: DuniTypography.caption.copyWith(
                    color: DuniColors.textTertiary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectedImage extends StatelessWidget {
  const _SelectedImage({
    required this.imageUrl,
    required this.height,
    required this.onTap,
    this.onRemove,
  });

  final String imageUrl;
  final double height;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(DuniRadius.medium),
            child: Image.network(
              imageUrl,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(height: height, color: DuniColors.gray200),
            ),
          ),
          if (onRemove != null)
            Positioned(
              top: DuniSpacing.xs,
              right: DuniSpacing.xs,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(DuniSpacing.xxs),
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

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color});

  final Color color;

  static const _radius = DuniRadius.medium;
  static const _dashWidth = 6.0;
  static const _gapWidth = 4.0;
  static const _strokeWidth = 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        _strokeWidth / 2,
        _strokeWidth / 2,
        size.width - _strokeWidth,
        size.height - _strokeWidth,
      ),
      const Radius.circular(_radius),
    );
    final dashedPath = _dashPath(Path()..addRRect(rrect));
    canvas.drawPath(dashedPath, paint);
  }

  Path _dashPath(Path source) {
    final dashed = Path();
    for (final metric in source.computeMetrics()) {
      var distance = 0.0;
      var draw = true;
      while (distance < metric.length) {
        final length = draw ? _dashWidth : _gapWidth;
        final next = (distance + length).clamp(0.0, metric.length);
        if (draw) {
          dashed.addPath(metric.extractPath(distance, next), Offset.zero);
        }
        distance = next;
        draw = !draw;
      }
    }
    return dashed;
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color;
}
