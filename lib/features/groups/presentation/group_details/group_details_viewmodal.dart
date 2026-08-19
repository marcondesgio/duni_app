import 'package:duni_app/features/groups/shared/shared.dart';
import 'package:flutter/foundation.dart';

import 'group_details_state.dart';

/// ViewModel dos Detalhes do Grupo.
///
/// Sem camada de dados ainda (`groups/data`, `groups/domain` continuam
/// vazios) — [load] popula participantes/mídias de exemplo (os mesmos para
/// qualquer grupo aberto — só o cabeçalho reflete o grupo real via
/// `GroupRef`). `mediaCount` usa o mesmo total de exemplo da tela de Mídias
/// (`kGroupSampleMediaCount`) para os números não ficarem inconsistentes
/// entre as duas telas.
class GroupDetailsViewmodal extends ChangeNotifier {
  GroupDetailsViewmodal() {
    load();
  }

  GroupDetailsState _state = const GroupDetailsState();
  GroupDetailsState get state => _state;

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    _state = GroupDetailsState(
      isLoading: false,
      mediaCount: kGroupSampleMediaCount,
      mediaPreviewUrls: buildSampleMediaUrls().take(4).toList(),
      participants: const [
        GroupParticipant(name: 'Gabi', role: 'Produto', isCurrentUser: true),
        GroupParticipant(name: 'Lucas M.', role: 'Engenharia'),
        GroupParticipant(name: 'Mariana C.', role: 'Design'),
        GroupParticipant(name: 'Pedro H.', role: 'Comercial'),
        GroupParticipant(name: 'Bia S.', role: 'Financeiro'),
      ],
    );
    notifyListeners();
  }
}
