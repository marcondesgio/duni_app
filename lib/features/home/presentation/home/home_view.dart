import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/challenges/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'home_state.dart';
import 'home_viewmodal.dart';
import 'widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final _viewModel = HomeViewmodal();

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
                HomeHeader(userName: state.userName),
                const SizedBox(height: DuniSpacing.lg),
                HomeTabBar<HomeTab>(
                  value: state.selectedTab,
                  segments: const [
                    DuniSegment(value: HomeTab.groups, label: 'Grupos'),
                    DuniSegment(value: HomeTab.challenges, label: 'Desafios'),
                  ],
                  onChanged: _viewModel.selectTab,
                ),
                const SizedBox(height: DuniSpacing.lg),
                switch (state.selectedTab) {
                  HomeTab.groups => HomeGroupsSection(groups: state.groups),
                  HomeTab.challenges => HomeChallengesSection(
                    challenges: state.challenges,
                  ),
                },
              ],
            );
          },
        ),
      ),
      floatingActionButton: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final state = _viewModel.state;

          return (state.selectedTab == HomeTab.challenges)
              ? DuniButton(
                  label: 'Criar desafio',
                  onPressed: () => Navigator.of(
                    context,
                  ).pushNamed(ChallengesRouter.newChallengePage),
                  leadingIcon: Icons.add,
                  expand: false,
                )
              : const SizedBox();
        },
      ),
    );
  }
}
