import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';
import '../buttons/duni_icon_button.dart';

/// Barra de composição de mensagem do chat: anexar mídia, campo de texto em
/// pílula e enviar (seção 20 da documentação — mensagens de texto/imagem).
class DuniChatComposer extends StatefulWidget {
  const DuniChatComposer({
    super.key,
    required this.onSend,
    this.onAttach,
    this.hintText = 'Mensagem',
  });

  final ValueChanged<String> onSend;
  final VoidCallback? onAttach;
  final String hintText;

  @override
  State<DuniChatComposer> createState() => _DuniChatComposerState();
}

class _DuniChatComposerState extends State<DuniChatComposer> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.onAttach != null) ...[
          DuniIconButton(
            icon: Icons.add,
            variant: DuniIconButtonVariant.secundary,
            onPressed: widget.onAttach,
          ),
          const SizedBox(width: DuniSpacing.xs),
        ],
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: DuniSpacing.md),
            decoration: BoxDecoration(
              color: DuniColors.gray100,
              borderRadius: BorderRadius.circular(DuniRadius.pill),
            ),
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              style: DuniTypography.body.copyWith(color: DuniColors.purple500),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: DuniTypography.body.copyWith(
                  color: DuniColors.purpleGray50,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: DuniSpacing.sm,
                ),
              ),
              onSubmitted: (_) => _submit(),
            ),
          ),
        ),
        const SizedBox(width: DuniSpacing.xs),
        DuniIconButton(
          icon: Icons.send_rounded,
          onPressed: _submit,
        ),
      ],
    );
  }
}
