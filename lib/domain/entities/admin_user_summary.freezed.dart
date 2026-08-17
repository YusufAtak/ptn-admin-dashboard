// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_user_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminUserSummary {

 String get id; String get email; String get displayName; String get role; String get userType; double get balance;
/// Create a copy of AdminUserSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminUserSummaryCopyWith<AdminUserSummary> get copyWith => _$AdminUserSummaryCopyWithImpl<AdminUserSummary>(this as AdminUserSummary, _$identity);

  /// Serializes this AdminUserSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminUserSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.role, role) || other.role == role)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.balance, balance) || other.balance == balance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,role,userType,balance);

@override
String toString() {
  return 'AdminUserSummary(id: $id, email: $email, displayName: $displayName, role: $role, userType: $userType, balance: $balance)';
}


}

/// @nodoc
abstract mixin class $AdminUserSummaryCopyWith<$Res>  {
  factory $AdminUserSummaryCopyWith(AdminUserSummary value, $Res Function(AdminUserSummary) _then) = _$AdminUserSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String email, String displayName, String role, String userType, double balance
});




}
/// @nodoc
class _$AdminUserSummaryCopyWithImpl<$Res>
    implements $AdminUserSummaryCopyWith<$Res> {
  _$AdminUserSummaryCopyWithImpl(this._self, this._then);

  final AdminUserSummary _self;
  final $Res Function(AdminUserSummary) _then;

/// Create a copy of AdminUserSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? role = null,Object? userType = null,Object? balance = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,userType: null == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminUserSummary].
extension AdminUserSummaryPatterns on AdminUserSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminUserSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminUserSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminUserSummary value)  $default,){
final _that = this;
switch (_that) {
case _AdminUserSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminUserSummary value)?  $default,){
final _that = this;
switch (_that) {
case _AdminUserSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String displayName,  String role,  String userType,  double balance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminUserSummary() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.role,_that.userType,_that.balance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String displayName,  String role,  String userType,  double balance)  $default,) {final _that = this;
switch (_that) {
case _AdminUserSummary():
return $default(_that.id,_that.email,_that.displayName,_that.role,_that.userType,_that.balance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String displayName,  String role,  String userType,  double balance)?  $default,) {final _that = this;
switch (_that) {
case _AdminUserSummary() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.role,_that.userType,_that.balance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminUserSummary implements AdminUserSummary {
  const _AdminUserSummary({required this.id, required this.email, required this.displayName, required this.role, required this.userType, this.balance = 0.0});
  factory _AdminUserSummary.fromJson(Map<String, dynamic> json) => _$AdminUserSummaryFromJson(json);

@override final  String id;
@override final  String email;
@override final  String displayName;
@override final  String role;
@override final  String userType;
@override@JsonKey() final  double balance;

/// Create a copy of AdminUserSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminUserSummaryCopyWith<_AdminUserSummary> get copyWith => __$AdminUserSummaryCopyWithImpl<_AdminUserSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminUserSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminUserSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.role, role) || other.role == role)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.balance, balance) || other.balance == balance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,role,userType,balance);

@override
String toString() {
  return 'AdminUserSummary(id: $id, email: $email, displayName: $displayName, role: $role, userType: $userType, balance: $balance)';
}


}

/// @nodoc
abstract mixin class _$AdminUserSummaryCopyWith<$Res> implements $AdminUserSummaryCopyWith<$Res> {
  factory _$AdminUserSummaryCopyWith(_AdminUserSummary value, $Res Function(_AdminUserSummary) _then) = __$AdminUserSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String displayName, String role, String userType, double balance
});




}
/// @nodoc
class __$AdminUserSummaryCopyWithImpl<$Res>
    implements _$AdminUserSummaryCopyWith<$Res> {
  __$AdminUserSummaryCopyWithImpl(this._self, this._then);

  final _AdminUserSummary _self;
  final $Res Function(_AdminUserSummary) _then;

/// Create a copy of AdminUserSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? role = null,Object? userType = null,Object? balance = null,}) {
  return _then(_AdminUserSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,userType: null == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
