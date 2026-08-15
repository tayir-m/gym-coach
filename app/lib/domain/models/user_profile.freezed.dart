// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 int get age;@JsonKey(name: 'height_cm') double get heightCm;@JsonKey(name: 'weight_kg') double get weightKg; Sex get sex; Goal get goal; Experience get experience; List<String> get equipment; String? get injuries;@JsonKey(name: 'dietary_notes') String? get dietaryNotes;@JsonKey(name: 'daily_schedule') Map<String, bool> get dailySchedule;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.age, age) || other.age == age)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.experience, experience) || other.experience == experience)&&const DeepCollectionEquality().equals(other.equipment, equipment)&&(identical(other.injuries, injuries) || other.injuries == injuries)&&(identical(other.dietaryNotes, dietaryNotes) || other.dietaryNotes == dietaryNotes)&&const DeepCollectionEquality().equals(other.dailySchedule, dailySchedule)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,age,heightCm,weightKg,sex,goal,experience,const DeepCollectionEquality().hash(equipment),injuries,dietaryNotes,const DeepCollectionEquality().hash(dailySchedule),updatedAt);

@override
String toString() {
  return 'UserProfile(age: $age, heightCm: $heightCm, weightKg: $weightKg, sex: $sex, goal: $goal, experience: $experience, equipment: $equipment, injuries: $injuries, dietaryNotes: $dietaryNotes, dailySchedule: $dailySchedule, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 int age,@JsonKey(name: 'height_cm') double heightCm,@JsonKey(name: 'weight_kg') double weightKg, Sex sex, Goal goal, Experience experience, List<String> equipment, String? injuries,@JsonKey(name: 'dietary_notes') String? dietaryNotes,@JsonKey(name: 'daily_schedule') Map<String, bool> dailySchedule,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? age = null,Object? heightCm = null,Object? weightKg = null,Object? sex = null,Object? goal = null,Object? experience = null,Object? equipment = null,Object? injuries = freezed,Object? dietaryNotes = freezed,Object? dailySchedule = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,heightCm: null == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as Sex,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as Goal,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as Experience,equipment: null == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as List<String>,injuries: freezed == injuries ? _self.injuries : injuries // ignore: cast_nullable_to_non_nullable
as String?,dietaryNotes: freezed == dietaryNotes ? _self.dietaryNotes : dietaryNotes // ignore: cast_nullable_to_non_nullable
as String?,dailySchedule: null == dailySchedule ? _self.dailySchedule : dailySchedule // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int age, @JsonKey(name: 'height_cm')  double heightCm, @JsonKey(name: 'weight_kg')  double weightKg,  Sex sex,  Goal goal,  Experience experience,  List<String> equipment,  String? injuries, @JsonKey(name: 'dietary_notes')  String? dietaryNotes, @JsonKey(name: 'daily_schedule')  Map<String, bool> dailySchedule, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.age,_that.heightCm,_that.weightKg,_that.sex,_that.goal,_that.experience,_that.equipment,_that.injuries,_that.dietaryNotes,_that.dailySchedule,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int age, @JsonKey(name: 'height_cm')  double heightCm, @JsonKey(name: 'weight_kg')  double weightKg,  Sex sex,  Goal goal,  Experience experience,  List<String> equipment,  String? injuries, @JsonKey(name: 'dietary_notes')  String? dietaryNotes, @JsonKey(name: 'daily_schedule')  Map<String, bool> dailySchedule, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.age,_that.heightCm,_that.weightKg,_that.sex,_that.goal,_that.experience,_that.equipment,_that.injuries,_that.dietaryNotes,_that.dailySchedule,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int age, @JsonKey(name: 'height_cm')  double heightCm, @JsonKey(name: 'weight_kg')  double weightKg,  Sex sex,  Goal goal,  Experience experience,  List<String> equipment,  String? injuries, @JsonKey(name: 'dietary_notes')  String? dietaryNotes, @JsonKey(name: 'daily_schedule')  Map<String, bool> dailySchedule, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.age,_that.heightCm,_that.weightKg,_that.sex,_that.goal,_that.experience,_that.equipment,_that.injuries,_that.dietaryNotes,_that.dailySchedule,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({required this.age, @JsonKey(name: 'height_cm') required this.heightCm, @JsonKey(name: 'weight_kg') required this.weightKg, required this.sex, required this.goal, required this.experience, final  List<String> equipment = const [], this.injuries, @JsonKey(name: 'dietary_notes') this.dietaryNotes, @JsonKey(name: 'daily_schedule') final  Map<String, bool> dailySchedule = const {}, @JsonKey(name: 'updated_at') required this.updatedAt}): _equipment = equipment,_dailySchedule = dailySchedule;
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  int age;
@override@JsonKey(name: 'height_cm') final  double heightCm;
@override@JsonKey(name: 'weight_kg') final  double weightKg;
@override final  Sex sex;
@override final  Goal goal;
@override final  Experience experience;
 final  List<String> _equipment;
@override@JsonKey() List<String> get equipment {
  if (_equipment is EqualUnmodifiableListView) return _equipment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipment);
}

