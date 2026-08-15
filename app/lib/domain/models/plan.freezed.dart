// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingDay {

 int get week;@JsonKey(name: 'day_of_week') int get dayOfWeek; String get title; String get focus;@JsonKey(name: 'estimated_minutes') int get estimatedMinutes; List<Exercise> get exercises;
/// Create a copy of TrainingDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingDayCopyWith<TrainingDay> get copyWith => _$TrainingDayCopyWithImpl<TrainingDay>(this as TrainingDay, _$identity);

  /// Serializes this TrainingDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingDay&&(identical(other.week, week) || other.week == week)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.title, title) || other.title == title)&&(identical(other.focus, focus) || other.focus == focus)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,week,dayOfWeek,title,focus,estimatedMinutes,const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'TrainingDay(week: $week, dayOfWeek: $dayOfWeek, title: $title, focus: $focus, estimatedMinutes: $estimatedMinutes, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $TrainingDayCopyWith<$Res>  {
  factory $TrainingDayCopyWith(TrainingDay value, $Res Function(TrainingDay) _then) = _$TrainingDayCopyWithImpl;
@useResult
$Res call({
 int week,@JsonKey(name: 'day_of_week') int dayOfWeek, String title, String focus,@JsonKey(name: 'estimated_minutes') int estimatedMinutes, List<Exercise> exercises
});




}
/// @nodoc
class _$TrainingDayCopyWithImpl<$Res>
    implements $TrainingDayCopyWith<$Res> {
  _$TrainingDayCopyWithImpl(this._self, this._then);

  final TrainingDay _self;
  final $Res Function(TrainingDay) _then;

/// Create a copy of TrainingDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? week = null,Object? dayOfWeek = null,Object? title = null,Object? focus = null,Object? estimatedMinutes = null,Object? exercises = null,}) {
  return _then(_self.copyWith(
week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,focus: null == focus ? _self.focus : focus // ignore: cast_nullable_to_non_nullable
as String,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<Exercise>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingDay].
extension TrainingDayPatterns on TrainingDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingDay value)  $default,){
final _that = this;
switch (_that) {
case _TrainingDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingDay value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int week, @JsonKey(name: 'day_of_week')  int dayOfWeek,  String title,  String focus, @JsonKey(name: 'estimated_minutes')  int estimatedMinutes,  List<Exercise> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingDay() when $default != null:
return $default(_that.week,_that.dayOfWeek,_that.title,_that.focus,_that.estimatedMinutes,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int week, @JsonKey(name: 'day_of_week')  int dayOfWeek,  String title,  String focus, @JsonKey(name: 'estimated_minutes')  int estimatedMinutes,  List<Exercise> exercises)  $default,) {final _that = this;
switch (_that) {
case _TrainingDay():
return $default(_that.week,_that.dayOfWeek,_that.title,_that.focus,_that.estimatedMinutes,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int week, @JsonKey(name: 'day_of_week')  int dayOfWeek,  String title,  String focus, @JsonKey(name: 'estimated_minutes')  int estimatedMinutes,  List<Exercise> exercises)?  $default,) {final _that = this;
switch (_that) {
case _TrainingDay() when $default != null:
return $default(_that.week,_that.dayOfWeek,_that.title,_that.focus,_that.estimatedMinutes,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingDay implements TrainingDay {
  const _TrainingDay({required this.week, @JsonKey(name: 'day_of_week') required this.dayOfWeek, required this.title, required this.focus, @JsonKey(name: 'estimated_minutes') required this.estimatedMinutes, required final  List<Exercise> exercises}): _exercises = exercises;
  factory _TrainingDay.fromJson(Map<String, dynamic> json) => _$TrainingDayFromJson(json);

@override final  int week;
@override@JsonKey(name: 'day_of_week') final  int dayOfWeek;
@override final  String title;
@override final  String focus;
@override@JsonKey(name: 'estimated_minutes') final  int estimatedMinutes;
 final  List<Exercise> _exercises;
@override List<Exercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of TrainingDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingDayCopyWith<_TrainingDay> get copyWith => __$TrainingDayCopyWithImpl<_TrainingDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingDayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingDay&&(identical(other.week, week) || other.week == week)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.title, title) || other.title == title)&&(identical(other.focus, focus) || other.focus == focus)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,week,dayOfWeek,title,focus,estimatedMinutes,const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'TrainingDay(week: $week, dayOfWeek: $dayOfWeek, title: $title, focus: $focus, estimatedMinutes: $estimatedMinutes, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$TrainingDayCopyWith<$Res> implements $TrainingDayCopyWith<$Res> {
  factory _$TrainingDayCopyWith(_TrainingDay value, $Res Function(_TrainingDay) _then) = __$TrainingDayCopyWithImpl;
@override @useResult
$Res call({
 int week,@JsonKey(name: 'day_of_week') int dayOfWeek, String title, String focus,@JsonKey(name: 'estimated_minutes') int estimatedMinutes, List<Exercise> exercises
});




}
/// @nodoc
class __$TrainingDayCopyWithImpl<$Res>
    implements _$TrainingDayCopyWith<$Res> {
  __$TrainingDayCopyWithImpl(this._self, this._then);

  final _TrainingDay _self;
  final $Res Function(_TrainingDay) _then;

/// Create a copy of TrainingDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? week = null,Object? dayOfWeek = null,Object? title = null,Object? focus = null,Object? estimatedMinutes = null,Object? exercises = null,}) {
  return _then(_TrainingDay(
week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,focus: null == focus ? _self.focus : focus // ignore: cast_nullable_to_non_nullable
as String,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<Exercise>,
  ));
}


}


/// @nodoc
mixin _$DailyMeals {

 int get week;@JsonKey(name: 'day_of_week') int get dayOfWeek;@JsonKey(name: 'total_kcal') int get totalKcal;@JsonKey(name: 'protein_g') int get proteinG;@JsonKey(name: 'carbs_g') int get carbsG;@JsonKey(name: 'fat_g') int get fatG; List<Meal> get meals;
/// Create a copy of DailyMeals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyMealsCopyWith<DailyMeals> get copyWith => _$DailyMealsCopyWithImpl<DailyMeals>(this as DailyMeals, _$identity);

  /// Serializes this DailyMeals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyMeals&&(identical(other.week, week) || other.week == week)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.totalKcal, totalKcal) || other.totalKcal == totalKcal)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG)&&const DeepCollectionEquality().equals(other.meals, meals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,week,dayOfWeek,totalKcal,proteinG,carbsG,fatG,const DeepCollectionEquality().hash(meals));

@override
String toString() {
  return 'DailyMeals(week: $week, dayOfWeek: $dayOfWeek, totalKcal: $totalKcal, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG, meals: $meals)';
}


}

/// @nodoc
abstract mixin class $DailyMealsCopyWith<$Res>  {
  factory $DailyMealsCopyWith(DailyMeals value, $Res Function(DailyMeals) _then) = _$DailyMealsCopyWithImpl;
@useResult
$Res call({
 int week,@JsonKey(name: 'day_of_week') int dayOfWeek,@JsonKey(name: 'total_kcal') int totalKcal,@JsonKey(name: 'protein_g') int proteinG,@JsonKey(name: 'carbs_g') int carbsG,@JsonKey(name: 'fat_g') int fatG, List<Meal> meals
});




}
/// @nodoc
class _$DailyMealsCopyWithImpl<$Res>
    implements $DailyMealsCopyWith<$Res> {
  _$DailyMealsCopyWithImpl(this._self, this._then);

  final DailyMeals _self;
  final $Res Function(DailyMeals) _then;

/// Create a copy of DailyMeals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? week = null,Object? dayOfWeek = null,Object? totalKcal = null,Object? proteinG = null,Object? carbsG = null,Object? fatG = null,Object? meals = null,}) {
  return _then(_self.copyWith(
week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,totalKcal: null == totalKcal ? _self.totalKcal : totalKcal // ignore: cast_nullable_to_non_nullable
as int,proteinG: null == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as int,carbsG: null == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as int,fatG: null == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as int,meals: null == meals ? _self.meals : meals // ignore: cast_nullable_to_non_nullable
as List<Meal>,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyMeals].
extension DailyMealsPatterns on DailyMeals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyMeals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyMeals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyMeals value)  $default,){
final _that = this;
switch (_that) {
case _DailyMeals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyMeals value)?  $default,){
final _that = this;
switch (_that) {
case _DailyMeals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int week, @JsonKey(name: 'day_of_week')  int dayOfWeek, @JsonKey(name: 'total_kcal')  int totalKcal, @JsonKey(name: 'protein_g')  int proteinG, @JsonKey(name: 'carbs_g')  int carbsG, @JsonKey(name: 'fat_g')  int fatG,  List<Meal> meals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyMeals() when $default != null:
return $default(_that.week,_that.dayOfWeek,_that.totalKcal,_that.proteinG,_that.carbsG,_that.fatG,_that.meals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int week, @JsonKey(name: 'day_of_week')  int dayOfWeek, @JsonKey(name: 'total_kcal')  int totalKcal, @JsonKey(name: 'protein_g')  int proteinG, @JsonKey(name: 'carbs_g')  int carbsG, @JsonKey(name: 'fat_g')  int fatG,  List<Meal> meals)  $default,) {final _that = this;
switch (_that) {
case _DailyMeals():
return $default(_that.week,_that.dayOfWeek,_that.totalKcal,_that.proteinG,_that.carbsG,_that.fatG,_that.meals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int week, @JsonKey(name: 'day_of_week')  int dayOfWeek, @JsonKey(name: 'total_kcal')  int totalKcal, @JsonKey(name: 'protein_g')  int proteinG, @JsonKey(name: 'carbs_g')  int carbsG, @JsonKey(name: 'fat_g')  int fatG,  List<Meal> meals)?  $default,) {final _that = this;
switch (_that) {
case _DailyMeals() when $default != null:
return $default(_that.week,_that.dayOfWeek,_that.totalKcal,_that.proteinG,_that.carbsG,_that.fatG,_that.meals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyMeals implements DailyMeals {
  const _DailyMeals({required this.week, @JsonKey(name: 'day_of_week') required this.dayOfWeek, @JsonKey(name: 'total_kcal') required this.totalKcal, @JsonKey(name: 'protein_g') required this.proteinG, @JsonKey(name: 'carbs_g') required this.carbsG, @JsonKey(name: 'fat_g') required this.fatG, required final  List<Meal> meals}): _meals = meals;
  factory _DailyMeals.fromJson(Map<String, dynamic> json) => _$DailyMealsFromJson(json);

@override final  int week;
@override@JsonKey(name: 'day_of_week') final  int dayOfWeek;
@override@JsonKey(name: 'total_kcal') final  int totalKcal;
@override@JsonKey(name: 'protein_g') final  int proteinG;
@override@JsonKey(name: 'carbs_g') final  int carbsG;
@override@JsonKey(name: 'fat_g') final  int fatG;
 final  List<Meal> _meals;
@override List<Meal> get meals {
  if (_meals is EqualUnmodifiableListView) return _meals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meals);
}


/// Create a copy of DailyMeals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyMealsCopyWith<_DailyMeals> get copyWith => __$DailyMealsCopyWithImpl<_DailyMeals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyMealsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyMeals&&(identical(other.week, week) || other.week == week)&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.totalKcal, totalKcal) || other.totalKcal == totalKcal)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG)&&const DeepCollectionEquality().equals(other._meals, _meals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,week,dayOfWeek,totalKcal,proteinG,carbsG,fatG,const DeepCollectionEquality().hash(_meals));

@override
String toString() {
  return 'DailyMeals(week: $week, dayOfWeek: $dayOfWeek, totalKcal: $totalKcal, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG, meals: $meals)';
}


}

/// @nodoc
abstract mixin class _$DailyMealsCopyWith<$Res> implements $DailyMealsCopyWith<$Res> {
  factory _$DailyMealsCopyWith(_DailyMeals value, $Res Function(_DailyMeals) _then) = __$DailyMealsCopyWithImpl;
@override @useResult
$Res call({
 int week,@JsonKey(name: 'day_of_week') int dayOfWeek,@JsonKey(name: 'total_kcal') int totalKcal,@JsonKey(name: 'protein_g') int proteinG,@JsonKey(name: 'carbs_g') int carbsG,@JsonKey(name: 'fat_g') int fatG, List<Meal> meals
});




}
/// @nodoc
class __$DailyMealsCopyWithImpl<$Res>
    implements _$DailyMealsCopyWith<$Res> {
  __$DailyMealsCopyWithImpl(this._self, this._then);

  final _DailyMeals _self;
  final $Res Function(_DailyMeals) _then;

/// Create a copy of DailyMeals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? week = null,Object? dayOfWeek = null,Object? totalKcal = null,Object? proteinG = null,Object? carbsG = null,Object? fatG = null,Object? meals = null,}) {
  return _then(_DailyMeals(
week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,totalKcal: null == totalKcal ? _self.totalKcal : totalKcal // ignore: cast_nullable_to_non_nullable
as int,proteinG: null == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as int,carbsG: null == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as int,fatG: null == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as int,meals: null == meals ? _self._meals : meals // ignore: cast_nullable_to_non_nullable
as List<Meal>,
  ));
}


}


/// @nodoc
mixin _$Plan {

 int get weeks;@JsonKey(name: 'weekly_structure') String get weeklyStructure;@JsonKey(name: 'goal_summary') String get goalSummary;@JsonKey(name: 'training_days') List<TrainingDay> get trainingDays;@JsonKey(name: 'daily_meals') List<DailyMeals> get dailyMeals; DateTime get startDate;
/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanCopyWith<Plan> get copyWith => _$PlanCopyWithImpl<Plan>(this as Plan, _$identity);

  /// Serializes this Plan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plan&&(identical(other.weeks, weeks) || other.weeks == weeks)&&(identical(other.weeklyStructure, weeklyStructure) || other.weeklyStructure == weeklyStructure)&&(identical(other.goalSummary, goalSummary) || other.goalSummary == goalSummary)&&const DeepCollectionEquality().equals(other.trainingDays, trainingDays)&&const DeepCollectionEquality().equals(other.dailyMeals, dailyMeals)&&(identical(other.startDate, startDate) || other.startDate == startDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weeks,weeklyStructure,goalSummary,const DeepCollectionEquality().hash(trainingDays),const DeepCollectionEquality().hash(dailyMeals),startDate);

@override
String toString() {
  return 'Plan(weeks: $weeks, weeklyStructure: $weeklyStructure, goalSummary: $goalSummary, trainingDays: $trainingDays, dailyMeals: $dailyMeals, startDate: $startDate)';
}


}

/// @nodoc
abstract mixin class $PlanCopyWith<$Res>  {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) _then) = _$PlanCopyWithImpl;
@useResult
$Res call({
 int weeks,@JsonKey(name: 'weekly_structure') String weeklyStructure,@JsonKey(name: 'goal_summary') String goalSummary,@JsonKey(name: 'training_days') List<TrainingDay> trainingDays,@JsonKey(name: 'daily_meals') List<DailyMeals> dailyMeals, DateTime startDate
});




}
/// @nodoc
class _$PlanCopyWithImpl<$Res>
    implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._self, this._then);

  final Plan _self;
  final $Res Function(Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weeks = null,Object? weeklyStructure = null,Object? goalSummary = null,Object? trainingDays = null,Object? dailyMeals = null,Object? startDate = null,}) {
  return _then(_self.copyWith(
weeks: null == weeks ? _self.weeks : weeks // ignore: cast_nullable_to_non_nullable
as int,weeklyStructure: null == weeklyStructure ? _self.weeklyStructure : weeklyStructure // ignore: cast_nullable_to_non_nullable
as String,goalSummary: null == goalSummary ? _self.goalSummary : goalSummary // ignore: cast_nullable_to_non_nullable
as String,trainingDays: null == trainingDays ? _self.trainingDays : trainingDays // ignore: cast_nullable_to_non_nullable
as List<TrainingDay>,dailyMeals: null == dailyMeals ? _self.dailyMeals : dailyMeals // ignore: cast_nullable_to_non_nullable
as List<DailyMeals>,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Plan].
extension PlanPatterns on Plan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Plan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Plan value)  $default,){
final _that = this;
switch (_that) {
case _Plan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Plan value)?  $default,){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int weeks, @JsonKey(name: 'weekly_structure')  String weeklyStructure, @JsonKey(name: 'goal_summary')  String goalSummary, @JsonKey(name: 'training_days')  List<TrainingDay> trainingDays, @JsonKey(name: 'daily_meals')  List<DailyMeals> dailyMeals,  DateTime startDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.weeks,_that.weeklyStructure,_that.goalSummary,_that.trainingDays,_that.dailyMeals,_that.startDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int weeks, @JsonKey(name: 'weekly_structure')  String weeklyStructure, @JsonKey(name: 'goal_summary')  String goalSummary, @JsonKey(name: 'training_days')  List<TrainingDay> trainingDays, @JsonKey(name: 'daily_meals')  List<DailyMeals> dailyMeals,  DateTime startDate)  $default,) {final _that = this;
switch (_that) {
case _Plan():
return $default(_that.weeks,_that.weeklyStructure,_that.goalSummary,_that.trainingDays,_that.dailyMeals,_that.startDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int weeks, @JsonKey(name: 'weekly_structure')  String weeklyStructure, @JsonKey(name: 'goal_summary')  String goalSummary, @JsonKey(name: 'training_days')  List<TrainingDay> trainingDays, @JsonKey(name: 'daily_meals')  List<DailyMeals> dailyMeals,  DateTime startDate)?  $default,) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.weeks,_that.weeklyStructure,_that.goalSummary,_that.trainingDays,_that.dailyMeals,_that.startDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Plan implements Plan {
  const _Plan({required this.weeks, @JsonKey(name: 'weekly_structure') required this.weeklyStructure, @JsonKey(name: 'goal_summary') required this.goalSummary, @JsonKey(name: 'training_days') required final  List<TrainingDay> trainingDays, @JsonKey(name: 'daily_meals') required final  List<DailyMeals> dailyMeals, required this.startDate}): _trainingDays = trainingDays,_dailyMeals = dailyMeals;
  factory _Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

@override final  int weeks;
@override@JsonKey(name: 'weekly_structure') final  String weeklyStructure;
@override@JsonKey(name: 'goal_summary') final  String goalSummary;
 final  List<TrainingDay> _trainingDays;
@override@JsonKey(name: 'training_days') List<TrainingDay> get trainingDays {
  if (_trainingDays is EqualUnmodifiableListView) return _trainingDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trainingDays);
}

 final  List<DailyMeals> _dailyMeals;
@override@JsonKey(name: 'daily_meals') List<DailyMeals> get dailyMeals {
  if (_dailyMeals is EqualUnmodifiableListView) return _dailyMeals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyMeals);
}

