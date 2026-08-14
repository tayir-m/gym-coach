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
      'meals': (d.meals as List<Meal>).map((m) => m.toJson()).toList(),
    };

class PlanRepository {
  final AppDatabase db;
  PlanRepository(this.db);

  Future<int> create(Plan plan) async {
    final existing = await (db.select(db.plans)..limit(1)).getSingleOrNull();
    final version = existing == null ? 1 : existing.version + 1;
    return db.into(db.plans).insert(
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
  }

  Future<void> deactivateAll() async {
    await db.update(db.plans).write(const PlansCompanion(active: Value(false)));
  }

  Future<StoredPlan?> getActive() async {
    final row = await (db.select(db.plans)
          ..where((p) => p.active.equals(true))
          ..orderBy([(p) => OrderingTerm.desc(p.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    final json = jsonDecode(row.planJson) as Map<String, dynamic>;
    json['startDate'] = row.startDate.toIso8601String();
    return StoredPlan(row.id, Plan.fromJson(json));
  }
}