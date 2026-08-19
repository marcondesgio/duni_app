import 'package:duni_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

class HomeStreakSection extends StatelessWidget {
  const HomeStreakSection({super.key, required this.streakDays});

  final int streakDays;

  @override
  Widget build(BuildContext context) {
    return DuniStreakCard(days: streakDays);
  }
}
