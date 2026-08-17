/// Etapas do fluxo de onboarding, nesta ordem (seção 43 da documentação:
/// Login → Código → Onboarding). `interests` e `photo` são as duas únicas
/// etapas que a documentação de fato descreve como "onboarding" (seções 16,
/// 26, 27 e 28) — por isso são as que usam [DuniOnboardingProgress].
enum OnboardingStep { login, code, name, interests, photo }

/// Placeholder: catálogo de interesses ainda não vem de uma camada de dados
/// real (domain/data da feature continuam vazios) — usado só para o fluxo
/// funcionar visualmente até existir uma fonte real.
class OnboardingInterest {
  const OnboardingInterest({
    required this.id,
    required this.emoji,
    required this.label,
  });

  final String id;
  final String emoji;
  final String label;
}

class OnboardingState {
  const OnboardingState({
    this.step = OnboardingStep.login,
    this.email = '',
    this.name = '',
    this.code = '',
    this.selectedInterestIds = const {},
    this.photoUrl,
  });

  static const minSelectedInterests = 3;

  final OnboardingStep step;
  final String email;
  final String name;
  final String code;
  final Set<String> selectedInterestIds;
  final String? photoUrl;

  bool get canSubmitEmail => email.trim().isNotEmpty;
  bool get canSubmitName => name.trim().isNotEmpty;
  bool get canSubmitCode => code.trim().isNotEmpty;
  bool get canContinueInterests =>
      selectedInterestIds.length >= minSelectedInterests;

  OnboardingState copyWith({
    OnboardingStep? step,
    String? email,
    String? code,
    String? name,
    Set<String>? selectedInterestIds,
    String? photoUrl,
    bool clearPhoto = false,
  }) {
    return OnboardingState(
      step: step ?? this.step,
      email: email ?? this.email,
      name: name ?? this.name,
      code: code ?? this.code,
      selectedInterestIds: selectedInterestIds ?? this.selectedInterestIds,
      photoUrl: clearPhoto ? null : (photoUrl ?? this.photoUrl),
    );
  }
}
