import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Barra de composição de mensagem do chat: anexar mídia, campo de texto e
/// enviar (seção 20 da documentação — mensagens de texto/imagem).
///
/// Visual "flutuante": um único painel em pílula, translúcido e desfocado
/// (estilo WhatsApp) — pensado para ser posicionado sobre a lista de
/// mensagens (ver `ChatView`), não como uma barra opaca encostada no fundo.
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(DuniRadius.pill),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DuniSpacing.xxs),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: DuniSpacing.xs,
          children: [
            if (widget.onAttach != null)
              Padding(
                padding: const EdgeInsets.only(bottom: DuniSpacing.xxs),
                child: DuniIconButton(
                  icon: Icons.add,
                  variant: DuniIconButtonVariant.secundary,
                  onPressed: widget.onAttach,
                ),
              ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: DuniSpacing.md),
                decoration: BoxDecoration(
                  color: DuniColors.white,
                  borderRadius: BorderRadius.circular(DuniRadius.pill),
                  border: Border.all(color: DuniColors.gray100, width: 1),
                ),
                child: TextField(
                  controller: _controller,
                  minLines: 1,
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  style: DuniTypography.body.copyWith(
                    color: DuniColors.purple500,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: DuniTypography.body.copyWith(
                      color: DuniColors.purpleGray50,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: DuniSpacing.sm,
                    ),
                    fillColor: DuniColors.white,
                    enabledBorder: InputBorder.none,
                  ),
                  onSubmitted: (_) => _submit(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: DuniSpacing.xxs),
              child: DuniIconButton(
                icon: Icons.send_rounded,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
