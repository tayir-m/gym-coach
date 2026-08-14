import 'package:flutter/material.dart';

class GymCoachApp extends StatelessWidget {
  const GymCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '健身猫头鹰',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF58CC02)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('Gym Coach MVP')),
      ),
    );
  }
}