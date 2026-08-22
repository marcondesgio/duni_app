import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../shared/shared.dart';
import 'groups_state.dart';
import 'groups_viewmodal.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  late final _viewModel = GroupsViewmodal();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _openChat(GroupPreview group) {
    Navigator.of(context).pushNamed(
      GroupsRouter.chatPage,
      arguments: GroupRef(
        id: group.id,
        icon: group.icon,
        interestName: group.interestName,
        participantCount: group.participantCount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DuniColors.background,
      appBar: AppBar(
        backgroundColor: DuniColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: DuniColors.textPrimary),
        title: Text(
          'Grupos',
          style: DuniTypography.heading3.copyWith(
            color: DuniColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            final state = _viewModel.state;

            if (state.isLoading) {
              return Center(
                child: LoadingAnimationWidget.progressiveDots(
                  color: DuniColors.purple200,
                  size: 32,
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(DuniSpacing.lg),
              itemCount: state.groups.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: DuniSpacing.sm),
              itemBuilder: (context, index) {
                final group = state.groups[index];
                return DuniGroupCard(
                  icon: group.icon,
                  interestName: group.interestName,
                  participantCount: group.participantCount,
                  unreadCount: group.unreadCount,
                  onTap: () => _openChat(group),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
