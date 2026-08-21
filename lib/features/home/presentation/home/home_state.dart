import 'package:duni_app/core/design_system/design_system.dart';

/// As duas funções centrais do app (seção 2 da documentação: "Conexão" via
/// grupos e desafios como forma de engajamento) — segregadas em tabs na Home.
enum HomeTab { groups, challenges }

/// Placeholder: modelo local só para popular [DuniChallengeCard] — mapeia
/// 1:1 os parâmetros do componente. Substituir por uma entidade real quando
/// a camada de dados da feature (`home/data`, `home/domain`) existir.
class HomeChallengePreview {
  const HomeChallengePreview({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.interestEmoji,
    required this.interestLabel,
    required this.periodLabel,
    required this.status,
    required this.participantAvatarUrls,
    required this.participantCount,
    required this.currentDay,
    required this.totalDays,
    required this.myPosition,
    required this.myCheckins,
    this.checkinInfo,
    this.daysUntilStart,
  });

  final String id;
  final String imageUrl;
  final String name;
  final String interestEmoji;
  final String interestLabel;
  final String periodLabel;
  final DuniChallengeStatus status;
  final List<String> participantAvatarUrls;
  final int participantCount;
  final String? checkinInfo;
  final int? daysUntilStart;

  /// Usados para montar o `ChallengeRef` ao abrir o chat/detalhes do
  /// desafio (feature `challenges`).
  final int currentDay;
  final int totalDays;
  final int myPosition;
  final int myCheckins;
}

/// Placeholder: modelo local só para popular [DuniGroupCard].
class HomeGroupPreview {
  const HomeGroupPreview({
    required this.id,
    required this.icon,
    required this.interestName,
    required this.participantCount,
    this.unreadCount = 0,
  });

  final String id;
  final String icon;
  final String interestName;
  final int participantCount;
  final int unreadCount;
}

class HomeState {
  const HomeState({
    this.isLoading = true,
    this.userName = '',
    this.streakDays = 0,
    this.challenges = const [],
    this.groups = const [],
    this.selectedTab = HomeTab.groups,
  });

  final bool isLoading;
  final String userName;
  final int streakDays;
  final List<HomeChallengePreview> challenges;
  final List<HomeGroupPreview> groups;
  final HomeTab selectedTab;

  HomeState copyWith({
    bool? isLoading,
    String? userName,
    int? streakDays,
    List<HomeChallengePreview>? challenges,
    List<HomeGroupPreview>? groups,
    HomeTab? selectedTab,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      userName: userName ?? this.userName,
      streakDays: streakDays ?? this.streakDays,
      challenges: challenges ?? this.challenges,
      groups: groups ?? this.groups,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}
