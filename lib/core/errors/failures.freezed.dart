// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {

 String get messageKey;
/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this as Failure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.messageKey, messageKey) || other.messageKey == messageKey));
}


@override
int get hashCode => Object.hash(runtimeType,messageKey);

@override
String toString() {
  return 'Failure(messageKey: $messageKey)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res>  {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 String messageKey
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageKey = null,}) {
  return _then(_self.copyWith(
messageKey: null == messageKey ? _self.messageKey : messageKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _AuthFailure value)?  auth,TResult Function( _UnauthorizedFailure value)?  unauthorized,TResult Function( _ServerFailure value)?  server,TResult Function( _NotFoundFailure value)?  notFound,TResult Function( _NetworkFailure value)?  network,TResult Function( _UnknownFailure value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthFailure() when auth != null:
return auth(_that);case _UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case _ServerFailure() when server != null:
return server(_that);case _NotFoundFailure() when notFound != null:
return notFound(_that);case _NetworkFailure() when network != null:
return network(_that);case _UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _AuthFailure value)  auth,required TResult Function( _UnauthorizedFailure value)  unauthorized,required TResult Function( _ServerFailure value)  server,required TResult Function( _NotFoundFailure value)  notFound,required TResult Function( _NetworkFailure value)  network,required TResult Function( _UnknownFailure value)  unknown,}){
final _that = this;
switch (_that) {
case _AuthFailure():
return auth(_that);case _UnauthorizedFailure():
return unauthorized(_that);case _ServerFailure():
return server(_that);case _NotFoundFailure():
return notFound(_that);case _NetworkFailure():
return network(_that);case _UnknownFailure():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _AuthFailure value)?  auth,TResult? Function( _UnauthorizedFailure value)?  unauthorized,TResult? Function( _ServerFailure value)?  server,TResult? Function( _NotFoundFailure value)?  notFound,TResult? Function( _NetworkFailure value)?  network,TResult? Function( _UnknownFailure value)?  unknown,}){
final _that = this;
switch (_that) {
case _AuthFailure() when auth != null:
return auth(_that);case _UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case _ServerFailure() when server != null:
return server(_that);case _NotFoundFailure() when notFound != null:
return notFound(_that);case _NetworkFailure() when network != null:
return network(_that);case _UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String messageKey,  String? code)?  auth,TResult Function( String messageKey)?  unauthorized,TResult Function( String messageKey,  String? code)?  server,TResult Function( String messageKey)?  notFound,TResult Function( String messageKey)?  network,TResult Function( String messageKey)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthFailure() when auth != null:
return auth(_that.messageKey,_that.code);case _UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that.messageKey);case _ServerFailure() when server != null:
return server(_that.messageKey,_that.code);case _NotFoundFailure() when notFound != null:
return notFound(_that.messageKey);case _NetworkFailure() when network != null:
return network(_that.messageKey);case _UnknownFailure() when unknown != null:
return unknown(_that.messageKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String messageKey,  String? code)  auth,required TResult Function( String messageKey)  unauthorized,required TResult Function( String messageKey,  String? code)  server,required TResult Function( String messageKey)  notFound,required TResult Function( String messageKey)  network,required TResult Function( String messageKey)  unknown,}) {final _that = this;
switch (_that) {
case _AuthFailure():
return auth(_that.messageKey,_that.code);case _UnauthorizedFailure():
return unauthorized(_that.messageKey);case _ServerFailure():
return server(_that.messageKey,_that.code);case _NotFoundFailure():
return notFound(_that.messageKey);case _NetworkFailure():
return network(_that.messageKey);case _UnknownFailure():
return unknown(_that.messageKey);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String messageKey,  String? code)?  auth,TResult? Function( String messageKey)?  unauthorized,TResult? Function( String messageKey,  String? code)?  server,TResult? Function( String messageKey)?  notFound,TResult? Function( String messageKey)?  network,TResult? Function( String messageKey)?  unknown,}) {final _that = this;
switch (_that) {
case _AuthFailure() when auth != null:
return auth(_that.messageKey,_that.code);case _UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that.messageKey);case _ServerFailure() when server != null:
return server(_that.messageKey,_that.code);case _NotFoundFailure() when notFound != null:
return notFound(_that.messageKey);case _NetworkFailure() when network != null:
return network(_that.messageKey);case _UnknownFailure() when unknown != null:
return unknown(_that.messageKey);case _:
  return null;

}
}

}

