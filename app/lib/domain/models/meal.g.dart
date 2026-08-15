// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Meal _$MealFromJson(Map<String, dynamic> json) => _Meal(
  slot: json['slot'] as String,
  name: json['name'] as String,
  kcal: (json['kcal'] as num).toInt(),
  proteinG: (json['protein_g'] as num).toInt(),
  carbsG: (json['carbs_g'] as num).toInt(),
  fatG: (json['fat_g'] as num).toInt(),
  ingredients:
      (json['ingredients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$MealToJson(_Meal instance) => <String, dynamic>{
  'slot': instance.slot,
  'name': instance.name,
  'kcal': instance.kcal,
  'protein_g': instance.proteinG,
  'carbs_g': instance.carbsG,
  'fat_g': instance.fatG,
  'ingredients': instance.ingredients,
};
