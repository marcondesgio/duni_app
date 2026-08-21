import 'package:duni_app/core/design_system/design_system.dart';

/// Placeholder: modelo local só para popular [DuniChatBubble]/[DuniCheckinCard]
/// nesta tela. Substituir por uma entidade real quando a camada de dados da
/// feature existir.
enum ChallengeChatMessageKind { text, image, checkin }

class ChallengeChatMessageItem {
  const ChallengeChatMessageItem({
    required this.kind,
    required this.authorName,
    required this.avatarInitials,
    required this.time,
    this.isMine = false,
    this.message,
    this.imageUrl,
    this.imageDescription,
    this.checkinDescription,
  });

  final ChallengeChatMessageKind kind;
  final String authorName;
  final String avatarInitials;
  final String time;
  final bool isMine;
  final String? message;
  final String? imageUrl;
  final String? imageDescription;
  final String? checkinDescription;
}

class ChallengeChatState {
  const ChallengeChatState({
    this.isLoading = true,
    this.messages = const [],
    this.showCheckinReminder = true,
  });

  final bool isLoading;
  final List<ChallengeChatMessageItem> messages;
  final bool showCheckinReminder;

  ChallengeChatState copyWith({
    bool? isLoading,
    List<ChallengeChatMessageItem>? messages,
    bool? showCheckinReminder,
  }) {
    return ChallengeChatState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
      showCheckinReminder: showCheckinReminder ?? this.showCheckinReminder,
    );
  }
}

/// Conversão para o tipo do Design System — [ChallengeChatMessageKind.checkin]
/// não existe em [DuniChatMessageType] (check-ins usam [DuniCheckinCard]
/// diretamente, não [DuniChatBubble]).
extension ChallengeChatMessageKindMapping on ChallengeChatMessageKind {
  DuniChatMessageType? get toBubbleType {
    switch (this) {
      case ChallengeChatMessageKind.text:
        return DuniChatMessageType.text;
      case ChallengeChatMessageKind.image:
        return DuniChatMessageType.image;
      case ChallengeChatMessageKind.checkin:
        return null;
    }
  }
}
