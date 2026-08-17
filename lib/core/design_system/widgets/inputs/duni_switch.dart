import 'package:flutter/material.dart';

import '../../colors/duni_colors.dart';

/// Switch do DUNI Design System — usado, por exemplo, para ativar/desativar
/// o limite de participantes na criação de desafios (seção 31 da doc).
class DuniSwitch extends StatelessWidget {
  const DuniSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: DuniColors.purple200,
      inactiveTrackColor: DuniColors.gray100,
      thumbColor: const WidgetStatePropertyAll(DuniColors.white),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
    );
  }
}
