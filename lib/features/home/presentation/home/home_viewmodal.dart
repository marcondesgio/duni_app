import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/foundation.dart';

import 'home_state.dart';

/// ViewModel da Home.
///
/// Sem camada de dados ainda (`home/data`, `home/domain` continuam vazios) —
/// [load] só simula uma busca e popula dados de exemplo.
class HomeViewmodal extends ChangeNotifier {
  HomeViewmodal() {
    load();
  }

  HomeState _state = const HomeState();
  HomeState get state => _state;

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 400));

    _state = HomeState(
      isLoading: false,
      userName: 'Ana',
      streakDays: 3,
      challenges: const [
        HomeChallengePreview(
          id: 'atividade-fisica',
          imageUrl: 'https://picsum.photos/seed/duni-home-challenge-1/600/338',
          name: '5 dias de atividade física',
          interestEmoji: '💪',
          interestLabel: 'Academia',
          periodLabel: '01/09 a 30/09',
          status: DuniChallengeStatus.ongoing,
          participantAvatarUrls: [
            'https://picsum.photos/seed/duni-home-avatar-1/200',
            'https://picsum.photos/seed/duni-home-avatar-2/200',
          ],
          participantCount: 24,
          checkinInfo: 'Check-in diário',
          currentDay: 4,
          totalDays: 5,
          myPosition: 3,
          myCheckins: 4,
        ),
        HomeChallengePreview(
          id: 'corrida-de-rua',
          imageUrl: 'https://picsum.photos/seed/duni-home-challenge-2/600/338',
          name: 'Corrida de rua',
          interestEmoji: '🏃',
          interestLabel: 'Corrida',
          periodLabel: '10/10 a 20/10',
          status: DuniChallengeStatus.upcoming,
          daysUntilStart: 5,
          participantAvatarUrls: [
            'https://picsum.photos/seed/duni-home-avatar-3/200',
          ],
          participantCount: 6,
          currentDay: 0,
          totalDays: 10,
          myPosition: 0,
          myCheckins: 0,
        ),
      ],
      groups: const [
        HomeGroupPreview(
          id: 'academia',
          icon: '💪',
          interestName: 'Academia',
          participantCount: 42,
          unreadCount: 12,
        ),
        HomeGroupPreview(
          id: 'pets',
          icon: '🐶',
          interestName: 'Pets',
          participantCount: 18,
        ),
        HomeGroupPreview(
          id: 'carros',
          icon: '🚗',
          interestName: 'Carros',
          participantCount: 9,
          unreadCount: 3,
        ),
      ],
    );
    notifyListeners();
  }

  void selectTab(HomeTab tab) {
    _state = _state.copyWith(selectedTab: tab);
    notifyListeners();
  }
}
