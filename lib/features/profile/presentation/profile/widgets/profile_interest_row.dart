import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../profile_state.dart';

class ProfileInterestRow extends StatelessWidget {
  const ProfileInterestRow({
    super.key,
    required this.interest,
    required this.onRemove,
  });

  final ProfileInterest interest;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return DuniCard(
      padding: const EdgeInsets.symmetric(
        horizontal: DuniSpacing.md,
        vertical: DuniSpacing.xs,
      ),
      child: Row(
        children: [
          Text(interest.emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: DuniSpacing.sm),
          Expanded(
            child: Text(
              interest.label,
              style: DuniTypography.body.copyWith(
                color: DuniColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: DuniColors.pink),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
