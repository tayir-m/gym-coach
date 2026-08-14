// GENERATED CODE - DO NOT MODIFY BY HAND
// This is a PARTIAL STUB hand-authored because Flutter SDK / build_runner
// is not available in this development environment.
//
// To regenerate, run on a dev box with Flutter installed:
//   dart run build_runner build --delete-conflicting-outputs
//
// Replace this file with the real freezed-generated output.

part of 'plan.dart';

mixin _$TrainingDay {
  int get week;
  int get dayOfWeek;
  String get title;
  String get focus;
  int get estimatedMinutes;
  List<Exercise> get exercises;

  Map<String, dynamic> toJson();

  // STUB: copyWith, ==, hashCode, toString intentionally omitted.
  // Regenerate via build_runner on a dev box before use.
}

mixin _$DailyMeals {
  int get week;
  int get dayOfWeek;
  int get totalKcal;
  int get proteinG;
  int get carbsG;
  int get fatG;
  List<Meal> get meals;

  Map<String, dynamic> toJson();

  // STUB: copyWith, ==, hashCode, toString intentionally omitted.
  // Regenerate via build_runner on a dev box before use.
}

mixin _$Plan {
  int get weeks;
  String get weeklyStructure;
  String get goalSummary;
  List<TrainingDay> get trainingDays;
  List<DailyMeals> get dailyMeals;
  DateTime get startDate;

  Map<String, dynamic> toJson();

  // STUB: copyWith, ==, hashCode, toString intentionally omitted.
  // Regenerate via build_runner on a dev box before use.
}
