abstract final class ChallengesRouter {
  static const String newChallengePage = '/challenges/new';
  static const String detailPage = '/challenges/detail';
  static const String chatPage = '/challenges/chat';

  // Sem `checkinPage`: `CheckinView` é aberto com `Navigator.push` direto
  // (não `pushNamed`) porque a tela de chat precisa do valor de retorno
  // (`CheckinResult`) para adicionar a mensagem — ver `ChallengeChatView`.
}
