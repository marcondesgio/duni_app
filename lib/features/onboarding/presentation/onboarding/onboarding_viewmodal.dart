import 'package:flutter/foundation.dart';

import 'onboarding_state.dart';

/// Placeholder: lista de exemplo. Substituir por uma fonte real quando a
/// camada de dados da feature (`onboarding/data`, `onboarding/domain`) for
/// implementada.
const kOnboardingInterests = <OnboardingInterest>[
  OnboardingInterest(id: 'gym', emoji: '💪', label: 'Academia'),
  OnboardingInterest(id: 'pets', emoji: '🐾', label: 'Pet'),
  OnboardingInterest(id: 'cars', emoji: '⚙️', label: 'Gearhead'),
  OnboardingInterest(id: 'running', emoji: '🏃', label: 'Corrida'),
  OnboardingInterest(id: 'music', emoji: '🎵', label: 'Música'),
  OnboardingInterest(id: 'games', emoji: '🎮', label: 'Games'),
  OnboardingInterest(id: 'books', emoji: '📚', label: 'Leitura'),
  OnboardingInterest(id: 'cooking', emoji: '🍳', label: 'Culinária'),
  OnboardingInterest(id: 'travel', emoji: '✈', label: 'Viagens'),
  OnboardingInterest(id: 'movies', emoji: '🎬', label: 'Cinema'),
  OnboardingInterest(id: 'nature', emoji: '🌱', label: 'Natureza'),
];

/// ViewModel do fluxo de onboarding (login → código → interesses → foto).
///
/// Sem camada de dados ainda: os métodos de "submit" só validam localmente e
/// avançam a etapa — não há chamada de rede real.
class OnboardingViewmodal extends ChangeNotifier {
  OnboardingViewmodal({this.onFinished});

  /// Chamado quando o usuário conclui (ou pula) a etapa final. A tela Home
  /// ainda não existe no app, então quem constrói a View decide o que fazer
  /// aqui (hoje, só um aviso — ver [OnboardingView]).
  final VoidCallback? onFinished;

  OnboardingState _state = const OnboardingState();
  OnboardingState get state => _state;

  List<OnboardingInterest> get interests => kOnboardingInterests;

  void _update(OnboardingState Function(OnboardingState) transform) {
    _state = transform(_state);
    notifyListeners();
  }

  void updateEmail(String value) => _update((s) => s.copyWith(email: value));

  void submitEmail() {
    if (!_state.canSubmitEmail) return;
    _update((s) => s.copyWith(step: OnboardingStep.code));
  }

  void updateCode(String value) => _update((s) => s.copyWith(code: value));

  void submitCode() {
    if (!_state.canSubmitCode) return;
    _update((s) => s.copyWith(step: OnboardingStep.name));
  }

  void updateName(String value) => _update((s) => s.copyWith(name: value));

  void submitName() {
    if (!_state.canSubmitName) return;
    _update((s) => s.copyWith(step: OnboardingStep.interests));
  }

  void toggleInterest(String id) {
    final selected = {..._state.selectedInterestIds};
    if (!selected.remove(id)) selected.add(id);
    _update((s) => s.copyWith(selectedInterestIds: selected));
  }

  void continueFromInterests() {
    if (!_state.canContinueInterests) return;
    _update((s) => s.copyWith(step: OnboardingStep.photo));
  }

  /// Placeholder: sem plugin de câmera/galeria integrado ainda — quem chama
  /// isso hoje é [OnboardingPhotoStep] com uma URL de exemplo.
  void setPhoto(String url) => _update((s) => s.copyWith(photoUrl: url));

  void removePhoto() => _update((s) => s.copyWith(clearPhoto: true));

  void completeOnboarding() => onFinished?.call();

  void goBack() {
    switch (_state.step) {
      case OnboardingStep.login:
        return;
      case OnboardingStep.code:
        _update((s) => s.copyWith(step: OnboardingStep.login));
      case OnboardingStep.name:
        _update((s) => s.copyWith(step: OnboardingStep.code));
      case OnboardingStep.interests:
        _update((s) => s.copyWith(step: OnboardingStep.name));
      case OnboardingStep.photo:
        _update((s) => s.copyWith(step: OnboardingStep.interests));
    }
  }
}
