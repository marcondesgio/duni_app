import 'package:duni_app/core/design_system/design_system.dart';

/// Placeholder: modelo local só para popular [DuniChatBubble]. Substituir
/// por uma entidade real quando a camada de dados da feature existir.
class ChatMessageItem {
  const ChatMessageItem({
    required this.type,
    required this.authorName,
    required this.avatarInitials,
    required this.time,
    required this.isMine,
    this.message,
    this.imageUrl,
    this.imageDescription,
    this.reaction,
  });

  final DuniChatMessageType type;
  final String authorName;
  final String avatarInitials;
  final String time;
  final bool isMine;
  final String? message;
  final String? imageUrl;
  final String? imageDescription;
  final String? reaction;
}

class ChatState {
  const ChatState({this.isLoading = true, this.messages = const []});

  final bool isLoading;
  final List<ChatMessageItem> messages;

  ChatState copyWith({bool? isLoading, List<ChatMessageItem>? messages}) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      messages: messages ?? this.messages,
    );
  }
}
