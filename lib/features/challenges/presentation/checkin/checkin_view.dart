import 'package:duni_app/core/design_system/design_system.dart';
import 'package:duni_app/features/challenges/shared/shared.dart';
import 'package:flutter/material.dart';

import 'checkin_viewmodal.dart';

class CheckinView extends StatefulWidget {
  const CheckinView({super.key, required this.challenge});

  final ChallengeRef challenge;

  @override
  State<CheckinView> createState() => _CheckinViewState();
}

class _CheckinViewState extends State<CheckinView> {
  late final _viewModel = CheckinViewmodal();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _viewModel.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    final result = _viewModel.submit();
    if (result != null) Navigator.of(context).pop(result);
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
          'Check-in · dia ${widget.challenge.currentDay}',
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
                        _RequiredLabel('Comprovação'),
                        DuniImageDropzone(
                          imageUrl: state.photoUrl,
                          onTap: _viewModel.pickPhoto,
                          onRemove: state.photoUrl != null
                              ? _viewModel.removePhoto
                              : null,
                          icon: Icons.camera_alt_outlined,
                          actionLabels: const ['Tirar foto', 'Da galeria'],
                          caption: 'Obrigatório para contabilizar',
                          backgroundColor: DuniColors.purple50,
                          height: 220,
                        ),
                        _RequiredLabel('Descrição'),
                        DuniTextArea(
                          hintText: 'Conta pros colegas o que você fez hoje...',
                          controller: _descriptionController,
                          onChanged: _viewModel.updateDescription,
                          minLines: 4,
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
                    label: 'Enviar check-in',
                    state: canSubmit
                        ? DuniButtonState.enabled
                        : DuniButtonState.disabled,
                    onPressed: canSubmit ? _submit : null,
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

class _RequiredLabel extends StatelessWidget {
  const _RequiredLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: label,
        style: DuniTypography.label.copyWith(color: DuniColors.purple500),
        children: [
          TextSpan(
            text: ' *',
            style: DuniTypography.label.copyWith(color: DuniColors.error),
          ),
        ],
      ),
    );
  }
}
