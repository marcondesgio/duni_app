import 'package:flutter/material.dart';

import 'design_system.dart';

/// Vitrine de todos os componentes do DUNI Design System implementados até
/// agora — não é uma tela do produto, é um catálogo para inspeção visual.
class DuniDesignSystemShowcase extends StatefulWidget {
  const DuniDesignSystemShowcase({super.key});

  @override
  State<DuniDesignSystemShowcase> createState() =>
      _DuniDesignSystemShowcaseState();
}

enum _Frequency { daily, weekly, free }

class _DuniDesignSystemShowcaseState extends State<DuniDesignSystemShowcase> {
  final _textController = TextEditingController();
  final _textAreaController = TextEditingController();

  bool _switchValue = true;
  _Frequency _frequency = _Frequency.daily;
  DateTime? _date;
  bool _interestSelected = true;
  bool _chipSelected = false;
  final DuniMediaGridMode _mediaGridMode = DuniMediaGridMode.grid;
  final _mediaPickerImages = <String>[
    'https://picsum.photos/seed/duni-picker-1/200',
  ];

  static const _avatar1 = 'https://picsum.photos/seed/duni-avatar-1/200';
  static const _avatar2 = 'https://picsum.photos/seed/duni-avatar-2/200';
  static const _avatar3 = 'https://picsum.photos/seed/duni-avatar-3/200';
  static const _challengeImage =
      'https://picsum.photos/seed/duni-challenge/600/338';
  static const _checkinPhoto =
      'https://picsum.photos/seed/duni-checkin/600/400';
  static const _chatImage = 'https://picsum.photos/seed/duni-chat/400';

  @override
  void dispose() {
    _textController.dispose();
    _textAreaController.dispose();
    super.dispose();
  }

  void _addMediaPickerImage() {
    setState(() {
      _mediaPickerImages.add(
        'https://picsum.photos/seed/duni-picker-${_mediaPickerImages.length + 1}/200',
      );
    });
  }

