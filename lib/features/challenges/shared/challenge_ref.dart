/// Identidade/exibição mínima de um desafio, passada como argumento de rota
/// entre Chat, Detalhes/Ranking e Check-in — essas telas ainda não têm uma
/// camada de dados real, então isso viaja via `Navigator` em vez de vir de
/// um repositório (mesmo padrão do `GroupRef` da feature `groups`).
class ChallengeRef {
  const ChallengeRef({
    required this.id,
    required this.name,
    required this.interestEmoji,
    required this.interestLabel,
    required this.coverImageUrl,
    required this.currentDay,
    required this.totalDays,
    required this.myPosition,
    required this.myCheckins,
  });

  final String id;
  final String name;
  final String interestEmoji;
  final String interestLabel;
  final String coverImageUrl;
  final int currentDay;
  final int totalDays;
  final int myPosition;
  final int myCheckins;
}
