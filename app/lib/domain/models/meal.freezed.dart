// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Meal {

 String get slot;// breakfast/lunch/dinner/snack
 String get name; int get kcal;@JsonKey(name: 'protein_g') int get proteinG;@JsonKey(name: 'carbs_g') int get carbsG;@JsonKey(name: 'fat_g') int get fatG; List<String> get ingredients;
/// Create a copy of Meal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MealCopyWith<Meal> get copyWith => _$MealCopyWithImpl<Meal>(this as Meal, _$identity);

  /// Serializes this Meal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Meal&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.name, name) || other.name == name)&&(identical(other.kcal, kcal) || other.kcal == kcal)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG)&&const DeepCollectionEquality().equals(other.ingredients, ingredients));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slot,name,kcal,proteinG,carbsG,fatG,const DeepCollectionEquality().hash(ingredients));

@override
String toString() {
  return 'Meal(slot: $slot, name: $name, kcal: $kcal, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG, ingredients: $ingredients)';
}


}

/// @nodoc
abstract mixin class $MealCopyWith<$Res>  {
  factory $MealCopyWith(Meal value, $Res Function(Meal) _then) = _$MealCopyWithImpl;
@useResult
$Res call({
 String slot, String name, int kcal,@JsonKey(name: 'protein_g') int proteinG,@JsonKey(name: 'carbs_g') int carbsG,@JsonKey(name: 'fat_g') int fatG, List<String> ingredients
});




}
/// @nodoc
class _$MealCopyWithImpl<$Res>
    implements $MealCopyWith<$Res> {
  _$MealCopyWithImpl(this._self, this._then);

  final Meal _self;
  final $Res Function(Meal) _then;

/// Create a copy of Meal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slot = null,Object? name = null,Object? kcal = null,Object? proteinG = null,Object? carbsG = null,Object? fatG = null,Object? ingredients = null,}) {
  return _then(_self.copyWith(
slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kcal: null == kcal ? _self.kcal : kcal // ignore: cast_nullable_to_non_nullable
as int,proteinG: null == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as int,carbsG: null == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as int,fatG: null == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as int,ingredients: null == ingredients ? _self.ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Meal].
extension MealPatterns on Meal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Meal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Meal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Meal value)  $default,){
final _that = this;
switch (_that) {
case _Meal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Meal value)?  $default,){
final _that = this;
switch (_that) {
case _Meal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slot,  String name,  int kcal, @JsonKey(name: 'protein_g')  int proteinG, @JsonKey(name: 'carbs_g')  int carbsG, @JsonKey(name: 'fat_g')  int fatG,  List<String> ingredients)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Meal() when $default != null:
return $default(_that.slot,_that.name,_that.kcal,_that.proteinG,_that.carbsG,_that.fatG,_that.ingredients);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slot,  String name,  int kcal, @JsonKey(name: 'protein_g')  int proteinG, @JsonKey(name: 'carbs_g')  int carbsG, @JsonKey(name: 'fat_g')  int fatG,  List<String> ingredients)  $default,) {final _that = this;
switch (_that) {
case _Meal():
return $default(_that.slot,_that.name,_that.kcal,_that.proteinG,_that.carbsG,_that.fatG,_that.ingredients);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slot,  String name,  int kcal, @JsonKey(name: 'protein_g')  int proteinG, @JsonKey(name: 'carbs_g')  int carbsG, @JsonKey(name: 'fat_g')  int fatG,  List<String> ingredients)?  $default,) {final _that = this;
switch (_that) {
case _Meal() when $default != null:
return $default(_that.slot,_that.name,_that.kcal,_that.proteinG,_that.carbsG,_that.fatG,_that.ingredients);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Meal implements Meal {
  const _Meal({required this.slot, required this.name, required this.kcal, @JsonKey(name: 'protein_g') required this.proteinG, @JsonKey(name: 'carbs_g') required this.carbsG, @JsonKey(name: 'fat_g') required this.fatG, final  List<String> ingredients = const []}): _ingredients = ingredients;
  factory _Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

@override final  String slot;
// breakfast/lunch/dinner/snack
@override final  String name;
@override final  int kcal;
@override@JsonKey(name: 'protein_g') final  int proteinG;
@override@JsonKey(name: 'carbs_g') final  int carbsG;
@override@JsonKey(name: 'fat_g') final  int fatG;
 final  List<String> _ingredients;
@override@JsonKey() List<String> get ingredients {
  if (_ingredients is EqualUnmodifiableListView) return _ingredients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ingredients);
}


/// Create a copy of Meal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MealCopyWith<_Meal> get copyWith => __$MealCopyWithImpl<_Meal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MealToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Meal&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.name, name) || other.name == name)&&(identical(other.kcal, kcal) || other.kcal == kcal)&&(identical(other.proteinG, proteinG) || other.proteinG == proteinG)&&(identical(other.carbsG, carbsG) || other.carbsG == carbsG)&&(identical(other.fatG, fatG) || other.fatG == fatG)&&const DeepCollectionEquality().equals(other._ingredients, _ingredients));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slot,name,kcal,proteinG,carbsG,fatG,const DeepCollectionEquality().hash(_ingredients));

@override
String toString() {
  return 'Meal(slot: $slot, name: $name, kcal: $kcal, proteinG: $proteinG, carbsG: $carbsG, fatG: $fatG, ingredients: $ingredients)';
}


}

/// @nodoc
abstract mixin class _$MealCopyWith<$Res> implements $MealCopyWith<$Res> {
  factory _$MealCopyWith(_Meal value, $Res Function(_Meal) _then) = __$MealCopyWithImpl;
@override @useResult
$Res call({
 String slot, String name, int kcal,@JsonKey(name: 'protein_g') int proteinG,@JsonKey(name: 'carbs_g') int carbsG,@JsonKey(name: 'fat_g') int fatG, List<String> ingredients
});




}
/// @nodoc
class __$MealCopyWithImpl<$Res>
    implements _$MealCopyWith<$Res> {
  __$MealCopyWithImpl(this._self, this._then);

  final _Meal _self;
  final $Res Function(_Meal) _then;

/// Create a copy of Meal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slot = null,Object? name = null,Object? kcal = null,Object? proteinG = null,Object? carbsG = null,Object? fatG = null,Object? ingredients = null,}) {
  return _then(_Meal(
slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kcal: null == kcal ? _self.kcal : kcal // ignore: cast_nullable_to_non_nullable
as int,proteinG: null == proteinG ? _self.proteinG : proteinG // ignore: cast_nullable_to_non_nullable
as int,carbsG: null == carbsG ? _self.carbsG : carbsG // ignore: cast_nullable_to_non_nullable
as int,fatG: null == fatG ? _self.fatG : fatG // ignore: cast_nullable_to_non_nullable
as int,ingredients: null == ingredients ? _self._ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
