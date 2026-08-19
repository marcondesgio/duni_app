import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/groups/shared/shared.dart';
import 'package:flutter/foundation.dart';

import 'media_state.dart';

/// ViewModel da tela de Mídias do grupo.
///
/// Sem camada de dados ainda (`groups/data`, `groups/domain` continuam
/// vazios) — [load] popula a mesma lista de exemplo usada na prévia dos
/// Detalhes do Grupo (`buildSampleMediaUrls`).
class MediaViewmodal extends ChangeNotifier {
  MediaViewmodal() {
    load();
  }

  MediaState _state = const MediaState();
  MediaState get state => _state;

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    _state = _state.copyWith(
      isLoading: false,
      mediaUrls: buildSampleMediaUrls(),
    );
    notifyListeners();
  }

  void setMode(DuniMediaGridMode mode) {
    _state = _state.copyWith(mode: mode);
    notifyListeners();
  }
}
