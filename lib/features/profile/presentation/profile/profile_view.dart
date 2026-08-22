import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'profile_viewmodal.dart';
import 'widgets/widgets.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  static const _expandedHeaderHeight = 320.0;

  late final _viewModel = ProfileViewmodal();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _handleNotifications() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Notificações — em breve.')));
  }

  Future<void> _handleDeleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir conta'),
        content: const Text(
          'Essa ação não pode ser desfeita. Tem certeza que deseja excluir '
          'sua conta?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text('Excluir', style: TextStyle(color: DuniColors.error)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conta seria excluída aqui — sem backend ainda.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DuniColors.background,
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final state = _viewModel.state;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                backgroundColor: DuniColors.purple200,
                expandedHeight: _expandedHeaderHeight,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: DuniColors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.fadeTitle],
                  background: ProfileHeader(
                    name: state.name,
                    email: state.email,
                    company: state.company,
                    avatarUrl: state.avatarUrl,
                    onEditAvatar: _viewModel.updateAvatar,
                    interestsCount: state.interestsCount,
                    challengesCount: state.challengesCount,
                    checkinsCount: state.checkinsCount,
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
                      color: DuniColors.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(DuniSpacing.lg),
                        child: Column(
                          children: [
                            ProfileSettingsSection(
                              onNotifications: _handleNotifications,
                              onDeleteAccount: _handleDeleteAccount,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
