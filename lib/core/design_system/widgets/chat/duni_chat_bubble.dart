import 'package:flutter/material.dart';
import 'package:duni_app/core/design_system/design_system.dart';

/// Tipo de mensagem de chat (seção 20 da documentação).
///
/// `checkin` não é renderizado por [DuniChatBubble]: a documentação define
/// que check-ins entram no chat como um card próprio — usar
/// [DuniCheckinCard] diretamente na lista de mensagens nesse caso.
enum DuniChatMessageType { text, image }

/// Mensagem de chat: avatar, nome, horário, mensagem, reação e indicação de
/// autoria (seção 20).
class DuniChatBubble extends StatelessWidget {
  const DuniChatBubble({
    super.key,
    required this.type,
    required this.authorName,
    required this.time,
    required this.isMine,
    this.avatarUrl,
    this.avatarInitials,
    this.message,
    this.imageUrl,
    this.imageDescription,
    this.reaction,
    this.onImageTap,
  }) : assert(
         type != DuniChatMessageType.text || message != null,
         'message é obrigatório para DuniChatMessageType.text',
       );

  final DuniChatMessageType type;
  final String authorName;
  final String time;
  final bool isMine;
  final String? avatarUrl;

  /// Iniciais exibidas quando não há [avatarUrl] (fallback do [DuniAvatar]).
  final String? avatarInitials;
  final String? message;
  final String? imageUrl;
  final String? imageDescription;
  final String? reaction;
  final VoidCallback? onImageTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMine
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!isMine) ...[
          DuniAvatar(
            imageUrl: avatarUrl,
            initials: avatarInitials,
            size: DuniAvatarSize.small,
          ),
          const SizedBox(width: DuniSpacing.xs),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: isMine
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isMine) ...[
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 2,
                    left: DuniSpacing.xxs,
                  ),
                  child: Text(
                    '$authorName · $time',
                    style: DuniTypography.caption.copyWith(
                      color: DuniColors.purpleGray100,
                    ),
                  ),
                ),
              ],
              _Bubble(
                isMine: isMine,
                tinted: isMine && type == DuniChatMessageType.text,
                child: type == DuniChatMessageType.image
                    ? DuniMediaMessage(
                        imageUrl: imageUrl!,
                        description: imageDescription,
                        onTap: onImageTap,
                      )
                    : Text(
                        message!,
                        style: DuniTypography.body.copyWith(
                          color: isMine
                              ? DuniColors.white
                              : DuniColors.purple500,
                        ),
                      ),
              ),
              if (reaction != null) ...[
                Container(
                  margin: const EdgeInsets.only(top: DuniSpacing.xxs),
                  padding: const EdgeInsets.all(DuniSpacing.xxs),
                  decoration: BoxDecoration(
                    border: Border.all(color: DuniColors.gray200),
                    borderRadius: BorderRadius.all(
                      Radius.circular(DuniRadius.pill),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        reaction!,
                        style: const TextStyle(fontSize: DuniSpacing.sm),
                      ),
                      const SizedBox(width: DuniSpacing.xxs),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.isMine,
    required this.tinted,
    required this.child,
  });

  final bool isMine;

  /// Fundo colorido (`DuniColors.primary`) só se aplica a mensagens de texto
  /// próprias — mensagens de imagem mantêm fundo neutro para não prejudicar
  /// o contraste da legenda.
  final bool tinted;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DuniSpacing.sm,
        vertical: DuniSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: tinted ? DuniColors.purple200 : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            !isMine ? DuniRadius.tiny : DuniRadius.bubble,
          ),

          topRight: Radius.circular(
            isMine ? DuniRadius.tiny : DuniRadius.bubble,
          ),

          bottomLeft: Radius.circular(DuniRadius.bubble),
          bottomRight: Radius.circular(DuniRadius.bubble),
        ),
        border: tinted ? null : Border.all(color: DuniColors.gray200),
      ),
      child: child,
    );
  }
}
