import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'new_challenge_state.dart';
import 'new_challenge_viewmodal.dart';
import 'widgets/widgets.dart';

class NewChallengeView extends StatefulWidget {
  const NewChallengeView({super.key});

  @override
  State<NewChallengeView> createState() => _NewChallengeViewState();
}

class _NewChallengeViewState extends State<NewChallengeView> {
  late final _viewModel = NewChallengeViewmodal(onCreated: _handleCreated);
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _viewModel.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleCreated() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Desafio criado!')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DuniColors.white,
      appBar: AppBar(
        backgroundColor: DuniColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: DuniColors.purple500),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Novo desafio',
          style: DuniTypography.bodyLarge.copyWith(
            color: DuniColors.purple500,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListenableBuilder(
                listenable: _viewModel,
                builder: (context, _) {
                  final state = _viewModel.state;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(DuniSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: DuniSpacing.md,
                      children: [
                        DuniTextField(
                          label: 'Nome do desafio',
                          hintText: 'Ex.: 21 dias sem refrigerante',
                          controller: _nameController,
                          onChanged: _viewModel.updateName,
                        ),
                        _FieldGroup(
                          label: 'Interesse',
                          child: Wrap(
                            spacing: DuniSpacing.xs,
                            runSpacing: DuniSpacing.xs,
                            children: [
                              for (final interest in _viewModel.interests)
                                DuniInterestChip(
                                  emoji: interest.emoji,
                                  label: interest.label,
                                  selected:
                                      state.selectedInterestId == interest.id,
                                  onTap: () =>
                                      _viewModel.selectInterest(interest.id),
                                ),
                            ],
                          ),
                        ),
                        _FieldGroup(
                          label: 'Check-in',
                          child: DuniSegmentedControl<ChallengeCheckinFrequency>(
                            value: state.frequency,
                            segments: [
                              for (final frequency
                                  in ChallengeCheckinFrequency.values)
                                DuniSegment(
                                  value: frequency,
                                  label: frequency.label,
                                ),
                            ],
                            onChanged: _viewModel.selectFrequency,
                          ),
                        ),
                        NewChallengeLimitToggle(
                          enabled: state.limitParticipants,
                          maxParticipants: state.maxParticipants,
                          onChanged: _viewModel.toggleLimitParticipants,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: DuniSpacing.sm,
                          children: [
                            Expanded(
                              child: DuniDateField(
                                label: 'Início',
                                value: state.startDate,
                                onChanged: _viewModel.updateStartDate,
                              ),
                            ),
                            Expanded(
                              child: DuniDateField(
                                label: 'Fim',
                                value: state.endDate,
                                firstDate: state.startDate,
                                onChanged: _viewModel.updateEndDate,
                              ),
                            ),
                          ],
                        ),
                        _FieldGroup(
                          label: 'Imagem de capa',
                          child: DuniImageDropzone(
                            imageUrl: state.coverImageUrl,
                            onTap: _viewModel.pickCoverImage,
                            onRemove: state.coverImageUrl != null
                                ? _viewModel.removeCoverImage
                                : null,
                            icon: Icons.upload_outlined,
                            label: 'Enviar imagem',
                          ),
                        ),
                        _FieldGroup(
                          label: 'Descrição e regras',
                          child: DuniTextArea(
                            hintText:
                                'Conte as regras e o que vale como check-in...',
                            controller: _descriptionController,
                            onChanged: _viewModel.updateDescription,
                            minLines: 4,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ListenableBuilder(
              listenable: _viewModel,
              builder: (context, _) {
                final canSubmit = _viewModel.state.canSubmit;
                return Padding(
                  padding: const EdgeInsets.all(DuniSpacing.lg),
                  child: DuniButton(
                    label: 'Criar desafio',
                    state: canSubmit
                        ? DuniButtonState.enabled
                        : DuniButtonState.disabled,
                    onPressed: canSubmit ? _viewModel.submit : null,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldGroup extends StatelessWidget {
  const _FieldGroup({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: DuniSpacing.xs,
      children: [
        Text(
          label,
          style: DuniTypography.label.copyWith(color: DuniColors.purple500),
        ),
        child,
      ],
    );
  }
}
