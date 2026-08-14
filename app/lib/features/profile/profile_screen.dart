import 'package:flutter/material.dart';
import 'package:gym_coach/data/repositories/gamification_repository.dart';
import 'package:gym_coach/gamification/badge_engine.dart';
import 'package:gym_coach/gamification/xp_engine.dart';
import 'package:gym_coach/theme/colors.dart';
import 'package:gym_coach/theme/mascot.dart';

class ProfileScreen extends StatefulWidget {
  final GamificationRepository gamifRepo;
  const ProfileScreen({super.key, required this.gamifRepo});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.duoBackground,
      appBar: AppBar(title: const Text('我'), backgroundColor: AppColors.duoGold),
      body: FutureBuilder(
        future: _load(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snap.data!;
          final level = levelFromXp(data.totalXp);
          final xpToNext = xpToNextLevel(data.totalXp);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const AppMascot(size: 120),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('🔥 ${data.streak.currentDays} 天 streak',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                      Text('最长 ${data.streak.longestDays} 天'),
                      Text('冻结卡 ${data.streak.freezesRemaining} 张'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Lv. $level', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                      Text('$xpToNext XP 升下一级'),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 1 - xpToNext / 1000,
                        backgroundColor: AppColors.duoGray,
                        color: AppColors.duoGreen,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text('徽章', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: data.unlocked.map((b) => Chip(
                  label: Text(b),
                  backgroundColor: AppColors.duoGold,
                )).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<_ProfileData> _load() async {
    final streak = await widget.gamifRepo.getStreak();
    final totalXp = await widget.gamifRepo.getTotalXp();
    final totalWorkouts = await widget.gamifRepo.getTotalWorkoutsCompleted();
    final totalAllMealsDays = await widget.gamifRepo.getTotalDaysAllMealsCompleted();
    final unlocked = checkUnlockedBadges({
      'totalWorkoutsCompleted': totalWorkouts,
      'longestStreak': streak.longestDays,
      'totalDaysAllMealsCompleted': totalAllMealsDays,
      'level': levelFromXp(totalXp),
    });
    return _ProfileData(streak: streak, totalXp: totalXp, unlocked: unlocked);
  }
}

class _ProfileData {
  final StreakData streak;
  final int totalXp;
  final List<String> unlocked;
  _ProfileData({required this.streak, required this.totalXp, required this.unlocked});
}
