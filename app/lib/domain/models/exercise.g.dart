// GENERATED CODE - DO NOT MODIFY BY HAND
// This is a PARTIAL STUB hand-authored because Flutter SDK / build_runner
// is not available in this development environment.
//
// To regenerate, run on a dev box with Flutter installed:
//   dart run build_runner build --delete-conflicting-outputs
//
// Replace this file with the real json_serializable-generated output.

part of 'exercise.dart';

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  // STUB: real implementation deserializes with @JsonKey support.
  // Regenerate via build_runner on a dev box before use.
  return Exercise(
    name: json['name'] as String,
    sets: json['sets'] as int,
    reps: json['reps'] as String,
    restSeconds: (json['rest_seconds'] as int?) ?? 90,
    notes: json['notes'] as String?,
  );
}

Map<String, dynamic> _$ExerciseToJson(Exercise instance) {
  // STUB: real implementation serializes with @JsonKey support.
  // Regenerate via build_runner on a dev box before use.
  return <String, dynamic>{
    'name': instance.name,
    'sets': instance.sets,
    'reps': instance.reps,
    'rest_seconds': instance.restSeconds,
    'notes': instance.notes,
  };
}
