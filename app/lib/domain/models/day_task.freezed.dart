// GENERATED CODE - DO NOT MODIFY BY HAND
// This is a PARTIAL STUB hand-authored because Flutter SDK / build_runner
// is not available in this development environment.
//
// To regenerate, run on a dev box with Flutter installed:
//   dart run build_runner build --delete-conflicting-outputs
//
// Replace this file with the real freezed-generated output.

part of 'day_task.dart';

mixin _$Workout {
  String get title;
  int get estimatedMinutes;
  List<Exercise> get exercises;

  Map<String, dynamic> toJson();

  // STUB: copyWith, ==, hashCode, toString intentionally omitted.
  // Regenerate via build_runner on a dev box before use.
}

mixin _$DayTask {
  int? get dbId;
  int get planId;
  int get dayIndex;
  DateTime get date;
  Workout? get workout;
  List<Meal> get meals;
  bool get completedWorkout;
  Map<String, bool> get completedMeals;
  int get xpAwarded;
  DateTime? get completedAt;

  Map<String, dynamic> toJson();

  // STUB: copyWith, ==, hashCode, toString intentionally omitted.
  // Regenerate via build_runner on a dev box before use.
}
