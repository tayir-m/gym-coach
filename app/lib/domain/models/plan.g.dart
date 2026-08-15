// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingDay _$TrainingDayFromJson(Map<String, dynamic> json) => _TrainingDay(
  week: (json['week'] as num).toInt(),
  dayOfWeek: (json['day_of_week'] as num).toInt(),
  title: json['title'] as String,
  focus: json['focus'] as String,
  estimatedMinutes: (json['estimated_minutes'] as num).toInt(),
  exercises: (json['exercises'] as List<dynamic>)
      .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TrainingDayToJson(_TrainingDay instance) =>
    <String, dynamic>{
      'week': instance.week,
      'day_of_week': instance.dayOfWeek,
      'title': instance.title,
      'focus': instance.focus,
      'estimated_minutes': instance.estimatedMinutes,
      'exercises': instance.exercises,
    };

_DailyMeals _$DailyMealsFromJson(Map<String, dynamic> json) => _DailyMeals(
  week: (json['week'] as num).toInt(),
  dayOfWeek: (json['day_of_week'] as num).toInt(),
  totalKcal: (json['total_kcal'] as num).toInt(),
  proteinG: (json['protein_g'] as num).toInt(),
  carbsG: (json['carbs_g'] as num).toInt(),
  fatG: (json['fat_g'] as num).toInt(),
  meals: (json['meals'] as List<dynamic>)
      .map((e) => Meal.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DailyMealsToJson(_DailyMeals instance) =>
    <String, dynamic>{
      'week': instance.week,
      'day_of_week': instance.dayOfWeek,
      'total_kcal': instance.totalKcal,
      'protein_g': instance.proteinG,
      'carbs_g': instance.carbsG,
      'fat_g': instance.fatG,
      'meals': instance.meals,
    };

_Plan _$PlanFromJson(Map<String, dynamic> json) => _Plan(
  weeks: (json['weeks'] as num).toInt(),
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

Map<String, dynamic> _$PlanToJson(_Plan instance) => <String, dynamic>{
  'weeks': instance.weeks,
  'weekly_structure': instance.weeklyStructure,
  'goal_summary': instance.goalSummary,
  'training_days': instance.trainingDays,
  'daily_meals': instance.dailyMeals,
  'startDate': instance.startDate.toIso8601String(),
};
