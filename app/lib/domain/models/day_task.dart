import 'package:freezed_annotation/freezed_annotation.dart';
import 'exercise.dart';
import 'meal.dart';

part 'day_task.freezed.dart';

@freezed
class Workout with _$Workout {
  const factory Workout({
    required String title,
    required int estimatedMinutes,
    required List<Exercise> exercises,
  }) = _Workout;
}

@freezed
class DayTask with _$DayTask {
  const factory DayTask({
    int? dbId,                          // 仅从 DB 读出时填，用于 markWorkoutDone/markMealDone
    required int planId,
    required int dayIndex,
    required DateTime date,
    Workout? workout,
    @Default([]) List<Meal> meals,
    @Default(false) bool completedWorkout,
    @Default({}) Map<String, bool> completedMeals,
    @Default(0) int xpAwarded,
    DateTime? completedAt,
  }) = _DayTask;
}
