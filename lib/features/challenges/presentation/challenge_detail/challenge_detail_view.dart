import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/challenges/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'challenge_detail_viewmodal.dart';
import 'widgets/widgets.dart';

class ChallengeDetailView extends StatefulWidget {
  const ChallengeDetailView({super.key, required this.challenge});

  final ChallengeRef challenge;

  @override
  State<ChallengeDetailView> createState() => _ChallengeDetailViewState();
}

class _ChallengeDetailViewState extends State<ChallengeDetailView> {
  static const _expandedHeaderHeight = 260.0;

  late final _viewModel = ChallengeDetailViewmodal(
    onParticipate: _handleParticipate,
  );

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _handleParticipate() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Você entrou no desafio! 🎉')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DuniColors.white,
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final state = _viewModel.state;

          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      backgroundColor: DuniColors.purple500,
                      expandedHeight: _expandedHeaderHeight,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: DuniColors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        stretchModes: [StretchMode.fadeTitle],
                        background: ChallengeDetailHeader(
                          challenge: widget.challenge,
                          subtitle: state.subtitle,
                          description: state.description,
                        ),
                      ),
                    ),
                    if (state.isLoading)
                      SliverFillRemaining(
                        child: Center(
                          child: LoadingAnimationWidget.progressiveDots(
                            color: DuniColors.purple200,
                            size: 32,
                          ),
                        ),
                      )
                    else
                      SliverToBoxAdapter(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(DuniRadius.large),
                          ),
                          child: ColoredBox(
                            color: DuniColors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(DuniSpacing.lg),
                              child: Column(
                                children: [
                                  if (state.first != null)
                                    DuniRankingPodium(
                                      scoreLabel: 'check-ins',
                                      first: DuniPodiumEntry(
                                        name: state.first!.name,
                                        score: state.first!.checkins,
                                        avatarUrl: state.first!.avatarUrl,
                                        isYourUser: state.first!.isYourUser,
                                      ),
                                      second: state.second == null
                                          ? null
                                          : DuniPodiumEntry(
                                              name: state.second!.name,
                                              score: state.second!.checkins,
                                              avatarUrl:
                                                  state.second!.avatarUrl,
                                              isYourUser:
                                                  state.second!.isYourUser,
                                            ),
                                      third: state.third == null
                                          ? null
                                          : DuniPodiumEntry(
                                              name: state.third!.name,
                                              score: state.third!.checkins,
                                              avatarUrl: state.third!.avatarUrl,
                                              isYourUser:
                                                  state.third!.isYourUser,
                                            ),
                                    ),
                                  if (state.others.isNotEmpty) ...[
                                    const SizedBox(height: DuniSpacing.lg),
                                    DuniCard(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: DuniSpacing.sm,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          for (
                                            var i = 0;
                                            i < state.others.length;
                                            i++
                                          ) ...[
                                            if (i > 0) const DuniDivider(),
                                            DuniRankingItem(
                                              position:
                                                  state.others[i].position,
                                              name: state.others[i].name,
                                              score: state.others[i].checkins,
                                              avatarUrl:
                                                  state.others[i].avatarUrl,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (!state.isLoading)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    DuniSpacing.lg,
                    DuniSpacing.xxs,
                    DuniSpacing.lg,
                    DuniSpacing.lg,
                  ),
                  child: Row(
                    spacing: DuniSpacing.xs,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DuniButton(
                        label: 'Ver check-ins',
                        variant: DuniButtonVariant.outline,
                        onPressed: () => Navigator.of(context).pop(),
                        expand: false,
                      ),
                      DuniButton(
                        label: 'Participar',
                        onPressed: _viewModel.participate,
                        expand: false,
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
