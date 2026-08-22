import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Card de check-in — visualmente distinto de uma mensagem comum de chat,
/// entrando na conversa como um card próprio (seção 22 da documentação).
///
/// Não inclui avatar: quem usa este componente numa lista de chat deve
/// posicionar o avatar do autor ao lado, do mesmo jeito que o
/// [DuniChatBubble] faz para mensagens que não são do usuário atual.
class DuniCheckinCard extends StatelessWidget {
  const DuniCheckinCard({
    super.key,
    required this.userName,
    required this.photoUrl,
    required this.description,
    required this.time,
    this.onTap,
  });

  final String userName;
  final String photoUrl;
  final String description;
  final String time;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DuniCard(
      onTap: onTap,
      padding: const EdgeInsets.all(DuniSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$userName fez check-in',
                  style: DuniTypography.label.copyWith(
                    color: DuniColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                time,
                style: DuniTypography.caption.copyWith(
                  color: DuniColors.textPrimary.withAlpha(140),
                ),
              ),
            ],
          ),
          const SizedBox(height: DuniSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(DuniRadius.small),
            child: Image.network(
              photoUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 160,
                width: double.infinity,
                color: DuniColors.gray200,
                alignment: Alignment.center,
                child: Text(
                  'FOTO DO CHECK-IN',
                  style: DuniTypography.caption.copyWith(
                    color: DuniColors.textPrimary.withAlpha(140),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: DuniSpacing.xs),
          Text(
            description,
            style: DuniTypography.body.copyWith(
              color: DuniColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
