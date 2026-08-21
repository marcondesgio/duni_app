import 'package:flutter/foundation.dart';

import 'checkin_state.dart';

/// ViewModel do cadastro de check-in.
///
/// Sem camada de dados ainda (`challenges/data`, `challenges/domain`
/// continuam vazios) — não persiste/envia nada, só valida localmente
/// (seção 32 da documentação) e devolve um [CheckinResult] para quem chamou
/// a tela.
class CheckinViewmodal extends ChangeNotifier {
  CheckinState _state = const CheckinState();
  CheckinState get state => _state;

  /// Placeholder: sem plugin de câmera/galeria integrado ainda — insere uma
  /// URL de exemplo (mesma convenção do `DuniAvatarPicker`/`DuniMediaPicker`).
  void pickPhoto() => _update(
    (s) => s.copyWith(
      photoUrl: 'https://picsum.photos/seed/duni-checkin-photo/600/400',
    ),
  );

  void removePhoto() => _update((s) => s.copyWith(clearPhoto: true));

  void updateDescription(String value) =>
      _update((s) => s.copyWith(description: value));

  CheckinResult? submit() {
    if (!_state.canSubmit) return null;
    return CheckinResult(
      photoUrl: _state.photoUrl!,
      description: _state.description.trim(),
    );
  }

  void _update(CheckinState Function(CheckinState) transform) {
    _state = transform(_state);
    notifyListeners();
  }
}
