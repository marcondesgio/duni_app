import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/groups/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'group_details_viewmodal.dart';
import 'widgets/widgets.dart';

class GroupDetailsView extends StatefulWidget {
  const GroupDetailsView({super.key, required this.group});

  final GroupRef group;

  @override
  State<GroupDetailsView> createState() => _GroupDetailsViewState();
}

class _GroupDetailsViewState extends State<GroupDetailsView> {
  late final _viewModel = GroupDetailsViewmodal();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _openMedia() {
    Navigator.of(
      context,
    ).pushNamed(GroupsRouter.mediaPage, arguments: widget.group);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DuniColors.background,
      body: Column(
        children: [
          GroupDetailsHeader(group: widget.group),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(DuniRadius.large),
              ),
              child: ColoredBox(
                color: DuniColors.surface,
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

                    return ListView(
                      padding: const EdgeInsets.all(DuniSpacing.lg),
                      children: [
                        GroupDetailsMediaPreview(
                          previewUrls: state.mediaPreviewUrls,
                          mediaCount: state.mediaCount,
                          onViewAll: _openMedia,
                        ),
                        const SizedBox(height: DuniSpacing.lg),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: DuniSpacing.md,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Participantes',
                                style: DuniTypography.bodyLarge.copyWith(
                                  color: DuniColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${state.participants.length}',
                                style: DuniTypography.bodySmall.copyWith(
                                  color: DuniColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        for (final participant in state.participants)
                          GroupDetailsParticipantTile(participant: participant),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
