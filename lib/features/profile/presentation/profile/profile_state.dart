/// Placeholder: modelo local de interesse do perfil. Substituir por uma
/// entidade real quando a camada de dados da feature existir.
class ProfileInterest {
  const ProfileInterest({
    required this.id,
    required this.emoji,
    required this.label,
  });

  final String id;
  final String emoji;
  final String label;
}

class ProfileState {
  const ProfileState({
    this.isLoading = true,
    this.name = '',
    this.email = '',
    this.company = '',
    this.avatarUrl,
    this.interests = const [],
    this.challengesCount = 0,
    this.checkinsCount = 0,
  });

  final bool isLoading;
  final String name;
  final String email;
  final String company;
  final String? avatarUrl;
  final List<ProfileInterest> interests;
  final int challengesCount;
  final int checkinsCount;

  int get interestsCount => interests.length;

  ProfileState copyWith({
    bool? isLoading,
    String? name,
    String? email,
    String? company,
    String? avatarUrl,
    List<ProfileInterest>? interests,
    int? challengesCount,
    int? checkinsCount,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      email: email ?? this.email,
      company: company ?? this.company,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      interests: interests ?? this.interests,
      challengesCount: challengesCount ?? this.challengesCount,
      checkinsCount: checkinsCount ?? this.checkinsCount,
    );
  }
}
