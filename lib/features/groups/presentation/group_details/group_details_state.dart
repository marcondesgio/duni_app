/// Placeholder: modelo local de participante. Substituir por uma entidade
/// real quando a camada de dados da feature existir.
class GroupParticipant {
  const GroupParticipant({
    required this.name,
    required this.role,
    this.isCurrentUser = false,
  });

  final String name;
  final String role;
  final bool isCurrentUser;

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts[1][0]).toUpperCase();
  }
}

class GroupDetailsState {
  const GroupDetailsState({
    this.isLoading = true,
    this.mediaPreviewUrls = const [],
    this.mediaCount = 0,
    this.participants = const [],
  });

  final bool isLoading;
  final List<String> mediaPreviewUrls;
  final int mediaCount;
  final List<GroupParticipant> participants;

  GroupDetailsState copyWith({
    bool? isLoading,
    List<String>? mediaPreviewUrls,
    int? mediaCount,
    List<GroupParticipant>? participants,
  }) {
    return GroupDetailsState(
      isLoading: isLoading ?? this.isLoading,
      mediaPreviewUrls: mediaPreviewUrls ?? this.mediaPreviewUrls,
      mediaCount: mediaCount ?? this.mediaCount,
      participants: participants ?? this.participants,
    );
  }
}
