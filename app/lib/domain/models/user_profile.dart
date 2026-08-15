import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

enum Goal { muscleGain, fatLoss, maintenance, strength }
enum Experience { beginner, intermediate, advanced }
enum Sex { male, female, other }

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int age,
    @JsonKey(name: 'height_cm') required double heightCm,
    @JsonKey(name: 'weight_kg') required double weightKg,
    required Sex sex,
    required Goal goal,
    required Experience experience,
    @Default([]) List<String> equipment,
    String? injuries,
    @JsonKey(name: 'dietary_notes') String? dietaryNotes,
    @JsonKey(name: 'daily_schedule') @Default({}) Map<String, bool> dailySchedule,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
