/// Frequência de check-in de um desafio (seção 30 da documentação) — enum de
/// domínio da feature, não um token do Design System.
enum ChallengeCheckinFrequency { daily, weekly, free }

extension ChallengeCheckinFrequencyLabel on ChallengeCheckinFrequency {
  String get label {
    switch (this) {
      case ChallengeCheckinFrequency.daily:
        return 'Diário';
      case ChallengeCheckinFrequency.weekly:
        return 'Semanal';
      case ChallengeCheckinFrequency.free:
        return 'Livre';
    }
  }
}

/// Placeholder: catálogo de interesses de exemplo (sem camada de dados
/// ainda) — a mesma ideia já usada no onboarding, só que local a esta tela.
class NewChallengeInterestOption {
  const NewChallengeInterestOption({
    required this.id,
    required this.emoji,
    required this.label,
  });

  final String id;
  final String emoji;
  final String label;
}

class NewChallengeState {
  const NewChallengeState({
    this.name = '',
    this.selectedInterestId,
    this.frequency = ChallengeCheckinFrequency.daily,
    this.limitParticipants = true,
    this.maxParticipants = 20,
    this.startDate,
    this.endDate,
    this.coverImageUrl,
    this.description = '',
  });

  final String name;
  final String? selectedInterestId;
  final ChallengeCheckinFrequency frequency;
  final bool limitParticipants;
  final int maxParticipants;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? coverImageUrl;
  final String description;

  bool get canSubmit =>
      name.trim().isNotEmpty &&
      selectedInterestId != null &&
      startDate != null &&
      endDate != null;

  NewChallengeState copyWith({
    String? name,
    String? selectedInterestId,
    ChallengeCheckinFrequency? frequency,
    bool? limitParticipants,
    int? maxParticipants,
    DateTime? startDate,
    DateTime? endDate,
    String? coverImageUrl,
    bool clearCoverImage = false,
    String? description,
  }) {
    return NewChallengeState(
      name: name ?? this.name,
      selectedInterestId: selectedInterestId ?? this.selectedInterestId,
      frequency: frequency ?? this.frequency,
      limitParticipants: limitParticipants ?? this.limitParticipants,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      coverImageUrl: clearCoverImage
          ? null
          : (coverImageUrl ?? this.coverImageUrl),
      description: description ?? this.description,
    );
  }
}
