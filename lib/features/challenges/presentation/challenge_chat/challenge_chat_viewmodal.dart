import 'package:flutter/foundation.dart';

import 'challenge_chat_state.dart';

/// ViewModel do chat de um desafio.
///
/// Sem camada de dados ainda (`challenges/data`, `challenges/domain`
/// continuam vazios) — [load] popula uma conversa de exemplo (a mesma para
/// qualquer desafio aberto); [sendMessage]/[sendSamplePhoto]/[addCheckin] só
/// avançam o estado local, sem persistir/enviar de fato.
class ChallengeChatViewmodal extends ChangeNotifier {
  ChallengeChatViewmodal() {
    load();
  }

  ChallengeChatState _state = const ChallengeChatState();
  ChallengeChatState get state => _state;

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    _state = const ChallengeChatState(
      isLoading: false,
      showCheckinReminder: true,
      messages: [
        ChallengeChatMessageItem(
          kind: ChallengeChatMessageKind.checkin,
          authorName: 'Lucas M.',
          avatarInitials: 'LM',
          time: '06:40',
          imageUrl: 'https://picsum.photos/seed/duni-challenge-chat-checkin/600/400',
          checkinDescription: '6km antes do daily. Frio de matar mas valeu.',
        ),
        ChallengeChatMessageItem(
          kind: ChallengeChatMessageKind.text,
          authorName: 'Mariana C.',
          avatarInitials: 'MC',
          time: '07:05',
          message: '6km?? tá competindo com quem, Lucas 😂',
        ),
        ChallengeChatMessageItem(
          kind: ChallengeChatMessageKind.text,
          authorName: 'Você',
          avatarInitials: 'EU',
          time: '07:11',
          isMine: true,
          message: 'com ele mesmo 😅 vou fazer o meu no almoço',
        ),
      ],
    );
    notifyListeners();
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    _appendMessage(
      ChallengeChatMessageItem(
        kind: ChallengeChatMessageKind.text,
        authorName: 'Você',
        avatarInitials: 'EU',
        time: 'Agora',
        isMine: true,
        message: text.trim(),
      ),
    );
  }

  /// Placeholder: sem plugin de câmera/galeria integrado ainda — insere uma
  /// foto de exemplo (mesma convenção do chat de grupos).
  void sendSamplePhoto() {
    _appendMessage(
      ChallengeChatMessageItem(
        kind: ChallengeChatMessageKind.image,
        authorName: 'Você',
        avatarInitials: 'EU',
        time: 'Agora',
        isMine: true,
        imageUrl:
            'https://picsum.photos/seed/duni-challenge-chat-sent-${_state.messages.length}/400',
      ),
    );
  }

  /// Chamado quando a tela de check-in retorna com um resultado — some com o
  /// lembrete de check-in pendente e adiciona a mensagem à conversa.
  void addCheckin({required String photoUrl, required String description}) {
    _state = _state.copyWith(showCheckinReminder: false);
    _appendMessage(
      ChallengeChatMessageItem(
        kind: ChallengeChatMessageKind.checkin,
        authorName: 'Você',
        avatarInitials: 'EU',
        time: 'Agora',
        isMine: true,
        imageUrl: photoUrl,
        checkinDescription: description,
      ),
    );
  }

  void _appendMessage(ChallengeChatMessageItem message) {
    _state = _state.copyWith(messages: [..._state.messages, message]);
    notifyListeners();
  }
}
