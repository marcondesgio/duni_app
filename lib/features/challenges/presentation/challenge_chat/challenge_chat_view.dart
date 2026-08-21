import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/challenges/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../checkin/checkin_state.dart';
import '../checkin/checkin_view.dart';
import 'challenge_chat_state.dart';
import 'challenge_chat_viewmodal.dart';
import 'widgets/widgets.dart';

class ChallengeChatView extends StatefulWidget {
  const ChallengeChatView({super.key, required this.challenge});

  final ChallengeRef challenge;

  @override
  State<ChallengeChatView> createState() => _ChallengeChatViewState();
}

class _ChallengeChatViewState extends State<ChallengeChatView> {
  late final _viewModel = ChallengeChatViewmodal();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _openDetails() {
    Navigator.of(
      context,
    ).pushNamed(ChallengesRouter.detailPage, arguments: widget.challenge);
  }

  Future<void> _openCheckin() async {
    final result = await Navigator.of(context).push<CheckinResult>(
      MaterialPageRoute(
        builder: (_) => CheckinView(challenge: widget.challenge),
      ),
    );
    if (result != null) {
      _viewModel.addCheckin(
        photoUrl: result.photoUrl,
        description: result.description,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DuniColors.white,
      appBar: ChallengeChatAppBar(
        challenge: widget.challenge,
        onTap: _openDetails,
        onCheckin: _openCheckin,
      ),
      body: SafeArea(
        top: false,
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            final state = _viewModel.state;

            return Stack(
              children: [
                Positioned.fill(
                  child: state.isLoading
                      ? Center(
                          child: LoadingAnimationWidget.progressiveDots(
                            color: DuniColors.purple200,
                            size: 32,
                          ),
                        )
                      : ListView(
                          padding: const EdgeInsets.fromLTRB(
                            DuniSpacing.lg,
                            DuniSpacing.lg,
                            DuniSpacing.lg,
                            96,
                          ),
                          children: [
                            Center(
                              child: Text(
                                'DIA ${widget.challenge.currentDay} DE ${widget.challenge.totalDays}',
                                style: DuniTypography.caption.copyWith(
                                  color: DuniColors.purpleGray50,
                                ),
                              ),
                            ),
                            const SizedBox(height: DuniSpacing.sm),
                            for (
                              var i = 0;
                              i < state.messages.length;
                              i++
                            ) ...[
                              if (i > 0) const SizedBox(height: DuniSpacing.sm),
                              _MessageItem(item: state.messages[i]),
                            ],
                            if (state.showCheckinReminder) ...[
                              const SizedBox(height: DuniSpacing.sm),
                              const DuniBanner(
                                icon: '⏰',
                                type: BannerType.warning,
                                text:
                                    'Seu check-in de hoje ainda não foi feito. Faltam 6 horas.',
                              ),
                            ],
                          ],
                        ),
                ),
                Positioned(
                  left: DuniSpacing.md,
                  right: DuniSpacing.md,
                  bottom: DuniSpacing.md,
                  child: DuniChatComposer(
                    onSend: _viewModel.sendMessage,
                    onAttach: _viewModel.sendSamplePhoto,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MessageItem extends StatelessWidget {
  const _MessageItem({required this.item});

  final ChallengeChatMessageItem item;

  @override
  Widget build(BuildContext context) {
    if (item.kind == ChallengeChatMessageKind.checkin) {
      final card = DuniCheckinCard(
        userName: item.authorName,
        photoUrl: item.imageUrl!,
        description: item.checkinDescription!,
        time: item.time,
      );

      if (item.isMine) return card;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DuniAvatar(initials: item.avatarInitials, size: DuniAvatarSize.xs),
          const SizedBox(width: DuniSpacing.xs),
          Expanded(child: card),
        ],
      );
    }

    return DuniChatBubble(
      type: item.kind.toBubbleType!,
      authorName: item.authorName,
      avatarInitials: item.avatarInitials,
      time: item.time,
      isMine: item.isMine,
      message: item.message,
      imageUrl: item.imageUrl,
      imageDescription: item.imageDescription,
    );
  }
}
