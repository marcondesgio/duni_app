/// Placeholder: modelo local só para popular [DuniGroupCard]. Substituir por
/// uma entidade real quando a camada de dados da feature existir.
class GroupPreview {
  const GroupPreview({
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

class GroupsState {
  const GroupsState({this.isLoading = true, this.groups = const []});

  final bool isLoading;
  final List<GroupPreview> groups;

  GroupsState copyWith({bool? isLoading, List<GroupPreview>? groups}) {
    return GroupsState(
      isLoading: isLoading ?? this.isLoading,
      groups: groups ?? this.groups,
    );
  }
}
