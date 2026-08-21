/// Placeholder: modelo local só para popular o ranking (pódio +
/// posições 4+). Substituir por uma entidade real quando a camada de dados
/// da feature existir.
class ChallengeRankingEntry {
  const ChallengeRankingEntry({
    required this.position,
    required this.name,
    required this.checkins,
    this.avatarUrl,
    this.isYourUser = false,
  });

  final int position;
  final String name;
  final int checkins;
  final String? avatarUrl;
  final bool isYourUser;
}

class ChallengeDetailState {
  const ChallengeDetailState({
    this.isLoading = true,
    this.subtitle = '',
    this.description = '',
    this.first,
    this.second,
    this.third,
    this.others = const [],
  });

  final bool isLoading;

  /// Ex.: "Check-in diário · 08 – 12 mai · 12 de 20 vagas".
  final String subtitle;
  final String description;
  final ChallengeRankingEntry? first;
  final ChallengeRankingEntry? second;
  final ChallengeRankingEntry? third;
  final List<ChallengeRankingEntry> others;

  ChallengeDetailState copyWith({
    bool? isLoading,
    String? subtitle,
    String? description,
    ChallengeRankingEntry? first,
    ChallengeRankingEntry? second,
    ChallengeRankingEntry? third,
    List<ChallengeRankingEntry>? others,
  }) {
    return ChallengeDetailState(
      isLoading: isLoading ?? this.isLoading,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      first: first ?? this.first,
      second: second ?? this.second,
      third: third ?? this.third,
      others: others ?? this.others,
    );
  }
}
