// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardSnapshot {

 int get totalUserCount; double get totalWalletBalance; double get totalRevenue; DashboardWeeklyMetrics get weeklyMetrics; List<AdminUserSummary> get users; List<UserTypeOption> get userTypes;
/// Create a copy of DashboardSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardSnapshotCopyWith<DashboardSnapshot> get copyWith => _$DashboardSnapshotCopyWithImpl<DashboardSnapshot>(this as DashboardSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardSnapshot&&(identical(other.totalUserCount, totalUserCount) || other.totalUserCount == totalUserCount)&&(identical(other.totalWalletBalance, totalWalletBalance) || other.totalWalletBalance == totalWalletBalance)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.weeklyMetrics, weeklyMetrics) || other.weeklyMetrics == weeklyMetrics)&&const DeepCollectionEquality().equals(other.users, users)&&const DeepCollectionEquality().equals(other.userTypes, userTypes));
}


@override
int get hashCode => Object.hash(runtimeType,totalUserCount,totalWalletBalance,totalRevenue,weeklyMetrics,const DeepCollectionEquality().hash(users),const DeepCollectionEquality().hash(userTypes));

@override
String toString() {
  return 'DashboardSnapshot(totalUserCount: $totalUserCount, totalWalletBalance: $totalWalletBalance, totalRevenue: $totalRevenue, weeklyMetrics: $weeklyMetrics, users: $users, userTypes: $userTypes)';
}


}

