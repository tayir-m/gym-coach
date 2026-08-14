import 'package:flutter/material.dart';
import 'package:gym_coach/theme/colors.dart';
import 'router.dart';

class GymCoachApp extends StatelessWidget {
  const GymCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '健身猫头鹰',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.duoGreen),
        useMaterial3: true,
      ),
      routerConfig: buildRouter(),
    );
  }
}