/// @nodoc


class _AuthFailure implements Failure {
  const _AuthFailure({this.messageKey = 'auth.unknown_error', this.code});
  

@override@JsonKey() final  String messageKey;
 final  String? code;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthFailureCopyWith<_AuthFailure> get copyWith => __$AuthFailureCopyWithImpl<_AuthFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthFailure&&(identical(other.messageKey, messageKey) || other.messageKey == messageKey)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,messageKey,code);

@override
String toString() {
  return 'Failure.auth(messageKey: $messageKey, code: $code)';
}


}

/// @nodoc
abstract mixin class _$AuthFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$AuthFailureCopyWith(_AuthFailure value, $Res Function(_AuthFailure) _then) = __$AuthFailureCopyWithImpl;
@override @useResult
$Res call({
 String messageKey, String? code
});




}
/// @nodoc
class __$AuthFailureCopyWithImpl<$Res>
    implements _$AuthFailureCopyWith<$Res> {
  __$AuthFailureCopyWithImpl(this._self, this._then);

  final _AuthFailure _self;
  final $Res Function(_AuthFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageKey = null,Object? code = freezed,}) {
  return _then(_AuthFailure(
messageKey: null == messageKey ? _self.messageKey : messageKey // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _UnauthorizedFailure implements Failure {
  const _UnauthorizedFailure({this.messageKey = 'auth.unauthorized'});
  

@override@JsonKey() final  String messageKey;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnauthorizedFailureCopyWith<_UnauthorizedFailure> get copyWith => __$UnauthorizedFailureCopyWithImpl<_UnauthorizedFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnauthorizedFailure&&(identical(other.messageKey, messageKey) || other.messageKey == messageKey));
}


@override
int get hashCode => Object.hash(runtimeType,messageKey);

@override
String toString() {
  return 'Failure.unauthorized(messageKey: $messageKey)';
}


}

