import 'package:flutter/foundation.dart';

import 'groups_state.dart';

/// ViewModel da lista de grupos.
///
/// Sem camada de dados ainda (`groups/data`, `groups/domain` continuam
/// vazios) — [load] só simula uma busca e popula dados de exemplo.
class GroupsViewmodal extends ChangeNotifier {
  GroupsViewmodal() {
    load();
  }

  GroupsState _state = const GroupsState();
  GroupsState get state => _state;

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 400));

    _state = const GroupsState(
      isLoading: false,
      groups: [
        GroupPreview(
          id: 'academia',
          icon: '💪',
          interestName: 'Academia',
          participantCount: 42,
          unreadCount: 12,
        ),
        GroupPreview(
          id: 'pets',
          icon: '🐶',
          interestName: 'Pets',
          participantCount: 18,
        ),
        GroupPreview(
          id: 'carros',
          icon: '🚗',
          interestName: 'Carros',
          participantCount: 9,
          unreadCount: 3,
        ),
        GroupPreview(
          id: 'corrida',
          icon: '🏃',
          interestName: 'Corrida',
          participantCount: 15,
        ),
        GroupPreview(
          id: 'musica',
          icon: '🎵',
          interestName: 'Música',
          participantCount: 27,
          unreadCount: 5,
        ),
        GroupPreview(
          id: 'games',
          icon: '🎮',
          interestName: 'Games',
          participantCount: 33,
        ),
      ],
    );
    notifyListeners();
  }
}
