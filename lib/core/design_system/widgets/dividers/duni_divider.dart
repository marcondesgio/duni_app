import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';

/// Divisor padrão do DUNI Design System.
class DuniDivider extends StatelessWidget {
  const DuniDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: DuniColors.gray200, thickness: 1, height: 1);
  }
}