/// @nodoc
abstract mixin class _$UnauthorizedFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$UnauthorizedFailureCopyWith(_UnauthorizedFailure value, $Res Function(_UnauthorizedFailure) _then) = __$UnauthorizedFailureCopyWithImpl;
@override @useResult
$Res call({
 String messageKey
});




}
/// @nodoc
class __$UnauthorizedFailureCopyWithImpl<$Res>
    implements _$UnauthorizedFailureCopyWith<$Res> {
  __$UnauthorizedFailureCopyWithImpl(this._self, this._then);

  final _UnauthorizedFailure _self;
  final $Res Function(_UnauthorizedFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageKey = null,}) {
  return _then(_UnauthorizedFailure(
messageKey: null == messageKey ? _self.messageKey : messageKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ServerFailure implements Failure {
  const _ServerFailure({this.messageKey = 'errors.server_error', this.code});
  

@override@JsonKey() final  String messageKey;
 final  String? code;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerFailureCopyWith<_ServerFailure> get copyWith => __$ServerFailureCopyWithImpl<_ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerFailure&&(identical(other.messageKey, messageKey) || other.messageKey == messageKey)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,messageKey,code);

@override
String toString() {
  return 'Failure.server(messageKey: $messageKey, code: $code)';
}


}

/// @nodoc
abstract mixin class _$ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$ServerFailureCopyWith(_ServerFailure value, $Res Function(_ServerFailure) _then) = __$ServerFailureCopyWithImpl;
@override @useResult
$Res call({
 String messageKey, String? code
});




}
/// @nodoc
class __$ServerFailureCopyWithImpl<$Res>
    implements _$ServerFailureCopyWith<$Res> {
  __$ServerFailureCopyWithImpl(this._self, this._then);

  final _ServerFailure _self;
  final $Res Function(_ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageKey = null,Object? code = freezed,}) {
  return _then(_ServerFailure(
messageKey: null == messageKey ? _self.messageKey : messageKey // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _NotFoundFailure implements Failure {
  const _NotFoundFailure({this.messageKey = 'errors.not_found'});
  

@override@JsonKey() final  String messageKey;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotFoundFailureCopyWith<_NotFoundFailure> get copyWith => __$NotFoundFailureCopyWithImpl<_NotFoundFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotFoundFailure&&(identical(other.messageKey, messageKey) || other.messageKey == messageKey));
}


@override
int get hashCode => Object.hash(runtimeType,messageKey);

@override
String toString() {
  return 'Failure.notFound(messageKey: $messageKey)';
}


}

/// @nodoc
abstract mixin class _$NotFoundFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$NotFoundFailureCopyWith(_NotFoundFailure value, $Res Function(_NotFoundFailure) _then) = __$NotFoundFailureCopyWithImpl;
@override @useResult
$Res call({
 String messageKey
});




}
/// @nodoc
class __$NotFoundFailureCopyWithImpl<$Res>
    implements _$NotFoundFailureCopyWith<$Res> {
  __$NotFoundFailureCopyWithImpl(this._self, this._then);

  final _NotFoundFailure _self;
  final $Res Function(_NotFoundFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageKey = null,}) {
  return _then(_NotFoundFailure(
messageKey: null == messageKey ? _self.messageKey : messageKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _NetworkFailure implements Failure {
  const _NetworkFailure({this.messageKey = 'errors.network'});
  

@override@JsonKey() final  String messageKey;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkFailureCopyWith<_NetworkFailure> get copyWith => __$NetworkFailureCopyWithImpl<_NetworkFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkFailure&&(identical(other.messageKey, messageKey) || other.messageKey == messageKey));
}


@override
int get hashCode => Object.hash(runtimeType,messageKey);

@override
String toString() {
  return 'Failure.network(messageKey: $messageKey)';
}


}

/// @nodoc
abstract mixin class _$NetworkFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$NetworkFailureCopyWith(_NetworkFailure value, $Res Function(_NetworkFailure) _then) = __$NetworkFailureCopyWithImpl;
@override @useResult
$Res call({
 String messageKey
});




}
/// @nodoc
class __$NetworkFailureCopyWithImpl<$Res>
    implements _$NetworkFailureCopyWith<$Res> {
  __$NetworkFailureCopyWithImpl(this._self, this._then);

  final _NetworkFailure _self;
  final $Res Function(_NetworkFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageKey = null,}) {
  return _then(_NetworkFailure(
messageKey: null == messageKey ? _self.messageKey : messageKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UnknownFailure implements Failure {
  const _UnknownFailure({this.messageKey = 'errors.unknown'});
  

@override@JsonKey() final  String messageKey;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnknownFailureCopyWith<_UnknownFailure> get copyWith => __$UnknownFailureCopyWithImpl<_UnknownFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnknownFailure&&(identical(other.messageKey, messageKey) || other.messageKey == messageKey));
}


@override
int get hashCode => Object.hash(runtimeType,messageKey);

@override
String toString() {
  return 'Failure.unknown(messageKey: $messageKey)';
}


}

/// @nodoc
abstract mixin class _$UnknownFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$UnknownFailureCopyWith(_UnknownFailure value, $Res Function(_UnknownFailure) _then) = __$UnknownFailureCopyWithImpl;
@override @useResult
$Res call({
 String messageKey
});




}
/// @nodoc
class __$UnknownFailureCopyWithImpl<$Res>
    implements _$UnknownFailureCopyWith<$Res> {
  __$UnknownFailureCopyWithImpl(this._self, this._then);

  final _UnknownFailure _self;
  final $Res Function(_UnknownFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageKey = null,}) {
  return _then(_UnknownFailure(
messageKey: null == messageKey ? _self.messageKey : messageKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
