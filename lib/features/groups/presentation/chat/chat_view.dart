import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/groups/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'chat_state.dart';
import 'chat_viewmodal.dart';
import 'widgets/widgets.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.group});

  final GroupRef group;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final _viewModel = ChatViewmodal();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _openDetails() {
    Navigator.of(
      context,
    ).pushNamed(GroupsRouter.detailsPage, arguments: widget.group);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DuniColors.white,
      appBar: ChatAppBar(group: widget.group, onTap: _openDetails),
      body: SafeArea(
        top: false,
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            final state = _viewModel.state;

            return Column(
              children: [
                Expanded(
                  child: state.isLoading
                      ? Center(
                          child: LoadingAnimationWidget.progressiveDots(
                            color: DuniColors.purple200,
                            size: 32,
                          ),
                        )
                      : ListView(
                          padding: const EdgeInsets.all(DuniSpacing.lg),
                          children: [
                            Center(
                              child: Text(
                                'HOJE',
                                style: DuniTypography.caption.copyWith(
                                  color: DuniColors.purpleGray50,
                                ),
                              ),
                            ),
                            const SizedBox(height: DuniSpacing.sm),
                            for (var i = 0; i < state.messages.length; i++) ...[
                              if (i > 0) const SizedBox(height: DuniSpacing.sm),
                              _MessageBubble(item: state.messages[i]),
                            ],
                          ],
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    DuniSpacing.md,
                    DuniSpacing.xs,
                    DuniSpacing.md,
                    DuniSpacing.sm,
                  ),
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

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.item});

  final ChatMessageItem item;

  @override
  Widget build(BuildContext context) {
    return DuniChatBubble(
      type: item.type,
      authorName: item.authorName,
      avatarInitials: item.avatarInitials,
      time: item.time,
      isMine: item.isMine,
      message: item.message,
      imageUrl: item.imageUrl,
      imageDescription: item.imageDescription,
      reaction: item.reaction,
    );
  }
}
