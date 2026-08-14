import 'package:flutter/material.dart';
import 'colors.dart';

/// Lottie 占位：先用 emoji + 圆形背景。
/// 后期替换为真实 Lottie JSON 文件 `assets/mascot.json`。
class AppMascot extends StatelessWidget {
  final String mood; // happy / cheer / sad
  final double size;

  const AppMascot({super.key, this.mood = 'happy', this.size = 80});

  @override
  Widget build(BuildContext context) {
    final emoji = switch (mood) {
      'cheer' => '🦉',
      'sad' => '🦉💧',
      _ => '🦉',
    };
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.duoGold,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.duoBlack, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(emoji, style: TextStyle(fontSize: size * 0.5)),
    );
  }
}
