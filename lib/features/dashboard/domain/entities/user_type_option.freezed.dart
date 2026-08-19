// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_type_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserTypeOption {

 String get id; UserTypeCode get code;
/// Create a copy of UserTypeOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserTypeOptionCopyWith<UserTypeOption> get copyWith => _$UserTypeOptionCopyWithImpl<UserTypeOption>(this as UserTypeOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserTypeOption&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,id,code);

@override
String toString() {
  return 'UserTypeOption(id: $id, code: $code)';
}


}

/// @nodoc
abstract mixin class $UserTypeOptionCopyWith<$Res>  {
  factory $UserTypeOptionCopyWith(UserTypeOption value, $Res Function(UserTypeOption) _then) = _$UserTypeOptionCopyWithImpl;
@useResult
$Res call({
 String id, UserTypeCode code
});




}
/// @nodoc
class _$UserTypeOptionCopyWithImpl<$Res>
    implements $UserTypeOptionCopyWith<$Res> {
  _$UserTypeOptionCopyWithImpl(this._self, this._then);

  final UserTypeOption _self;
  final $Res Function(UserTypeOption) _then;

/// Create a copy of UserTypeOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as UserTypeCode,
  ));
}

}


/// Adds pattern-matching-related methods to [UserTypeOption].
extension UserTypeOptionPatterns on UserTypeOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserTypeOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserTypeOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserTypeOption value)  $default,){
final _that = this;
switch (_that) {
case _UserTypeOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserTypeOption value)?  $default,){
final _that = this;
switch (_that) {
case _UserTypeOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  UserTypeCode code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserTypeOption() when $default != null:
return $default(_that.id,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  UserTypeCode code)  $default,) {final _that = this;
switch (_that) {
case _UserTypeOption():
return $default(_that.id,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  UserTypeCode code)?  $default,) {final _that = this;
switch (_that) {
case _UserTypeOption() when $default != null:
return $default(_that.id,_that.code);case _:
  return null;

}
}

}

/// @nodoc


class _UserTypeOption implements UserTypeOption {
  const _UserTypeOption({required this.id, required this.code});
  

@override final  String id;
@override final  UserTypeCode code;

/// Create a copy of UserTypeOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserTypeOptionCopyWith<_UserTypeOption> get copyWith => __$UserTypeOptionCopyWithImpl<_UserTypeOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserTypeOption&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,id,code);

@override
String toString() {
  return 'UserTypeOption(id: $id, code: $code)';
}


}

/// @nodoc
abstract mixin class _$UserTypeOptionCopyWith<$Res> implements $UserTypeOptionCopyWith<$Res> {
  factory _$UserTypeOptionCopyWith(_UserTypeOption value, $Res Function(_UserTypeOption) _then) = __$UserTypeOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, UserTypeCode code
});




}
/// @nodoc
class __$UserTypeOptionCopyWithImpl<$Res>
    implements _$UserTypeOptionCopyWith<$Res> {
  __$UserTypeOptionCopyWithImpl(this._self, this._then);

  final _UserTypeOption _self;
  final $Res Function(_UserTypeOption) _then;

/// Create a copy of UserTypeOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,}) {
  return _then(_UserTypeOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as UserTypeCode,
  ));
}


}

// dart format on
