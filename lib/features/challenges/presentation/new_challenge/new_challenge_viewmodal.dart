import 'package:flutter/foundation.dart';

import 'new_challenge_state.dart';

const kNewChallengeInterests = <NewChallengeInterestOption>[
  NewChallengeInterestOption(id: 'academia', emoji: '💪', label: 'Academia'),
  NewChallengeInterestOption(id: 'pet', emoji: '🐾', label: 'Pet'),
];

/// ViewModel da tela "Novo desafio".
///
/// Sem camada de dados ainda (`challenges/data`, `challenges/domain`
/// continuam vazios) — [submit] não persiste/envia nada, só sinaliza sucesso
/// via [onCreated].
class NewChallengeViewmodal extends ChangeNotifier {
  NewChallengeViewmodal({this.onCreated}) {
    _state = _state.copyWith(selectedInterestId: kNewChallengeInterests.first.id);
  }

  final VoidCallback? onCreated;

  NewChallengeState _state = const NewChallengeState();
  NewChallengeState get state => _state;

  List<NewChallengeInterestOption> get interests => kNewChallengeInterests;

  void updateName(String value) => _update((s) => s.copyWith(name: value));

  void selectInterest(String id) =>
      _update((s) => s.copyWith(selectedInterestId: id));

  void selectFrequency(ChallengeCheckinFrequency frequency) =>
      _update((s) => s.copyWith(frequency: frequency));

  void toggleLimitParticipants(bool value) =>
      _update((s) => s.copyWith(limitParticipants: value));

  void updateMaxParticipants(int value) =>
      _update((s) => s.copyWith(maxParticipants: value));

  void updateStartDate(DateTime value) =>
      _update((s) => s.copyWith(startDate: value));

  void updateEndDate(DateTime value) =>
      _update((s) => s.copyWith(endDate: value));

  /// Placeholder: sem plugin de câmera/galeria integrado ainda — insere uma
  /// URL de exemplo (mesma convenção do `DuniAvatarPicker`/`DuniMediaPicker`).
  void pickCoverImage() => _update(
    (s) => s.copyWith(
      coverImageUrl: 'https://picsum.photos/seed/duni-new-challenge-cover/600/338',
    ),
  );

  void removeCoverImage() => _update((s) => s.copyWith(clearCoverImage: true));

  void updateDescription(String value) =>
      _update((s) => s.copyWith(description: value));

  void submit() {
    if (!_state.canSubmit) return;
    onCreated?.call();
  }

  void _update(NewChallengeState Function(NewChallengeState) transform) {
    _state = transform(_state);
    notifyListeners();
  }
}
