import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

enum DuniIconButtonVariant { primary, secundary }

enum DuniIconButtonState { enabled, disabled, loading }

/// Botão circular de ícone do DUNI Design System, com as mesmas variantes de
/// [DuniButton].
class DuniIconButton extends StatelessWidget {
  const DuniIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = DuniIconButtonVariant.primary,
    this.state = DuniIconButtonState.enabled,
    this.size = 40,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final DuniIconButtonVariant variant;
  final DuniIconButtonState state;
  final double size;

  bool get _isEnabled =>
      state == DuniIconButtonState.enabled && onPressed != null;

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          state == DuniIconButtonState.disabled &&
              variant == DuniIconButtonVariant.primary
          ? DuniColors.purple50
          : _backgroundColor,
      shape: CircleBorder(side: BorderSide.none),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: _isEnabled ? onPressed : null,
        child: Container(
          decoration: _gradient != null
              ? BoxDecoration(
                  gradient: _gradient,
                  borderRadius: BorderRadius.circular(DuniRadius.pill),
                )
              : null,
          width: size,
          height: size,
          child: state == DuniIconButtonState.loading
              ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: LoadingAnimationWidget.progressiveDots(
                    color: _foregroundColor,
                    size: size - 24,
                  ),
                )
              : Icon(
                  icon,
                  color:
                      state == DuniIconButtonState.disabled &&
                          variant == DuniIconButtonVariant.primary
                      ? DuniColors.purpleGray50
                      : state == DuniIconButtonState.disabled &&
                            variant == DuniIconButtonVariant.secundary
                      ? DuniColors.gray200
                      : _foregroundColor,
                  size: size * 0.45,
                ),
        ),
      ),
    );
  }

  Gradient? get _gradient =>
      (variant == DuniIconButtonVariant.primary &&
          state != DuniIconButtonState.disabled)
      ? DuniGradients.purple
      : null;

  Color get _backgroundColor {
    switch (variant) {
      case DuniIconButtonVariant.primary:
        return DuniColors.purple200;
      case DuniIconButtonVariant.secundary:
        return DuniColors.gray100;
    }
  }

  Color get _foregroundColor {
    switch (variant) {
      case DuniIconButtonVariant.primary:
        return DuniColors.white;
      case DuniIconButtonVariant.secundary:
        return DuniColors.purple500;
    }
  }
}
