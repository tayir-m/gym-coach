import 'dart:convert';
import 'package:drift/drift.dart';
import '../db/database.dart';

class StreakData {
  final int currentDays;
  final int longestDays;
  final DateTime? lastActiveDate;
  final int freezesRemaining;
  const StreakData({
    required this.currentDays,
    required this.longestDays,
    required this.lastActiveDate,
    required this.freezesRemaining,
  });
}

class GamificationRepository {
  final AppDatabase db;
  GamificationRepository(this.db);

  Future<StreakData> getStreak() async {
    final row = await (db.select(db.streaks)..limit(1)).getSingleOrNull();
    if (row == null) {
      await db.into(db.streaks).insert(StreaksCompanion.insert());
      return const StreakData(currentDays: 0, longestDays: 0, lastActiveDate: null, freezesRemaining: 2);
    }
    return StreakData(
      currentDays: row.currentDays,
      longestDays: row.longestDays,
      lastActiveDate: row.lastActiveDate,
      freezesRemaining: row.freezesRemaining,
    );
  }

  Future<void> updateStreak(StreakData s) async {
    await db.update(db.streaks).write(
      StreaksCompanion(
        currentDays: Value(s.currentDays),
        longestDays: Value(s.longestDays),
        lastActiveDate: Value(s.lastActiveDate),
        freezesRemaining: Value(s.freezesRemaining),
      ),
    );
  }

  Future<int> getTotalXp() async {
    final row = await (db.select(db.dayTasks)).get();
    return row.fold<int>(0, (sum, t) => sum + t.xpAwarded);
  }

  Future<int> getTotalWorkoutsCompleted() async {
    final count = await (db.selectOnly(db.dayTasks)
          ..addColumns([db.dayTasks.id.count()])
          ..where(db.dayTasks.completedWorkout.equals(true)))
        .map((row) => row.read<int>(db.dayTasks.id.count()) ?? 0)
        .getSingle();
    return count;
  }

  Future<int> getTotalDaysAllMealsCompleted() async {
    final rows = await (db.select(db.dayTasks)
          ..where((t) => t.completedWorkout.equals(true)))
        .get();
    return rows.where((t) {
      final map = (jsonDecode(t.completedMeals) as Map).cast<String, bool>();
      return map.values.isNotEmpty && map.values.every((v) => v);
    }).length;
  }

  Future<void> recordEvent(String type, int value) async {
    await db.into(db.gamificationEvents).insert(
      GamificationEventsCompanion.insert(
        eventType: type,
        value: value,
        createdAt: DateTime.now(),
      ),
    );
  }
}