// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState()';
}


}

/// @nodoc
class $DashboardStateCopyWith<$Res>  {
$DashboardStateCopyWith(DashboardState _, $Res Function(DashboardState) __);
}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DashboardInitial value)?  initial,TResult Function( DashboardLoading value)?  loading,TResult Function( DashboardData value)?  data,TResult Function( DashboardFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DashboardInitial() when initial != null:
return initial(_that);case DashboardLoading() when loading != null:
return loading(_that);case DashboardData() when data != null:
return data(_that);case DashboardFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DashboardInitial value)  initial,required TResult Function( DashboardLoading value)  loading,required TResult Function( DashboardData value)  data,required TResult Function( DashboardFailure value)  failure,}){
final _that = this;
switch (_that) {
case DashboardInitial():
return initial(_that);case DashboardLoading():
return loading(_that);case DashboardData():
return data(_that);case DashboardFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DashboardInitial value)?  initial,TResult? Function( DashboardLoading value)?  loading,TResult? Function( DashboardData value)?  data,TResult? Function( DashboardFailure value)?  failure,}){
final _that = this;
switch (_that) {
case DashboardInitial() when initial != null:
return initial(_that);case DashboardLoading() when loading != null:
return loading(_that);case DashboardData() when data != null:
return data(_that);case DashboardFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( DashboardSnapshot snapshot,  Set<String> updatingUserIds,  String? actionMessageKey)?  data,TResult Function( String messageKey)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DashboardInitial() when initial != null:
return initial();case DashboardLoading() when loading != null:
return loading();case DashboardData() when data != null:
return data(_that.snapshot,_that.updatingUserIds,_that.actionMessageKey);case DashboardFailure() when failure != null:
return failure(_that.messageKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( DashboardSnapshot snapshot,  Set<String> updatingUserIds,  String? actionMessageKey)  data,required TResult Function( String messageKey)  failure,}) {final _that = this;
switch (_that) {
case DashboardInitial():
return initial();case DashboardLoading():
return loading();case DashboardData():
return data(_that.snapshot,_that.updatingUserIds,_that.actionMessageKey);case DashboardFailure():
return failure(_that.messageKey);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( DashboardSnapshot snapshot,  Set<String> updatingUserIds,  String? actionMessageKey)?  data,TResult? Function( String messageKey)?  failure,}) {final _that = this;
switch (_that) {
case DashboardInitial() when initial != null:
return initial();case DashboardLoading() when loading != null:
return loading();case DashboardData() when data != null:
return data(_that.snapshot,_that.updatingUserIds,_that.actionMessageKey);case DashboardFailure() when failure != null:
return failure(_that.messageKey);case _:
  return null;

}
}

}

/// @nodoc


class DashboardInitial implements DashboardState {
  const DashboardInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.initial()';
}


}




/// @nodoc


class DashboardLoading implements DashboardState {
  const DashboardLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.loading()';
}


}




/// @nodoc


class DashboardData implements DashboardState {
  const DashboardData({required this.snapshot, final  Set<String> updatingUserIds = const <String>{}, this.actionMessageKey}): _updatingUserIds = updatingUserIds;
  

 final  DashboardSnapshot snapshot;
 final  Set<String> _updatingUserIds;
@JsonKey() Set<String> get updatingUserIds {
  if (_updatingUserIds is EqualUnmodifiableSetView) return _updatingUserIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_updatingUserIds);
}

 final  String? actionMessageKey;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardDataCopyWith<DashboardData> get copyWith => _$DashboardDataCopyWithImpl<DashboardData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardData&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot)&&const DeepCollectionEquality().equals(other._updatingUserIds, _updatingUserIds)&&(identical(other.actionMessageKey, actionMessageKey) || other.actionMessageKey == actionMessageKey));
}


@override
int get hashCode => Object.hash(runtimeType,snapshot,const DeepCollectionEquality().hash(_updatingUserIds),actionMessageKey);

@override
String toString() {
  return 'DashboardState.data(snapshot: $snapshot, updatingUserIds: $updatingUserIds, actionMessageKey: $actionMessageKey)';
}


}

/// @nodoc
abstract mixin class $DashboardDataCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory $DashboardDataCopyWith(DashboardData value, $Res Function(DashboardData) _then) = _$DashboardDataCopyWithImpl;
@useResult
$Res call({
 DashboardSnapshot snapshot, Set<String> updatingUserIds, String? actionMessageKey
});


$DashboardSnapshotCopyWith<$Res> get snapshot;

}
/// @nodoc
class _$DashboardDataCopyWithImpl<$Res>
    implements $DashboardDataCopyWith<$Res> {
  _$DashboardDataCopyWithImpl(this._self, this._then);

  final DashboardData _self;
  final $Res Function(DashboardData) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? snapshot = null,Object? updatingUserIds = null,Object? actionMessageKey = freezed,}) {
  return _then(DashboardData(
snapshot: null == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as DashboardSnapshot,updatingUserIds: null == updatingUserIds ? _self._updatingUserIds : updatingUserIds // ignore: cast_nullable_to_non_nullable
as Set<String>,actionMessageKey: freezed == actionMessageKey ? _self.actionMessageKey : actionMessageKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardSnapshotCopyWith<$Res> get snapshot {
  
  return $DashboardSnapshotCopyWith<$Res>(_self.snapshot, (value) {
    return _then(_self.copyWith(snapshot: value));
  });
}
}

/// @nodoc


class DashboardFailure implements DashboardState {
  const DashboardFailure({required this.messageKey});
  

 final  String messageKey;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardFailureCopyWith<DashboardFailure> get copyWith => _$DashboardFailureCopyWithImpl<DashboardFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardFailure&&(identical(other.messageKey, messageKey) || other.messageKey == messageKey));
}


@override
int get hashCode => Object.hash(runtimeType,messageKey);

@override
String toString() {
  return 'DashboardState.failure(messageKey: $messageKey)';
}


}

/// @nodoc
abstract mixin class $DashboardFailureCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory $DashboardFailureCopyWith(DashboardFailure value, $Res Function(DashboardFailure) _then) = _$DashboardFailureCopyWithImpl;
@useResult
$Res call({
 String messageKey
});




}
/// @nodoc
class _$DashboardFailureCopyWithImpl<$Res>
    implements $DashboardFailureCopyWith<$Res> {
  _$DashboardFailureCopyWithImpl(this._self, this._then);

  final DashboardFailure _self;
  final $Res Function(DashboardFailure) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messageKey = null,}) {
  return _then(DashboardFailure(
messageKey: null == messageKey ? _self.messageKey : messageKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