  void _removeMediaPickerImage(int index) {
    setState(() => _mediaPickerImages.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DUNI Design System'),
        backgroundColor: DuniColors.white,
        foregroundColor: DuniColors.purple500,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(DuniSpacing.md),
        children: [
          _Section(
            title: 'Botões',
            children: [
              const DuniButton(
                label: 'Primary',
                onPressed: null,
                expand: false,
              ),
              const SizedBox(height: DuniSpacing.xs),
              const DuniButton(
                label: 'Text',
                variant: DuniButtonVariant.text,
                onPressed: null,
                expand: false,
              ),
              const SizedBox(height: DuniSpacing.xs),
              const DuniButton(
                label: 'Disabled',
                state: DuniButtonState.disabled,
                onPressed: null,
                expand: false,
              ),
              const SizedBox(height: DuniSpacing.xs),
              const DuniButton(
                label: 'Loading',
                state: DuniButtonState.loading,
                onPressed: null,
                expand: false,
              ),
              const SizedBox(height: DuniSpacing.sm),
              Row(
                children: const [
                  DuniIconButton(icon: Icons.favorite_border, onPressed: null),
                  SizedBox(width: DuniSpacing.sm),
                  DuniIconButton(
                    icon: Icons.favorite_border,
                    onPressed: null,
                    state: DuniIconButtonState.disabled,
                  ),
                  SizedBox(width: DuniSpacing.sm),
                  DuniIconButton(
                    icon: Icons.add,
                    variant: DuniIconButtonVariant.secundary,
                    onPressed: null,
                  ),
                  SizedBox(width: DuniSpacing.sm),
                  DuniIconButton(
                    icon: Icons.add,
                    variant: DuniIconButtonVariant.secundary,
                    state: DuniIconButtonState.disabled,
                    onPressed: null,
                  ),
                ],
              ),
            ],
          ),
          _Section(
            title: 'Inputs',
            children: [
              DuniTextField(
                label: 'E-mail corporativo',
                hintText: 'email@empresa.com',
                controller: _textController,
              ),
              const SizedBox(height: DuniSpacing.sm),
              const DuniTextField(
                label: 'Com erro',
                hintText: 'Campo obrigatório',
                errorText: 'Preencha este campo',
              ),
              const SizedBox(height: DuniSpacing.sm),
              const DuniTextField(
                label: 'Desabilitado',
                enabled: false,
                hintText: '—',
              ),
              const SizedBox(height: DuniSpacing.sm),
              DuniTextArea(
                label: 'Descrição/regras',
                hintText: 'Conte mais sobre o desafio...',
                controller: _textAreaController,
              ),
              const SizedBox(height: DuniSpacing.sm),
              DuniDateField(
                label: 'Data inicial',
                value: _date,
                onChanged: (value) => setState(() => _date = value),
              ),
              const SizedBox(height: DuniSpacing.sm),
              Row(
                children: [
                  DuniSwitch(
                    value: _switchValue,
                    onChanged: (value) => setState(() => _switchValue = value),
                  ),
                  const SizedBox(width: DuniSpacing.xs),
                  Text('Limitar participantes', style: DuniTypography.body),
                ],
              ),
              const SizedBox(height: DuniSpacing.sm),
              DuniSegmentedControl<_Frequency>(
                value: _frequency,
                segments: const [
                  DuniSegment(value: _Frequency.daily, label: 'Diário'),
                  DuniSegment(value: _Frequency.weekly, label: 'Semanal'),
                  DuniSegment(value: _Frequency.free, label: 'Livre'),
                ],
                onChanged: (value) => setState(() => _frequency = value),
              ),
            ],
          ),
          _Section(
            title: 'Avatares',
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final size in DuniAvatarSize.values) ...[
                    Column(
                      children: [DuniAvatar(imageUrl: _avatar1, size: size)],
                    ),
                    const SizedBox(width: DuniSpacing.sm),
                  ],
                ],
              ),
              const SizedBox(height: DuniSpacing.xl),
              DuniAvatar(initials: 'GM'),
            ],
          ),
          _Section(
            title: 'Chips',
            children: [
              Wrap(
                spacing: DuniSpacing.xs,
                runSpacing: DuniSpacing.xs,
                children: [
                  DuniChip(
                    label: 'Chip',
                    selected: _chipSelected,
                    onTap: () => setState(() => _chipSelected = !_chipSelected),
                  ),
                  const DuniInterestChip(emoji: '💪', label: 'Academia'),
                  const DuniInterestChip(
                    emoji: '🐶',
                    label: 'Pets',
                    selected: true,
                  ),
                  const DuniInterestChip(emoji: '🚗', label: 'Carros'),
                ],
              ),
            ],
          ),
          _Section(
            title: 'Badge',
            children: [
              Row(
                children: const [
                  DuniBadge(count: 3),
                  SizedBox(width: DuniSpacing.sm),
                  DuniBadge(count: 128),
                ],
              ),
            ],
          ),
          _Section(title: 'Divider', children: const [DuniDivider()]),
          _Section(
            title: 'Cards',
            children: [
              const DuniCard(child: Text('DuniCard base')),
              const SizedBox(height: DuniSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: DuniInterestCard(
                      icon: '💪',
                      label: 'Academia',
                      selected: _interestSelected,
                      onTap: () => setState(
                        () => _interestSelected = !_interestSelected,
                      ),
                    ),
                  ),
                  const SizedBox(width: DuniSpacing.sm),
                  const Expanded(
                    child: DuniInterestCard(
                      icon: '🐶',
                      label: 'Pets',
                      selected: false,
                      enabled: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: DuniSpacing.sm),
              const DuniGroupCard(
                icon: '💪',
                interestName: 'Academia',
                participantCount: 42,
                unreadCount: 12,
              ),
              const SizedBox(height: DuniSpacing.sm),
              const DuniStreakCard(days: 3),
            ],
          ),
          _Section(
            title: 'Desafios',
            children: const [
              DuniChallengeCard(
                imageUrl: _challengeImage,
                name: 'Desafio 10k passos',
                interestEmoji: '💪',
                interestLabel: 'Academia',
                periodLabel: '01/09 a 30/09',
                status: DuniChallengeStatus.ongoing,
                participantAvatarUrls: [_avatar1, _avatar2, _avatar3],
                participantCount: 24,
                checkinInfo: 'Check-in diário',
              ),
              SizedBox(height: DuniSpacing.sm),
              DuniChallengeCard(
                imageUrl: _challengeImage,
                name: 'Corrida de rua',
                interestEmoji: '🏃',
                interestLabel: 'Corrida',
                periodLabel: '10/10 a 20/10',
                status: DuniChallengeStatus.upcoming,
                daysUntilStart: 5,
                participantAvatarUrls: [_avatar2],
                participantCount: 6,
              ),
            ],
          ),
          _Section(
            title: 'Chat',
            children: [
              DuniChatBubble(
                type: DuniChatMessageType.text,
                authorName: 'Marina',
                time: '09:14',
                isMine: false,
                avatarUrl: _avatar2,
                message: 'Bom dia! Alguém topa treinar hoje às 18h?',
              ),
              const SizedBox(height: DuniSpacing.xs),
              const DuniChatBubble(
                type: DuniChatMessageType.text,
                authorName: 'Você',
                time: '09:16',
                isMine: true,
                message: 'Eu topo! 💪',
                reaction: '🔥',
              ),
              const SizedBox(height: DuniSpacing.xs),
              DuniChatBubble(
                type: DuniChatMessageType.image,
                authorName: 'Marina',
                time: '09:20',
                isMine: false,
                avatarUrl: _avatar2,
                imageUrl: _chatImage,
                imageDescription: 'Check da academia de hoje',
              ),
              const SizedBox(height: DuniSpacing.sm),
              DuniMediaMessage(
                imageUrl: _chatImage,
                description: 'DuniMediaMessage isolado',
              ),
              const SizedBox(height: DuniSpacing.sm),
              const DuniCheckinCard(
                userName: 'Marina Souza',
                photoUrl: _checkinPhoto,
                description: 'Treino de pernas finalizado! 🔥',
                dateTimeLabel: 'Hoje às 09:20',
                avatarUrl: _avatar2,
              ),
            ],
          ),
          _Section(
            title: 'Ranking',
            children: [
              const DuniRankingPodium(
                first: DuniPodiumEntry(
                  name: 'Marina',
                  score: 320,
                  avatarUrl: _avatar1,
                ),
                second: DuniPodiumEntry(
                  name: 'João',
                  score: 280,
                  avatarUrl: _avatar2,
                ),
                third: DuniPodiumEntry(
                  name: 'Ana',
                  score: 250,
                  avatarUrl: _avatar3,
                ),
              ),
              const SizedBox(height: DuniSpacing.sm),
              const DuniDivider(),
              const DuniRankingItem(
                position: 4,
                name: 'Pedro',
                score: 210,
                avatarUrl: _avatar1,
              ),
              const DuniRankingItem(
                position: 5,
                name: 'Carla',
                score: 190,
                avatarUrl: _avatar2,
              ),
              const DuniRankingItem(
                position: 6,
                name: 'Lucas',
                score: 175,
                avatarUrl: _avatar3,
              ),
            ],
          ),
          _Section(
            title: 'Mídia',
            children: [
              // Row(
              //   children: [
              //     Text('Modo:', style: DuniTypography.label),
              //     const SizedBox(width: DuniSpacing.xs),
              //     DuniSegmentedControl<DuniMediaGridMode>(
              //       value: _mediaGridMode,
              //       segments: const [
              //         DuniSegment(value: DuniMediaGridMode.grid, label: 'Grid'),
              //         DuniSegment(
              //           value: DuniMediaGridMode.list,
              //           label: 'Lista',
              //         ),
              //       ],
              //       onChanged: (value) =>
              //           setState(() => _mediaGridMode = value),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: DuniSpacing.sm),
              DuniMediaGrid(
                mode: _mediaGridMode,
                items: [
                  _avatar1,
                  _avatar2,
                  _avatar3,
                  _chatImage,
                  _checkinPhoto,
                ],
              ),
              const SizedBox(height: DuniSpacing.md),
              Text('DuniMediaPicker', style: DuniTypography.label),
              const SizedBox(height: DuniSpacing.xs),
              DuniMediaPicker(
                imageUrls: _mediaPickerImages,
                onAdd: _addMediaPickerImage,
                onRemove: _removeMediaPickerImage,
              ),
            ],
          ),
          _Section(
            title: 'Onboarding',
            children: const [
              DuniOnboardingProgress(currentStep: 1, totalSteps: 3),
              SizedBox(height: DuniSpacing.sm),
              DuniOnboardingProgress(currentStep: 2, totalSteps: 3),
              SizedBox(height: DuniSpacing.sm),
              DuniOnboardingProgress(currentStep: 3, totalSteps: 3),
            ],
          ),
          const SizedBox(height: DuniSpacing.xl),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DuniSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: DuniTypography.heading2.copyWith(
              color: DuniColors.purple500,
            ),
          ),
          const SizedBox(height: DuniSpacing.sm),
          ...children,
        ],
      ),
    );
  }
}
