import 'package:flutter/foundation.dart';

import 'challenge_detail_state.dart';

/// ViewModel dos Detalhes/Ranking do desafio.
///
/// Sem camada de dados ainda (`challenges/data`, `challenges/domain`
/// continuam vazios) — [load] popula um ranking de exemplo (o mesmo para
/// qualquer desafio aberto — só o cabeçalho reflete o desafio real via
/// `ChallengeRef`). [participate] é um placeholder inerte (sem estado real
/// de participação ainda).
class ChallengeDetailViewmodal extends ChangeNotifier {
  ChallengeDetailViewmodal({this.onParticipate}) {
    load();
  }

  final VoidCallback? onParticipate;

  ChallengeDetailState _state = const ChallengeDetailState();
  ChallengeDetailState get state => _state;

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    _state = ChallengeDetailState(
      isLoading: false,
      subtitle: 'Check-in diário · 08 – 12 mai · 12 de 20 vagas',
      description:
          'Qualquer atividade de 20 min conta: caminhada, academia, dança. '
          'Foto ou print do relógio como comprovação.',
      first: const ChallengeRankingEntry(
        position: 1,
        name: 'Lucas M.',
        checkins: 5,
        avatarUrl: 'https://picsum.photos/seed/duni-challenge-lucas/200',
      ),
      second: const ChallengeRankingEntry(
        position: 2,
        name: 'Mariana C.',
        checkins: 4,
        avatarUrl: 'https://picsum.photos/seed/duni-challenge-mariana/200',
      ),
      third: const ChallengeRankingEntry(
        position: 3,
        name: 'Gabi · você',
        checkins: 4,
        isYourUser: true,
      ),
      others: const [
        ChallengeRankingEntry(
          position: 4,
          name: 'Pedro H.',
          checkins: 3,
          avatarUrl: 'https://picsum.photos/seed/duni-challenge-pedro/200',
        ),
        ChallengeRankingEntry(
          position: 5,
          name: 'Bia S.',
          checkins: 3,
          avatarUrl: 'https://picsum.photos/seed/duni-challenge-bia/200',
        ),
        ChallengeRankingEntry(
          position: 6,
          name: 'Rafa T.',
          checkins: 2,
          avatarUrl: 'https://picsum.photos/seed/duni-challenge-rafa/200',
        ),
      ],
    );
    notifyListeners();
  }

  void participate() => onParticipate?.call();
}
