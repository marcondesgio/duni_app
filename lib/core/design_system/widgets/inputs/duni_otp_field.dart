import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';

/// Campo de código de verificação — uma caixa por dígito, com avanço/volta
/// automático de foco. Usado na etapa de código do onboarding.
class DuniOtpField extends StatefulWidget {
  const DuniOtpField({
    super.key,
    this.length = 6,
    required this.onChanged,
    this.onCompleted,
    this.autofocus = true,
    this.enabled = true,
  });

  final int length;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onCompleted;
  final bool autofocus;
  final bool enabled;

  @override
  State<DuniOtpField> createState() => _DuniOtpFieldState();
}

class _DuniOtpFieldState extends State<DuniOtpField> {
  late final _controllers = List.generate(
    widget.length,
    (_) => TextEditingController(),
  );
  late final _focusNodes = List.generate(widget.length, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String get _value => _controllers.map((c) => c.text).join();

  void _handleChanged(int index, String value) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    widget.onChanged(_value);
    if (_value.length == widget.length) widget.onCompleted?.call(_value);
  }

  void _handleBackspace(int index) {
    if (_controllers[index].text.isNotEmpty || index <= 0) return;
    _focusNodes[index - 1].requestFocus();
    _controllers[index - 1].clear();
    widget.onChanged(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < widget.length; i++) ...[
          if (i > 0) const SizedBox(width: DuniSpacing.xs),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: _DigitBox(
                controller: _controllers[i],
                focusNode: _focusNodes[i],
                autofocus: widget.autofocus && i == 0,
                enabled: widget.enabled,
                onChanged: (value) => _handleChanged(i, value),
                onBackspace: () => _handleBackspace(i),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _DigitBox extends StatefulWidget {
  const _DigitBox({
    required this.controller,
    required this.focusNode,
    required this.autofocus,
    required this.enabled,
    required this.onChanged,
    required this.onBackspace,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final bool enabled;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;

  @override
  State<_DigitBox> createState() => _DigitBoxState();
}

class _DigitBoxState extends State<_DigitBox> {
  final _keyboardFocusNode = FocusNode(
    skipTraversal: true,
    canRequestFocus: false,
  );

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChange);
    _keyboardFocusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final focused = widget.focusNode.hasFocus;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      decoration: BoxDecoration(
        color: widget.enabled ? Colors.white : DuniColors.gray50,
        borderRadius: BorderRadius.circular(DuniRadius.medium),
        border: Border.all(
          color: focused ? DuniColors.purple200 : DuniColors.gray200,
          width: focused ? 1.5 : 1,
        ),
        boxShadow: focused
            ? [
                BoxShadow(
                  color: DuniColors.purple200.withAlpha(60),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: KeyboardListener(
        focusNode: _keyboardFocusNode,
        onKeyEvent: (event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            widget.onBackspace();
          }
        },
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          enabled: widget.enabled,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: DuniTypography.heading2.copyWith(color: DuniColors.purple500),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