@override final  String? injuries;
@override@JsonKey(name: 'dietary_notes') final  String? dietaryNotes;
 final  Map<String, bool> _dailySchedule;
@override@JsonKey(name: 'daily_schedule') Map<String, bool> get dailySchedule {
  if (_dailySchedule is EqualUnmodifiableMapView) return _dailySchedule;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_dailySchedule);
}

@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.age, age) || other.age == age)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.sex, sex) || other.sex == sex)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.experience, experience) || other.experience == experience)&&const DeepCollectionEquality().equals(other._equipment, _equipment)&&(identical(other.injuries, injuries) || other.injuries == injuries)&&(identical(other.dietaryNotes, dietaryNotes) || other.dietaryNotes == dietaryNotes)&&const DeepCollectionEquality().equals(other._dailySchedule, _dailySchedule)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,age,heightCm,weightKg,sex,goal,experience,const DeepCollectionEquality().hash(_equipment),injuries,dietaryNotes,const DeepCollectionEquality().hash(_dailySchedule),updatedAt);

@override
String toString() {
  return 'UserProfile(age: $age, heightCm: $heightCm, weightKg: $weightKg, sex: $sex, goal: $goal, experience: $experience, equipment: $equipment, injuries: $injuries, dietaryNotes: $dietaryNotes, dailySchedule: $dailySchedule, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 int age,@JsonKey(name: 'height_cm') double heightCm,@JsonKey(name: 'weight_kg') double weightKg, Sex sex, Goal goal, Experience experience, List<String> equipment, String? injuries,@JsonKey(name: 'dietary_notes') String? dietaryNotes,@JsonKey(name: 'daily_schedule') Map<String, bool> dailySchedule,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? age = null,Object? heightCm = null,Object? weightKg = null,Object? sex = null,Object? goal = null,Object? experience = null,Object? equipment = null,Object? injuries = freezed,Object? dietaryNotes = freezed,Object? dailySchedule = null,Object? updatedAt = null,}) {
  return _then(_UserProfile(
age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,heightCm: null == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double,weightKg: null == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double,sex: null == sex ? _self.sex : sex // ignore: cast_nullable_to_non_nullable
as Sex,goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as Goal,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as Experience,equipment: null == equipment ? _self._equipment : equipment // ignore: cast_nullable_to_non_nullable
as List<String>,injuries: freezed == injuries ? _self.injuries : injuries // ignore: cast_nullable_to_non_nullable
as String?,dietaryNotes: freezed == dietaryNotes ? _self.dietaryNotes : dietaryNotes // ignore: cast_nullable_to_non_nullable
as String?,dailySchedule: null == dailySchedule ? _self._dailySchedule : dailySchedule // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
