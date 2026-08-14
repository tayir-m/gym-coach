// GENERATED CODE - DO NOT MODIFY BY HAND
// This is a PARTIAL STUB hand-authored because Flutter SDK / build_runner
// is not available in this development environment.
//
// To regenerate, run on a dev box with Flutter installed:
//   dart run build_runner build --delete-conflicting-outputs
//
// Replace this file with the real json_serializable-generated output.

part of 'meal.dart';

Meal _$MealFromJson(Map<String, dynamic> json) {
  // STUB: real implementation deserializes with @JsonKey support.
  // Regenerate via build_runner on a dev box before use.
  return Meal(
    slot: json['slot'] as String,
    name: json['name'] as String,
    kcal: json['kcal'] as int,
    proteinG: json['protein_g'] as int,
    carbsG: json['carbs_g'] as int,
    fatG: json['fat_g'] as int,
    ingredients: (json['ingredients'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        <String>[],
  );
}

Map<String, dynamic> _$MealToJson(Meal instance) {
  // STUB: real implementation serializes with @JsonKey support.
  // Regenerate via build_runner on a dev box before use.
  return <String, dynamic>{
    'slot': instance.slot,
    'name': instance.name,
    'kcal': instance.kcal,
    'protein_g': instance.proteinG,
    'carbs_g': instance.carbsG,
    'fat_g': instance.fatG,
    'ingredients': instance.ingredients,
  };
}
