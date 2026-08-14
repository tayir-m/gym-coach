import 'dart:convert';
import 'package:drift/drift.dart';
import '../db/database.dart';
import '../../domain/models/day_task.dart';
import '../../domain/models/exercise.dart';
import '../../domain/models/meal.dart';

class DayTaskRepository {
  final AppDatabase db;
  DayTaskRepository(this.db);

  Future<DayTask?> getByDate(int planId, DateTime date) async {
    final row = await (db.select(db.dayTasks)
          ..where((t) => t.planId.equals(planId) & t.date.equals(date))
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    return _toModel(row);
  }

  Future<List<DayTask>> getAllForPlan(int planId) async {
    final rows = await (db.select(db.dayTasks)
          ..where((t) => t.planId.equals(planId))
          ..orderBy([(t) => OrderingTerm.asc(t.dayIndex)]))
        .get();
    return rows.map(_toModel).toList();
  }

  Future<void> markWorkoutDone(int id) async {
    await (db.update(db.dayTasks)..where((t) => t.id.equals(id))).write(
      DayTasksCompanion(
        completedWorkout: const Value(true),
        completedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> markMealDone(int id, String slot, bool done) async {
    final row = await (db.select(db.dayTasks)..where((t) => t.id.equals(id))).getSingle();
    final map = (jsonDecode(row.completedMeals) as Map).cast<String, bool>();
    map[slot] = done;
    await (db.update(db.dayTasks)..where((t) => t.id.equals(id))).write(
      DayTasksCompanion(completedMeals: Value(jsonEncode(map))),
    );
  }

  Future<void> awardXp(int id, int additionalXp) async {
    final row = await (db.select(db.dayTasks)..where((t) => t.id.equals(id))).getSingle();
    await (db.update(db.dayTasks)..where((t) => t.id.equals(id))).write(
      DayTasksCompanion(xpAwarded: Value(row.xpAwarded + additionalXp)),
    );
  }

  DayTask _toModel(DayTaskRow row) {
    final workoutJson = row.workoutJson.isEmpty ? null : jsonDecode(row.workoutJson);
    final mealsJson = (jsonDecode(row.mealsJson) as List).cast<Map<String, dynamic>>();
    return DayTask(
      dbId: row.id,
      planId: row.planId,
      dayIndex: row.dayIndex,
      date: row.date,
      workout: workoutJson == null
          ? null
          : Workout(
              title: workoutJson['title'] as String,
              estimatedMinutes: workoutJson['estimated_minutes'] as int,
              exercises: (workoutJson['exercises'] as List)
                  .cast<Map<String, dynamic>>()
                  .map(Exercise.fromJson)
                  .toList(),
            ),
      meals: mealsJson.map(Meal.fromJson).toList(),
      completedWorkout: row.completedWorkout,
      completedMeals:
          (jsonDecode(row.completedMeals) as Map).cast<String, bool>(),
      xpAwarded: row.xpAwarded,
      completedAt: row.completedAt,
    );
  }
}