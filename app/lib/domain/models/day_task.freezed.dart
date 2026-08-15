// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Workout {

 String get title; int get estimatedMinutes; List<Exercise> get exercises;
/// Create a copy of Workout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutCopyWith<Workout> get copyWith => _$WorkoutCopyWithImpl<Workout>(this as Workout, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Workout&&(identical(other.title, title) || other.title == title)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}


@override
int get hashCode => Object.hash(runtimeType,title,estimatedMinutes,const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'Workout(title: $title, estimatedMinutes: $estimatedMinutes, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $WorkoutCopyWith<$Res>  {
  factory $WorkoutCopyWith(Workout value, $Res Function(Workout) _then) = _$WorkoutCopyWithImpl;
@useResult
$Res call({
 String title, int estimatedMinutes, List<Exercise> exercises
});




}
/// @nodoc
class _$WorkoutCopyWithImpl<$Res>
    implements $WorkoutCopyWith<$Res> {
  _$WorkoutCopyWithImpl(this._self, this._then);

  final Workout _self;
  final $Res Function(Workout) _then;

/// Create a copy of Workout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? estimatedMinutes = null,Object? exercises = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<Exercise>,
  ));
}

}


/// Adds pattern-matching-related methods to [Workout].
extension WorkoutPatterns on Workout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Workout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Workout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Workout value)  $default,){
final _that = this;
switch (_that) {
case _Workout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Workout value)?  $default,){
final _that = this;
switch (_that) {
case _Workout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  int estimatedMinutes,  List<Exercise> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Workout() when $default != null:
return $default(_that.title,_that.estimatedMinutes,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  int estimatedMinutes,  List<Exercise> exercises)  $default,) {final _that = this;
switch (_that) {
case _Workout():
return $default(_that.title,_that.estimatedMinutes,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  int estimatedMinutes,  List<Exercise> exercises)?  $default,) {final _that = this;
switch (_that) {
case _Workout() when $default != null:
return $default(_that.title,_that.estimatedMinutes,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc


class _Workout implements Workout {
  const _Workout({required this.title, required this.estimatedMinutes, required final  List<Exercise> exercises}): _exercises = exercises;
  

@override final  String title;
@override final  int estimatedMinutes;
 final  List<Exercise> _exercises;
@override List<Exercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of Workout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutCopyWith<_Workout> get copyWith => __$WorkoutCopyWithImpl<_Workout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Workout&&(identical(other.title, title) || other.title == title)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}


@override
int get hashCode => Object.hash(runtimeType,title,estimatedMinutes,const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'Workout(title: $title, estimatedMinutes: $estimatedMinutes, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$WorkoutCopyWith<$Res> implements $WorkoutCopyWith<$Res> {
  factory _$WorkoutCopyWith(_Workout value, $Res Function(_Workout) _then) = __$WorkoutCopyWithImpl;
@override @useResult
$Res call({
 String title, int estimatedMinutes, List<Exercise> exercises
});




}
/// @nodoc
class __$WorkoutCopyWithImpl<$Res>
    implements _$WorkoutCopyWith<$Res> {
  __$WorkoutCopyWithImpl(this._self, this._then);

  final _Workout _self;
  final $Res Function(_Workout) _then;

/// Create a copy of Workout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? estimatedMinutes = null,Object? exercises = null,}) {
  return _then(_Workout(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<Exercise>,
  ));
}


}

/// @nodoc
mixin _$DayTask {

 int? get dbId;// 仅从 DB 读出时填，用于 markWorkoutDone/markMealDone
 int get planId; int get dayIndex; DateTime get date; Workout? get workout; List<Meal> get meals; bool get completedWorkout; Map<String, bool> get completedMeals; int get xpAwarded; DateTime? get completedAt;
/// Create a copy of DayTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayTaskCopyWith<DayTask> get copyWith => _$DayTaskCopyWithImpl<DayTask>(this as DayTask, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayTask&&(identical(other.dbId, dbId) || other.dbId == dbId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.dayIndex, dayIndex) || other.dayIndex == dayIndex)&&(identical(other.date, date) || other.date == date)&&(identical(other.workout, workout) || other.workout == workout)&&const DeepCollectionEquality().equals(other.meals, meals)&&(identical(other.completedWorkout, completedWorkout) || other.completedWorkout == completedWorkout)&&const DeepCollectionEquality().equals(other.completedMeals, completedMeals)&&(identical(other.xpAwarded, xpAwarded) || other.xpAwarded == xpAwarded)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,dbId,planId,dayIndex,date,workout,const DeepCollectionEquality().hash(meals),completedWorkout,const DeepCollectionEquality().hash(completedMeals),xpAwarded,completedAt);

@override
String toString() {
  return 'DayTask(dbId: $dbId, planId: $planId, dayIndex: $dayIndex, date: $date, workout: $workout, meals: $meals, completedWorkout: $completedWorkout, completedMeals: $completedMeals, xpAwarded: $xpAwarded, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $DayTaskCopyWith<$Res>  {
  factory $DayTaskCopyWith(DayTask value, $Res Function(DayTask) _then) = _$DayTaskCopyWithImpl;
@useResult
$Res call({
 int? dbId, int planId, int dayIndex, DateTime date, Workout? workout, List<Meal> meals, bool completedWorkout, Map<String, bool> completedMeals, int xpAwarded, DateTime? completedAt
});


$WorkoutCopyWith<$Res>? get workout;

}
/// @nodoc
class _$DayTaskCopyWithImpl<$Res>
    implements $DayTaskCopyWith<$Res> {
  _$DayTaskCopyWithImpl(this._self, this._then);

  final DayTask _self;
  final $Res Function(DayTask) _then;

/// Create a copy of DayTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dbId = freezed,Object? planId = null,Object? dayIndex = null,Object? date = null,Object? workout = freezed,Object? meals = null,Object? completedWorkout = null,Object? completedMeals = null,Object? xpAwarded = null,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
dbId: freezed == dbId ? _self.dbId : dbId // ignore: cast_nullable_to_non_nullable
as int?,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,dayIndex: null == dayIndex ? _self.dayIndex : dayIndex // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,workout: freezed == workout ? _self.workout : workout // ignore: cast_nullable_to_non_nullable
as Workout?,meals: null == meals ? _self.meals : meals // ignore: cast_nullable_to_non_nullable
as List<Meal>,completedWorkout: null == completedWorkout ? _self.completedWorkout : completedWorkout // ignore: cast_nullable_to_non_nullable
as bool,completedMeals: null == completedMeals ? _self.completedMeals : completedMeals // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,xpAwarded: null == xpAwarded ? _self.xpAwarded : xpAwarded // ignore: cast_nullable_to_non_nullable
as int,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of DayTask
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkoutCopyWith<$Res>? get workout {
    if (_self.workout == null) {
    return null;
  }

  return $WorkoutCopyWith<$Res>(_self.workout!, (value) {
    return _then(_self.copyWith(workout: value));
  });
}
}


/// Adds pattern-matching-related methods to [DayTask].
extension DayTaskPatterns on DayTask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayTask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayTask value)  $default,){
final _that = this;
switch (_that) {
case _DayTask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayTask value)?  $default,){
final _that = this;
switch (_that) {
case _DayTask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? dbId,  int planId,  int dayIndex,  DateTime date,  Workout? workout,  List<Meal> meals,  bool completedWorkout,  Map<String, bool> completedMeals,  int xpAwarded,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayTask() when $default != null:
return $default(_that.dbId,_that.planId,_that.dayIndex,_that.date,_that.workout,_that.meals,_that.completedWorkout,_that.completedMeals,_that.xpAwarded,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? dbId,  int planId,  int dayIndex,  DateTime date,  Workout? workout,  List<Meal> meals,  bool completedWorkout,  Map<String, bool> completedMeals,  int xpAwarded,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _DayTask():
return $default(_that.dbId,_that.planId,_that.dayIndex,_that.date,_that.workout,_that.meals,_that.completedWorkout,_that.completedMeals,_that.xpAwarded,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? dbId,  int planId,  int dayIndex,  DateTime date,  Workout? workout,  List<Meal> meals,  bool completedWorkout,  Map<String, bool> completedMeals,  int xpAwarded,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _DayTask() when $default != null:
return $default(_that.dbId,_that.planId,_that.dayIndex,_that.date,_that.workout,_that.meals,_that.completedWorkout,_that.completedMeals,_that.xpAwarded,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc


class _DayTask implements DayTask {
  const _DayTask({this.dbId, required this.planId, required this.dayIndex, required this.date, this.workout, final  List<Meal> meals = const [], this.completedWorkout = false, final  Map<String, bool> completedMeals = const {}, this.xpAwarded = 0, this.completedAt}): _meals = meals,_completedMeals = completedMeals;
  

@override final  int? dbId;
// 仅从 DB 读出时填，用于 markWorkoutDone/markMealDone
@override final  int planId;
@override final  int dayIndex;
@override final  DateTime date;
@override final  Workout? workout;
 final  List<Meal> _meals;
@override@JsonKey() List<Meal> get meals {
  if (_meals is EqualUnmodifiableListView) return _meals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meals);
}

@override@JsonKey() final  bool completedWorkout;
 final  Map<String, bool> _completedMeals;
@override@JsonKey() Map<String, bool> get completedMeals {
  if (_completedMeals is EqualUnmodifiableMapView) return _completedMeals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_completedMeals);
}

@override@JsonKey() final  int xpAwarded;
@override final  DateTime? completedAt;

/// Create a copy of DayTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayTaskCopyWith<_DayTask> get copyWith => __$DayTaskCopyWithImpl<_DayTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayTask&&(identical(other.dbId, dbId) || other.dbId == dbId)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.dayIndex, dayIndex) || other.dayIndex == dayIndex)&&(identical(other.date, date) || other.date == date)&&(identical(other.workout, workout) || other.workout == workout)&&const DeepCollectionEquality().equals(other._meals, _meals)&&(identical(other.completedWorkout, completedWorkout) || other.completedWorkout == completedWorkout)&&const DeepCollectionEquality().equals(other._completedMeals, _completedMeals)&&(identical(other.xpAwarded, xpAwarded) || other.xpAwarded == xpAwarded)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,dbId,planId,dayIndex,date,workout,const DeepCollectionEquality().hash(_meals),completedWorkout,const DeepCollectionEquality().hash(_completedMeals),xpAwarded,completedAt);

@override
String toString() {
  return 'DayTask(dbId: $dbId, planId: $planId, dayIndex: $dayIndex, date: $date, workout: $workout, meals: $meals, completedWorkout: $completedWorkout, completedMeals: $completedMeals, xpAwarded: $xpAwarded, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$DayTaskCopyWith<$Res> implements $DayTaskCopyWith<$Res> {
  factory _$DayTaskCopyWith(_DayTask value, $Res Function(_DayTask) _then) = __$DayTaskCopyWithImpl;
@override @useResult
$Res call({
 int? dbId, int planId, int dayIndex, DateTime date, Workout? workout, List<Meal> meals, bool completedWorkout, Map<String, bool> completedMeals, int xpAwarded, DateTime? completedAt
});


@override $WorkoutCopyWith<$Res>? get workout;

}
/// @nodoc
class __$DayTaskCopyWithImpl<$Res>
    implements _$DayTaskCopyWith<$Res> {
  __$DayTaskCopyWithImpl(this._self, this._then);

  final _DayTask _self;
  final $Res Function(_DayTask) _then;

/// Create a copy of DayTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dbId = freezed,Object? planId = null,Object? dayIndex = null,Object? date = null,Object? workout = freezed,Object? meals = null,Object? completedWorkout = null,Object? completedMeals = null,Object? xpAwarded = null,Object? completedAt = freezed,}) {
  return _then(_DayTask(
dbId: freezed == dbId ? _self.dbId : dbId // ignore: cast_nullable_to_non_nullable
as int?,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,dayIndex: null == dayIndex ? _self.dayIndex : dayIndex // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,workout: freezed == workout ? _self.workout : workout // ignore: cast_nullable_to_non_nullable
as Workout?,meals: null == meals ? _self._meals : meals // ignore: cast_nullable_to_non_nullable
as List<Meal>,completedWorkout: null == completedWorkout ? _self.completedWorkout : completedWorkout // ignore: cast_nullable_to_non_nullable
as bool,completedMeals: null == completedMeals ? _self._completedMeals : completedMeals // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,xpAwarded: null == xpAwarded ? _self.xpAwarded : xpAwarded // ignore: cast_nullable_to_non_nullable
as int,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of DayTask
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkoutCopyWith<$Res>? get workout {
    if (_self.workout == null) {
    return null;
  }

  return $WorkoutCopyWith<$Res>(_self.workout!, (value) {
    return _then(_self.copyWith(workout: value));
  });
}
}

// dart format on
