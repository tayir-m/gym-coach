// GENERATED CODE - DO NOT MODIFY BY HAND
// This is a PARTIAL STUB hand-authored because Flutter SDK / build_runner
// is not available in this development environment.
//
// To regenerate, run on a dev box with Flutter installed:
//   dart run build_runner build --delete-conflicting-outputs
//
// Replace this file with the real json_serializable-generated output.

part of 'plan.dart';

TrainingDay _$TrainingDayFromJson(Map<String, dynamic> json) {
  // STUB: real implementation deserializes with @JsonKey support.
  // Regenerate via build_runner on a dev box before use.
  return TrainingDay(
    week: json['week'] as int,
    dayOfWeek: json['day_of_week'] as int,
    title: json['title'] as String,
    focus: json['focus'] as String,
    estimatedMinutes: json['estimated_minutes'] as int,
    exercises: (json['exercises'] as List<dynamic>)
        .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TrainingDayToJson(TrainingDay instance) {
  // STUB: real implementation serializes with @JsonKey support.
  // Regenerate via build_runner on a dev box before use.
  return <String, dynamic>{
    'week': instance.week,
    'day_of_week': instance.dayOfWeek,
    'title': instance.title,
    'focus': instance.focus,
    'estimated_minutes': instance.estimatedMinutes,
    'exercises': instance.exercises.map((e) => e.toJson()).toList(),
  };
}

DailyMeals _$DailyMealsFromJson(Map<String, dynamic> json) {
  // STUB: real implementation deserializes with @JsonKey support.
  // Regenerate via build_runner on a dev box before use.
  return DailyMeals(
    week: json['week'] as int,
    dayOfWeek: json['day_of_week'] as int,
    totalKcal: json['total_kcal'] as int,
    proteinG: json['protein_g'] as int,
    carbsG: json['carbs_g'] as int,
    fatG: json['fat_g'] as int,
    meals: (json['meals'] as List<dynamic>)
        .map((e) => Meal.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DailyMealsToJson(DailyMeals instance) {
  // STUB: real implementation serializes with @JsonKey support.
  // Regenerate via build_runner on a dev box before use.
  return <String, dynamic>{
    'week': instance.week,
    'day_of_week': instance.dayOfWeek,
    'total_kcal': instance.totalKcal,
    'protein_g': instance.proteinG,
    'carbs_g': instance.carbsG,
    'fat_g': instance.fatG,
    'meals': instance.meals.map((e) => e.toJson()).toList(),
  };
}

Plan _$PlanFromJson(Map<String, dynamic> json) {
  // STUB: real implementation deserializes with @JsonKey support.
  // Regenerate via build_runner on a dev box before use.
  return Plan(
    weeks: json['weeks'] as int,
    weeklyStructure: json['weekly_structure'] as String,
    goalSummary: json['goal_summary'] as String,
    trainingDays: (json['training_days'] as List<dynamic>)
        .map((e) => TrainingDay.fromJson(e as Map<String, dynamic>))
        .toList(),
    dailyMeals: (json['daily_meals'] as List<dynamic>)
        .map((e) => DailyMeals.fromJson(e as Map<String, dynamic>))
        .toList(),
    startDate: DateTime.parse(json['startDate'] as String),
  );
}

Map<String, dynamic> _$PlanToJson(Plan instance) {
  // STUB: real implementation serializes with @JsonKey support.
  // Regenerate via build_runner on a dev box before use.
  return <String, dynamic>{
    'weeks': instance.weeks,
    'weekly_structure': instance.weeklyStructure,
    'goal_summary': instance.goalSummary,
    'training_days':
        instance.trainingDays.map((e) => e.toJson()).toList(),
    'daily_meals': instance.dailyMeals.map((e) => e.toJson()).toList(),
    'startDate': instance.startDate.toIso8601String(),
  };
}
