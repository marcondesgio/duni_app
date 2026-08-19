import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/foundation.dart';

import 'chat_state.dart';

/// ViewModel do chat de um grupo.
///
/// Sem camada de dados ainda (`groups/data`, `groups/domain` continuam
/// vazios) — [load] popula uma conversa de exemplo (a mesma para qualquer
/// grupo aberto); [sendMessage]/[sendSamplePhoto] só avançam o estado local,
/// sem persistir/enviar de fato.
class ChatViewmodal extends ChangeNotifier {
  ChatViewmodal() {
    load();
  }

  ChatState _state = const ChatState();
  ChatState get state => _state;

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    _state = const ChatState(
      isLoading: false,
      messages: [
        ChatMessageItem(
          type: DuniChatMessageType.text,
          authorName: 'Lucas M.',
          avatarInitials: 'LM',
          time: '08:12',
          isMine: false,
          message:
              'alguém aí treina de manhã antes do primeiro call? tô '
              'tentando criar o hábito',
        ),
        ChatMessageItem(
          type: DuniChatMessageType.text,
          authorName: 'Mariana C.',
          avatarInitials: 'MC',
          time: '08:20',
          isMine: false,
          message: 'eu! 6h30 direto. o segredo é dormir de roupa de treino 😅',
          reaction: '😅💪 5',
        ),
        ChatMessageItem(
          type: DuniChatMessageType.text,
          authorName: 'Você',
          avatarInitials: 'EU',
          time: '09:02 · Visto por 12',
          isMine: true,
          message: 'tô dentro, e se a gente virasse isso num desafio?',
        ),
        ChatMessageItem(
          type: DuniChatMessageType.image,
          authorName: 'Pedro H.',
          avatarInitials: 'PH',
          time: '09:14',
          isMine: false,
          imageUrl: 'https://picsum.photos/seed/duni-chat-photo/400',
          imageDescription: 'vista de hoje 🏃',
        ),
      ],
    );
    notifyListeners();
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    _appendMessage(
      ChatMessageItem(
        type: DuniChatMessageType.text,
        authorName: 'Você',
        avatarInitials: 'EU',
        time: 'Agora',
        isMine: true,
        message: text.trim(),
      ),
    );
  }

  /// Placeholder: sem plugin de câmera/galeria integrado ainda — insere uma
  /// foto de exemplo, mesma convenção do `DuniMediaPicker`/`DuniAvatarPicker`.
  void sendSamplePhoto() {
    _appendMessage(
      ChatMessageItem(
        type: DuniChatMessageType.image,
        authorName: 'Você',
        avatarInitials: 'EU',
        time: 'Agora',
        isMine: true,
        imageUrl:
            'https://picsum.photos/seed/duni-chat-sent-${_state.messages.length}/400',
      ),
    );
  }

  void _appendMessage(ChatMessageItem message) {
    _state = _state.copyWith(messages: [..._state.messages, message]);
    notifyListeners();
  }
}
