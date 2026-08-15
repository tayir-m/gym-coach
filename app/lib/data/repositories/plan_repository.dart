import 'dart:convert';
import 'package:drift/drift.dart';
import '../db/database.dart';
import '../../domain/models/plan.dart';
import '../../domain/models/exercise.dart';
import '../../domain/models/meal.dart';

class StoredPlan {
  final int id;
  final Plan plan;
  const StoredPlan(this.id, this.plan);
}

Map<String, dynamic> _trainingDayToJson(dynamic t) => {
      'week': t.week as int,
      'day_of_week': t.dayOfWeek as int,
      'title': t.title as String,
      'focus': t.focus as String,
      'estimated_minutes': t.estimatedMinutes as int,
      'exercises': (t.exercises as List<Exercise>)
          .map((e) => e.toJson())
          .toList(),
    };

Map<String, dynamic> _dailyMealsToJson(dynamic d) => {
      'week': d.week as int,
      'day_of_week': d.dayOfWeek as int,
      'total_kcal': d.totalKcal as int,
      'protein_g': d.proteinG as int,
      'carbs_g': d.carbsG as int,
      'fat_g': d.fatG as int,
      'meals': (d.meals as List<Meal>).map(_mealToJson).toList(),
    };

Map<String, dynamic> _mealToJson(Meal m) => {
      'slot': m.slot,
      'name': m.name,
      'kcal': m.kcal,
      'protein_g': m.proteinG,
      'carbs_g': m.carbsG,
      'fat_g': m.fatG,
      'ingredients': m.ingredients,
    };

/// Find the training day matching (week, dayOfWeek). Returns null if not found
/// (i.e. rest day — the 12-week plan emits 4 training days per week and the
/// remaining 3 dayOfWeek values are rest days).
TrainingDay? _findTrainingDay(Plan plan, int week, int dayOfWeek) {
  for (final t in plan.trainingDays) {
    if (t.week == week && t.dayOfWeek == dayOfWeek) return t;
  }
  return null;
}

DailyMeals? _findDailyMeals(Plan plan, int week, int dayOfWeek) {
  for (final d in plan.dailyMeals) {
    if (d.week == week && d.dayOfWeek == dayOfWeek) return d;
  }
  return null;
}

class PlanRepository {
  final AppDatabase db;
  PlanRepository(this.db);

  Future<int> create(Plan plan) async {
    final existing = await (db.select(db.plans)
          ..orderBy([(p) => OrderingTerm.desc(p.version), (p) => OrderingTerm.desc(p.id)])
          ..limit(1))
        .getSingleOrNull();
    final version = existing == null ? 1 : existing.version + 1;
    final planId = await db.into(db.plans).insert(
      PlansCompanion.insert(
        version: version,
        startDate: plan.startDate,
        weeks: plan.weeks,
        planJson: jsonEncode({
          'weeks': plan.weeks,
          'weekly_structure': plan.weeklyStructure,
          'goal_summary': plan.goalSummary,
          'training_days': plan.trainingDays.map(_trainingDayToJson).toList(),
          'daily_meals': plan.dailyMeals.map(_dailyMealsToJson).toList(),
        }),
        createdAt: DateTime.now(),
      ),
    );

    // Expand the plan into per-day day_task rows so TodayScreen and PathScreen
    // have data to render. Without this, the acceptance items 1/2/3/5/7 stay
    // permanently empty.
    final totalDays = plan.weeks * 7;
    final start = DateTime(plan.startDate.year, plan.startDate.month, plan.startDate.day);
    await db.batch((batch) {
      for (var dayIndex = 0; dayIndex < totalDays; dayIndex++) {
        final week = (dayIndex ~/ 7) + 1;
        final dayOfWeek = (dayIndex % 7) + 1; // 1=Mon..7=Sun per plan JSON schema
        final date = start.add(Duration(days: dayIndex));

        final training = _findTrainingDay(plan, week, dayOfWeek);
        final dailyMeals = _findDailyMeals(plan, week, dayOfWeek);

        final workoutJson = training == null
            ? ''
            : jsonEncode({
                'title': training.title,
                'estimated_minutes': training.estimatedMinutes,
                'exercises': training.exercises.map((e) => e.toJson()).toList(),
              });

        final mealsJson = jsonEncode(
          (dailyMeals?.meals ?? const <Meal>[]).map(_mealToJson).toList(),
        );

        batch.insert(
          db.dayTasks,
          DayTasksCompanion.insert(
            planId: planId,
            dayIndex: dayIndex,
            date: date,
            workoutJson: workoutJson,
            mealsJson: mealsJson,
          ),
        );
      }
    });

    return planId;
  }

  Future<void> deactivateAll() async {
    await db.update(db.plans).write(const PlansCompanion(active: Value(false)));
  }

  Future<StoredPlan?> getActive() async {
    final row = await (db.select(db.plans)
          ..where((p) => p.active.equals(true))
          ..orderBy([
            (p) => OrderingTerm.desc(p.version),
            (p) => OrderingTerm.desc(p.id),
          ])
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    final json = jsonDecode(row.planJson) as Map<String, dynamic>;
    json['startDate'] = row.startDate.toIso8601String();
    return StoredPlan(row.id, Plan.fromJson(json));
  }
}