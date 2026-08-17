import 'package:flutter/material.dart';

import 'duni_text_field.dart';

/// Variante multilinha do [DuniTextField], usada em descrições e regras de
/// desafios (seção 29 da documentação).
class DuniTextArea extends StatelessWidget {
  const DuniTextArea({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.errorText,
    this.enabled = true,
    this.onChanged,
    this.minLines = 4,
    this.maxLines = 8,
  });

  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final String? errorText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return DuniTextField(
      label: label,
      hintText: hintText,
      controller: controller,
      errorText: errorText,
      enabled: enabled,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
