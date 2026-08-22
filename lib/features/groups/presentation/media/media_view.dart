import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/groups/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'media_viewmodal.dart';

class MediaView extends StatefulWidget {
  const MediaView({super.key, required this.group});

  final GroupRef group;

  @override
  State<MediaView> createState() => _MediaViewState();
}

class _MediaViewState extends State<MediaView> {
  late final _viewModel = MediaViewmodal();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DuniColors.background,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            final state = _viewModel.state;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    DuniSpacing.xxs,
                    DuniSpacing.xs,
                    DuniSpacing.md,
                    DuniSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: DuniColors.textPrimary,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Mídias · ${widget.group.interestName}',
                              style: DuniTypography.bodyLarge.copyWith(
                                color: DuniColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${state.mediaUrls.length} arquivos',
                              style: DuniTypography.caption.copyWith(
                                color: DuniColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _ModeToggleButton(
                        icon: Icons.grid_view_rounded,
                        selected: state.mode == DuniMediaGridMode.grid,
                        onTap: () =>
                            _viewModel.setMode(DuniMediaGridMode.grid),
                      ),
                      _ModeToggleButton(
                        icon: Icons.view_list_rounded,
                        selected: state.mode == DuniMediaGridMode.list,
                        onTap: () =>
                            _viewModel.setMode(DuniMediaGridMode.list),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: state.isLoading
                      ? Center(
                          child: LoadingAnimationWidget.progressiveDots(
                            color: DuniColors.purple200,
                            size: 32,
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(DuniSpacing.lg),
                          child: DuniMediaGrid(
                            items: state.mediaUrls,
                            mode: state.mode,
                          ),
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

class _ModeToggleButton extends StatelessWidget {
  const _ModeToggleButton({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: selected ? DuniColors.textPrimary : DuniColors.textTertiary,
      ),
      onPressed: onTap,
    );
  }
}