@override final  DateTime startDate;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanCopyWith<_Plan> get copyWith => __$PlanCopyWithImpl<_Plan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plan&&(identical(other.weeks, weeks) || other.weeks == weeks)&&(identical(other.weeklyStructure, weeklyStructure) || other.weeklyStructure == weeklyStructure)&&(identical(other.goalSummary, goalSummary) || other.goalSummary == goalSummary)&&const DeepCollectionEquality().equals(other._trainingDays, _trainingDays)&&const DeepCollectionEquality().equals(other._dailyMeals, _dailyMeals)&&(identical(other.startDate, startDate) || other.startDate == startDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weeks,weeklyStructure,goalSummary,const DeepCollectionEquality().hash(_trainingDays),const DeepCollectionEquality().hash(_dailyMeals),startDate);

@override
String toString() {
  return 'Plan(weeks: $weeks, weeklyStructure: $weeklyStructure, goalSummary: $goalSummary, trainingDays: $trainingDays, dailyMeals: $dailyMeals, startDate: $startDate)';
}


}

/// @nodoc
abstract mixin class _$PlanCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$PlanCopyWith(_Plan value, $Res Function(_Plan) _then) = __$PlanCopyWithImpl;
@override @useResult
$Res call({
 int weeks,@JsonKey(name: 'weekly_structure') String weeklyStructure,@JsonKey(name: 'goal_summary') String goalSummary,@JsonKey(name: 'training_days') List<TrainingDay> trainingDays,@JsonKey(name: 'daily_meals') List<DailyMeals> dailyMeals, DateTime startDate
});




}
/// @nodoc
class __$PlanCopyWithImpl<$Res>
    implements _$PlanCopyWith<$Res> {
  __$PlanCopyWithImpl(this._self, this._then);

  final _Plan _self;
  final $Res Function(_Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weeks = null,Object? weeklyStructure = null,Object? goalSummary = null,Object? trainingDays = null,Object? dailyMeals = null,Object? startDate = null,}) {
  return _then(_Plan(
weeks: null == weeks ? _self.weeks : weeks // ignore: cast_nullable_to_non_nullable
as int,weeklyStructure: null == weeklyStructure ? _self.weeklyStructure : weeklyStructure // ignore: cast_nullable_to_non_nullable
as String,goalSummary: null == goalSummary ? _self.goalSummary : goalSummary // ignore: cast_nullable_to_non_nullable
as String,trainingDays: null == trainingDays ? _self._trainingDays : trainingDays // ignore: cast_nullable_to_non_nullable
as List<TrainingDay>,dailyMeals: null == dailyMeals ? _self._dailyMeals : dailyMeals // ignore: cast_nullable_to_non_nullable
as List<DailyMeals>,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
