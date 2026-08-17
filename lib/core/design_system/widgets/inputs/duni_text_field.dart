import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';

/// Campo de texto do DUNI Design System.
///
/// Suporta os estados default / focused / filled / error / disabled
/// descritos na seção 14 da documentação — focused e filled são refletidos
/// automaticamente pelo próprio campo (foco e conteúdo), error via
/// [errorText] e disabled via [enabled].
class DuniTextField extends StatelessWidget {
  const DuniTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.errorText,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.suffixIcon,
    this.minLines,
    this.maxLines = 1,
  });

  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final String? errorText;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: DuniTypography.label.copyWith(color: DuniColors.purple500),
          ),
          const SizedBox(height: DuniSpacing.xxs),
        ],
        TextField(
          controller: controller,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          minLines: minLines,
          maxLines: maxLines,
          style: DuniTypography.body.copyWith(color: DuniColors.purple500),
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: enabled ? Colors.white : DuniColors.gray50,
            hintStyle: DuniTypography.body.copyWith(color: DuniColors.gray200),
            errorStyle: DuniTypography.bodySmall.copyWith(
              color: DuniColors.error,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: DuniSpacing.md,
              vertical: DuniSpacing.sm,
            ),
            border: _border(DuniColors.gray200),
            enabledBorder: _border(DuniColors.gray200),
            disabledBorder: _border(DuniColors.gray200),
            focusedBorder: _border(DuniColors.purple200, width: 1.5),
            errorBorder: _border(DuniColors.error),
            focusedErrorBorder: _border(DuniColors.error, width: 1.5),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(DuniRadius.medium),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
