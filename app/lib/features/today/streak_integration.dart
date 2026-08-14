import '../../data/repositories/gamification_repository.dart';
import '../../domain/streak_calculator.dart';

class StreakIntegration {
  final GamificationRepository repo;
  StreakIntegration(this.repo);

  /// App 启动时调用，刷新 streak 并按需发放 freeze 卡
  Future<bool> welcomeBackNeeded() async {
    final streak = await repo.getStreak();
    final now = DateTime.now();
    if (streak.lastActiveDate == null) return false;
    final daysSince = DateTime(streak.lastActiveDate!.year, streak.lastActiveDate!.month, streak.lastActiveDate!.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays
        .abs();
    return daysSince >= 7;
  }

  Future<void> recordActiveToday() async {
    final streak = await repo.getStreak();
    final now = DateTime.now();
    final update = evaluateStreakOnActive(
      currentStreakDays: streak.currentDays,
      longestStreakDays: streak.longestDays,
      freezesRemaining: streak.freezesRemaining,
      lastActiveDate: streak.lastActiveDate,
      now: now,
    );
    await repo.updateStreak(StreakData(
      currentDays: update.newCurrentDays,
      longestDays: update.newLongestDays,
      lastActiveDate: now,
      freezesRemaining: (streak.freezesRemaining - update.freezesConsumed).clamp(0, 2),
    ));
  }
}
