/// Retornado via `Navigator.pop` para a tela de chat do desafio adicionar a
/// mensagem de check-in (sem estado/ViewModel compartilhado entre as duas
/// telas — mesmo padrão de decoupling já usado nas outras features).
class CheckinResult {
  const CheckinResult({required this.photoUrl, required this.description});

  final String photoUrl;
  final String description;
}

class CheckinState {
  const CheckinState({
    this.photoUrl,
    this.description = '',
    this.streakDays = 3,
  });

  final String? photoUrl;
  final String description;
  final int streakDays;

  /// Seção 32 da documentação: foto e descrição são obrigatórias.
  bool get canSubmit => photoUrl != null && description.trim().isNotEmpty;

  CheckinState copyWith({
    String? photoUrl,
    bool clearPhoto = false,
    String? description,
    int? streakDays,
  }) {
    return CheckinState(
      photoUrl: clearPhoto ? null : (photoUrl ?? this.photoUrl),
      description: description ?? this.description,
      streakDays: streakDays ?? this.streakDays,
    );
  }
}
