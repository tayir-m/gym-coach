import 'package:freezed_annotation/freezed_annotation.dart';
import 'exercise.dart';
import 'meal.dart';

part 'plan.freezed.dart';
part 'plan.g.dart';

@freezed
class TrainingDay with _$TrainingDay {
  const factory TrainingDay({
    required int week,
    @JsonKey(name: 'day_of_week') required int dayOfWeek,
    required String title,
    required String focus,
    @JsonKey(name: 'estimated_minutes') required int estimatedMinutes,
    required List<Exercise> exercises,
  }) = _TrainingDay;

  factory TrainingDay.fromJson(Map<String, dynamic> json) =>
      _$TrainingDayFromJson(json);
}

@freezed
class DailyMeals with _$DailyMeals {
  const factory DailyMeals({
    required int week,
    @JsonKey(name: 'day_of_week') required int dayOfWeek,
    @JsonKey(name: 'total_kcal') required int totalKcal,
    @JsonKey(name: 'protein_g') required int proteinG,
    @JsonKey(name: 'carbs_g') required int carbsG,
    @JsonKey(name: 'fat_g') required int fatG,
    required List<Meal> meals,
  }) = _DailyMeals;

  factory DailyMeals.fromJson(Map<String, dynamic> json) =>
      _$DailyMealsFromJson(json);
}

@freezed
class Plan with _$Plan {
  const factory Plan({
    required int weeks,
    @JsonKey(name: 'weekly_structure') required String weeklyStructure,
    @JsonKey(name: 'goal_summary') required String goalSummary,
    @JsonKey(name: 'training_days') required List<TrainingDay> trainingDays,
    @JsonKey(name: 'daily_meals') required List<DailyMeals> dailyMeals,
    required DateTime startDate,
  }) = _Plan;

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
}
