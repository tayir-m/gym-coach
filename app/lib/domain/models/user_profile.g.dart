// GENERATED CODE - DO NOT MODIFY BY HAND
// This is a PARTIAL STUB hand-authored because Flutter SDK / build_runner
// is not available in this development environment.
//
// To regenerate, run on a dev box with Flutter installed:
//   dart run build_runner build --delete-conflicting-outputs
//
// Replace this file with the real json_serializable-generated output.

part of 'user_profile.dart';

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  // STUB: real implementation deserializes with @JsonKey + enum support.
  // Regenerate via build_runner on a dev box before use.
  return UserProfile(
    age: json['age'] as int,
    heightCm: (json['height_cm'] as num).toDouble(),
    weightKg: (json['weight_kg'] as num).toDouble(),
    sex: $enumDecode(_$SexEnumMap, json['sex']),
    goal: $enumDecode(_$GoalEnumMap, json['goal']),
    experience: $enumDecode(_$ExperienceEnumMap, json['experience']),
    equipment: (json['equipment'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        <String>[],
    injuries: json['injuries'] as String?,
    dietaryNotes: json['dietary_notes'] as String?,
    dailySchedule: (json['daily_schedule'] as Map<String, dynamic>?)
            ?.map((k, e) => MapEntry(k, e as bool)) ??
        <String, bool>{},
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) {
  // STUB: real implementation serializes with @JsonKey + enum support.
  // Regenerate via build_runner on a dev box before use.
  return <String, dynamic>{
    'age': instance.age,
    'height_cm': instance.heightCm,
    'weight_kg': instance.weightKg,
    'sex': _$SexEnumMap[instance.sex]!,
    'goal': _$GoalEnumMap[instance.goal]!,
    'experience': _$ExperienceEnumMap[instance.experience]!,
    'equipment': instance.equipment,
    'injuries': instance.injuries,
    'dietary_notes': instance.dietaryNotes,
    'daily_schedule': instance.dailySchedule,
    'updated_at': instance.updatedAt.toIso8601String(),
  };
}

const _$SexEnumMap = {
  Sex.male: 'male',
  Sex.female: 'female',
  Sex.other: 'other',
};

const _$GoalEnumMap = {
  Goal.muscleGain: 'muscleGain',
  Goal.fatLoss: 'fatLoss',
  Goal.maintenance: 'maintenance',
  Goal.strength: 'strength',
};

const _$ExperienceEnumMap = {
  Experience.beginner: 'beginner',
  Experience.intermediate: 'intermediate',
  Experience.advanced: 'advanced',
};
