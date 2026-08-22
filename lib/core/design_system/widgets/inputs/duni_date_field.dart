import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';
import '../../radius/duni_radius.dart';
import '../../spacing/duni_spacing.dart';
import '../../typography/duni_typography.dart';

/// Campo de seleção de data do DUNI Design System — usado em criação de
/// desafios (data inicial / data final, seção 29 da documentação).
class DuniDateField extends StatelessWidget {
  const DuniDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.hintText = 'Selecionar data',
    this.firstDate,
    this.lastDate,
    this.enabled = true,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final String hintText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: DuniTypography.label.copyWith(
            color: DuniColors.textPrimary,
          ),
        ),
        const SizedBox(height: DuniSpacing.xxs),
        InkWell(
          borderRadius: BorderRadius.circular(DuniRadius.medium),
          onTap: enabled ? () => _pickDate(context) : null,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: DuniSpacing.md,
              vertical: DuniSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: enabled ? DuniColors.surface : DuniColors.gray50,
              borderRadius: BorderRadius.circular(DuniRadius.medium),
              border: Border.all(color: DuniColors.gray200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value != null ? _format(value!) : hintText,
                    style: DuniTypography.body.copyWith(
                      color: value != null
                          ? DuniColors.textPrimary
                          : DuniColors.textPrimary.withAlpha(120),
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: DuniColors.textPrimary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: firstDate ?? DateTime(now.year - 1),
      lastDate: lastDate ?? DateTime(now.year + 5),
    );
    if (picked != null) onChanged(picked);
  }

  String _format(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}
