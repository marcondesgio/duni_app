/// Identidade/exibição mínima de um grupo, passada como argumento de rota
/// entre Chat, Detalhes do Grupo e Mídias — essas telas ainda não têm uma
/// camada de dados real, então isso viaja via `Navigator` em vez de vir de
/// um repositório.
class GroupRef {
  const GroupRef({
    required this.id,
    required this.icon,
    required this.interestName,
    required this.participantCount,
  });

  final String id;
  final String icon;
  final String interestName;
  final int participantCount;
}
