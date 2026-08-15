import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal.freezed.dart';
part 'meal.g.dart';

@freezed
abstract class Meal with _$Meal {
  const factory Meal({
    required String slot,        // breakfast/lunch/dinner/snack
    required String name,
    required int kcal,
    @JsonKey(name: 'protein_g') required int proteinG,
    @JsonKey(name: 'carbs_g') required int carbsG,
    @JsonKey(name: 'fat_g') required int fatG,
    @Default([]) List<String> ingredients,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}
