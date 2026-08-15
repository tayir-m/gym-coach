// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Exercise _$ExerciseFromJson(Map<String, dynamic> json) => _Exercise(
  name: json['name'] as String,
  sets: (json['sets'] as num).toInt(),
  reps: json['reps'] as String,
  restSeconds: (json['restSeconds'] as num?)?.toInt() ?? 90,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$ExerciseToJson(_Exercise instance) => <String, dynamic>{
  'name': instance.name,
  'sets': instance.sets,
  'reps': instance.reps,
  'restSeconds': instance.restSeconds,
  'notes': instance.notes,
};
