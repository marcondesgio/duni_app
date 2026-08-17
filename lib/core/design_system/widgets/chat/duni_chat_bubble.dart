import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';
import '../avatars/duni_avatar.dart';
import '../media/duni_media_message.dart';

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
  final String? message;
  final String? imageUrl;
  final String? imageDescription;
  final String? reaction;
  final VoidCallback? onImageTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: isMine
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!isMine) ...[
          DuniAvatar(imageUrl: avatarUrl, size: DuniAvatarSize.xs),
          const SizedBox(width: DuniSpacing.xs),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: isMine
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isMine)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 2,
                    left: DuniSpacing.xxs,
                  ),
                  child: Text(
                    authorName,
                    style: DuniTypography.caption.copyWith(
                      color: DuniColors.purple500.withAlpha(160),
                    ),
                  ),
                ),
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
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (reaction != null) ...[
                      Text(reaction!, style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: DuniSpacing.xxs),
                    ],
                    Text(
                      time,
                      style: DuniTypography.caption.copyWith(
                        color: DuniColors.purple500.withAlpha(130),
                      ),
                    ),
                  ],
                ),
              ),
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
          topLeft: const Radius.circular(DuniRadius.medium),
          topRight: const Radius.circular(DuniRadius.medium),
          bottomLeft: Radius.circular(
            isMine ? DuniRadius.medium : DuniRadius.small,
          ),
          bottomRight: Radius.circular(
            isMine ? DuniRadius.small : DuniRadius.medium,
          ),
        ),
        border: tinted ? null : Border.all(color: DuniColors.gray200),
      ),
      child: child,
    );
  }
}
