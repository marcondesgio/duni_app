import 'package:flutter/foundation.dart';

import 'profile_state.dart';

/// Placeholder: catálogo de interesses de exemplo (sem camada de dados
/// ainda) — mesma ideia usada no onboarding/challenges, local a esta tela.
const kProfileInterestCatalog = <ProfileInterest>[
  ProfileInterest(id: 'academia', emoji: '💪', label: 'Academia'),
  ProfileInterest(id: 'pet', emoji: '🐾', label: 'Pet'),
  ProfileInterest(id: 'carros', emoji: '🚗', label: 'Carros'),
  ProfileInterest(id: 'games', emoji: '🎮', label: 'Games'),
  ProfileInterest(id: 'musica', emoji: '🎵', label: 'Música'),
  ProfileInterest(id: 'corrida', emoji: '🏃', label: 'Corrida'),
];

/// ViewModel do Perfil.
///
/// Sem camada de dados ainda (`profile/data`, `profile/domain` continuam
/// vazios) — [load] popula dados de exemplo; [removeInterest]/[addInterest]
/// só avançam o estado local, sem persistir/enviar de fato.
class ProfileViewmodal extends ChangeNotifier {
  ProfileViewmodal() {
    load();
  }

  ProfileState _state = const ProfileState();
  ProfileState get state => _state;

  /// Interesses do catálogo ainda não adicionados ao perfil.
  List<ProfileInterest> get availableInterests => kProfileInterestCatalog
      .where((c) => !_state.interests.any((i) => i.id == c.id))
      .toList();

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    _state = const ProfileState(
      isLoading: false,
      name: 'Gabi',
      email: 'gabi.rocha@nexora.com',
      company: 'Nexora',
      challengesCount: 2,
      checkinsCount: 17,
      interests: [
        ProfileInterest(id: 'academia', emoji: '💪', label: 'Academia'),
        ProfileInterest(id: 'pet', emoji: '🐾', label: 'Pet'),
        ProfileInterest(id: 'carros', emoji: '🚗', label: 'Carros'),
        ProfileInterest(id: 'games', emoji: '🎮', label: 'Games'),
      ],
    );
    notifyListeners();
  }

  void removeInterest(String id) {
    _update(
      (s) => s.copyWith(
        interests: s.interests.where((i) => i.id != id).toList(),
      ),
    );
  }

  void addInterest(ProfileInterest interest) {
    _update((s) => s.copyWith(interests: [...s.interests, interest]));
  }

  /// Placeholder: sem plugin de câmera/galeria integrado ainda — insere uma
  /// URL de exemplo (mesma convenção do `DuniMediaPicker`/onboarding).
  void updateAvatar() {
    _update(
      (s) => s.copyWith(
        avatarUrl: 'https://picsum.photos/seed/duni-profile-avatar/300',
      ),
    );
  }

  void _update(ProfileState Function(ProfileState) transform) {
    _state = transform(_state);
    notifyListeners();
  }
}