/// @nodoc
abstract mixin class $DashboardSnapshotCopyWith<$Res>  {
  factory $DashboardSnapshotCopyWith(DashboardSnapshot value, $Res Function(DashboardSnapshot) _then) = _$DashboardSnapshotCopyWithImpl;
@useResult
$Res call({
 int totalUserCount, double totalWalletBalance, double totalRevenue, DashboardWeeklyMetrics weeklyMetrics, List<AdminUserSummary> users, List<UserTypeOption> userTypes
});


$DashboardWeeklyMetricsCopyWith<$Res> get weeklyMetrics;

}
/// @nodoc
class _$DashboardSnapshotCopyWithImpl<$Res>
    implements $DashboardSnapshotCopyWith<$Res> {
  _$DashboardSnapshotCopyWithImpl(this._self, this._then);

  final DashboardSnapshot _self;
  final $Res Function(DashboardSnapshot) _then;

/// Create a copy of DashboardSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalUserCount = null,Object? totalWalletBalance = null,Object? totalRevenue = null,Object? weeklyMetrics = null,Object? users = null,Object? userTypes = null,}) {
  return _then(_self.copyWith(
totalUserCount: null == totalUserCount ? _self.totalUserCount : totalUserCount // ignore: cast_nullable_to_non_nullable
as int,totalWalletBalance: null == totalWalletBalance ? _self.totalWalletBalance : totalWalletBalance // ignore: cast_nullable_to_non_nullable
as double,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,weeklyMetrics: null == weeklyMetrics ? _self.weeklyMetrics : weeklyMetrics // ignore: cast_nullable_to_non_nullable
as DashboardWeeklyMetrics,users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<AdminUserSummary>,userTypes: null == userTypes ? _self.userTypes : userTypes // ignore: cast_nullable_to_non_nullable
as List<UserTypeOption>,
  ));
}
/// Create a copy of DashboardSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardWeeklyMetricsCopyWith<$Res> get weeklyMetrics {
  
  return $DashboardWeeklyMetricsCopyWith<$Res>(_self.weeklyMetrics, (value) {
    return _then(_self.copyWith(weeklyMetrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardSnapshot].
extension DashboardSnapshotPatterns on DashboardSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _DashboardSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalUserCount,  double totalWalletBalance,  double totalRevenue,  DashboardWeeklyMetrics weeklyMetrics,  List<AdminUserSummary> users,  List<UserTypeOption> userTypes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardSnapshot() when $default != null:
return $default(_that.totalUserCount,_that.totalWalletBalance,_that.totalRevenue,_that.weeklyMetrics,_that.users,_that.userTypes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalUserCount,  double totalWalletBalance,  double totalRevenue,  DashboardWeeklyMetrics weeklyMetrics,  List<AdminUserSummary> users,  List<UserTypeOption> userTypes)  $default,) {final _that = this;
switch (_that) {
case _DashboardSnapshot():
return $default(_that.totalUserCount,_that.totalWalletBalance,_that.totalRevenue,_that.weeklyMetrics,_that.users,_that.userTypes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalUserCount,  double totalWalletBalance,  double totalRevenue,  DashboardWeeklyMetrics weeklyMetrics,  List<AdminUserSummary> users,  List<UserTypeOption> userTypes)?  $default,) {final _that = this;
switch (_that) {
case _DashboardSnapshot() when $default != null:
return $default(_that.totalUserCount,_that.totalWalletBalance,_that.totalRevenue,_that.weeklyMetrics,_that.users,_that.userTypes);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardSnapshot implements DashboardSnapshot {
  const _DashboardSnapshot({required this.totalUserCount, required this.totalWalletBalance, required this.totalRevenue, required this.weeklyMetrics, final  List<AdminUserSummary> users = const <AdminUserSummary>[], final  List<UserTypeOption> userTypes = const <UserTypeOption>[]}): _users = users,_userTypes = userTypes;
  

@override final  int totalUserCount;
@override final  double totalWalletBalance;
@override final  double totalRevenue;
@override final  DashboardWeeklyMetrics weeklyMetrics;
 final  List<AdminUserSummary> _users;
@override@JsonKey() List<AdminUserSummary> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

 final  List<UserTypeOption> _userTypes;
@override@JsonKey() List<UserTypeOption> get userTypes {
  if (_userTypes is EqualUnmodifiableListView) return _userTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userTypes);
}


/// Create a copy of DashboardSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardSnapshotCopyWith<_DashboardSnapshot> get copyWith => __$DashboardSnapshotCopyWithImpl<_DashboardSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardSnapshot&&(identical(other.totalUserCount, totalUserCount) || other.totalUserCount == totalUserCount)&&(identical(other.totalWalletBalance, totalWalletBalance) || other.totalWalletBalance == totalWalletBalance)&&(identical(other.totalRevenue, totalRevenue) || other.totalRevenue == totalRevenue)&&(identical(other.weeklyMetrics, weeklyMetrics) || other.weeklyMetrics == weeklyMetrics)&&const DeepCollectionEquality().equals(other._users, _users)&&const DeepCollectionEquality().equals(other._userTypes, _userTypes));
}


@override
int get hashCode => Object.hash(runtimeType,totalUserCount,totalWalletBalance,totalRevenue,weeklyMetrics,const DeepCollectionEquality().hash(_users),const DeepCollectionEquality().hash(_userTypes));

@override
String toString() {
  return 'DashboardSnapshot(totalUserCount: $totalUserCount, totalWalletBalance: $totalWalletBalance, totalRevenue: $totalRevenue, weeklyMetrics: $weeklyMetrics, users: $users, userTypes: $userTypes)';
}


}

/// @nodoc
abstract mixin class _$DashboardSnapshotCopyWith<$Res> implements $DashboardSnapshotCopyWith<$Res> {
  factory _$DashboardSnapshotCopyWith(_DashboardSnapshot value, $Res Function(_DashboardSnapshot) _then) = __$DashboardSnapshotCopyWithImpl;
@override @useResult
$Res call({
 int totalUserCount, double totalWalletBalance, double totalRevenue, DashboardWeeklyMetrics weeklyMetrics, List<AdminUserSummary> users, List<UserTypeOption> userTypes
});


@override $DashboardWeeklyMetricsCopyWith<$Res> get weeklyMetrics;

}
/// @nodoc
class __$DashboardSnapshotCopyWithImpl<$Res>
    implements _$DashboardSnapshotCopyWith<$Res> {
  __$DashboardSnapshotCopyWithImpl(this._self, this._then);

  final _DashboardSnapshot _self;
  final $Res Function(_DashboardSnapshot) _then;

/// Create a copy of DashboardSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalUserCount = null,Object? totalWalletBalance = null,Object? totalRevenue = null,Object? weeklyMetrics = null,Object? users = null,Object? userTypes = null,}) {
  return _then(_DashboardSnapshot(
totalUserCount: null == totalUserCount ? _self.totalUserCount : totalUserCount // ignore: cast_nullable_to_non_nullable
as int,totalWalletBalance: null == totalWalletBalance ? _self.totalWalletBalance : totalWalletBalance // ignore: cast_nullable_to_non_nullable
as double,totalRevenue: null == totalRevenue ? _self.totalRevenue : totalRevenue // ignore: cast_nullable_to_non_nullable
as double,weeklyMetrics: null == weeklyMetrics ? _self.weeklyMetrics : weeklyMetrics // ignore: cast_nullable_to_non_nullable
as DashboardWeeklyMetrics,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<AdminUserSummary>,userTypes: null == userTypes ? _self._userTypes : userTypes // ignore: cast_nullable_to_non_nullable
as List<UserTypeOption>,
  ));
}

/// Create a copy of DashboardSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardWeeklyMetricsCopyWith<$Res> get weeklyMetrics {
  
  return $DashboardWeeklyMetricsCopyWith<$Res>(_self.weeklyMetrics, (value) {
    return _then(_self.copyWith(weeklyMetrics: value));
  });
}
}

// dart format on
