import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../colors/duni_colors.dart';
import '../../gradients/duni_gradients.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';

enum DuniButtonVariant { primary, text }

enum DuniButtonState { enabled, disabled, loading }

/// Botão padrão do DUNI Design System.
///
/// O `primary` utiliza o gradiente roxo/violeta ([DuniGradients.primary]) que
/// representa a identidade de marca do DUNI.
class DuniButton extends StatelessWidget {
  const DuniButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = DuniButtonVariant.primary,
    this.state = DuniButtonState.enabled,
    this.leadingIcon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final DuniButtonVariant variant;
  final DuniButtonState state;
  final IconData? leadingIcon;

  /// Se `true` (padrão), ocupa toda a largura disponível.
  final bool expand;

  bool get _isEnabled => state == DuniButtonState.enabled && onPressed != null;
  bool get _isLoading => state == DuniButtonState.loading;

  @override
  Widget build(BuildContext context) {
    final content = _Content(
      label: label,
      leadingIcon: leadingIcon,
      loading: _isLoading,
      textStyle: DuniTypography.button.copyWith(
        color: state == DuniButtonState.disabled
            ? DuniColors.purpleGray50
            : _foregroundColor,
      ),
      foregroundColor: state == DuniButtonState.disabled
          ? DuniColors.purpleGray50
          : _foregroundColor,
    );

    final button = Material(
      color: state == DuniButtonState.disabled
          ? DuniColors.purple50
          : _flatBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DuniRadius.pill),
        side: BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(DuniRadius.pill),
        onTap: _isEnabled && !_isLoading ? onPressed : null,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: DuniSpacing.lg,
            vertical: DuniSpacing.sm,
          ),
          decoration: _gradient != null
              ? BoxDecoration(
                  gradient: _gradient,
                  borderRadius: BorderRadius.circular(DuniRadius.pill),
                )
              : null,
          alignment: Alignment.center,
          child: content,
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }

  Gradient? get _gradient =>
      (variant == DuniButtonVariant.primary &&
          state != DuniButtonState.disabled)
      ? DuniGradients.purple
      : null;

  Color get _flatBackgroundColor {
    switch (variant) {
      case DuniButtonVariant.primary:
        return DuniColors.purple200;
      case DuniButtonVariant.text:
        return Colors.transparent;
    }
  }

  Color get _foregroundColor {
    switch (variant) {
      case DuniButtonVariant.primary:
        return Colors.white;
      case DuniButtonVariant.text:
        return DuniColors.purpleGray100;
    }
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.label,
    required this.leadingIcon,
    required this.loading,
    required this.textStyle,
    required this.foregroundColor,
  });

  final String label;
  final IconData? leadingIcon;
  final bool loading;
  final TextStyle textStyle;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: LoadingAnimationWidget.progressiveDots(
          color: foregroundColor,
          size: DuniSpacing.lg,
        ),
      );
    }

    if (leadingIcon == null) {
      return Text(label, style: textStyle);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(leadingIcon, size: 18, color: foregroundColor),
        const SizedBox(width: DuniSpacing.xs),
        Text(label, style: textStyle),
      ],
    );
  }
}
