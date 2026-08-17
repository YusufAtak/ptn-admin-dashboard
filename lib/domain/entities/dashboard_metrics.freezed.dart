// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardDailyMetric {

 DateTime get date; int get rideCount; double get revenue;
/// Create a copy of DashboardDailyMetric
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardDailyMetricCopyWith<DashboardDailyMetric> get copyWith => _$DashboardDailyMetricCopyWithImpl<DashboardDailyMetric>(this as DashboardDailyMetric, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardDailyMetric&&(identical(other.date, date) || other.date == date)&&(identical(other.rideCount, rideCount) || other.rideCount == rideCount)&&(identical(other.revenue, revenue) || other.revenue == revenue));
}


@override
int get hashCode => Object.hash(runtimeType,date,rideCount,revenue);

@override
String toString() {
  return 'DashboardDailyMetric(date: $date, rideCount: $rideCount, revenue: $revenue)';
}


}

/// @nodoc
abstract mixin class $DashboardDailyMetricCopyWith<$Res>  {
  factory $DashboardDailyMetricCopyWith(DashboardDailyMetric value, $Res Function(DashboardDailyMetric) _then) = _$DashboardDailyMetricCopyWithImpl;
@useResult
$Res call({
 DateTime date, int rideCount, double revenue
});




}
/// @nodoc
class _$DashboardDailyMetricCopyWithImpl<$Res>
    implements $DashboardDailyMetricCopyWith<$Res> {
  _$DashboardDailyMetricCopyWithImpl(this._self, this._then);

  final DashboardDailyMetric _self;
  final $Res Function(DashboardDailyMetric) _then;

/// Create a copy of DashboardDailyMetric
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? rideCount = null,Object? revenue = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,rideCount: null == rideCount ? _self.rideCount : rideCount // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardDailyMetric].
extension DashboardDailyMetricPatterns on DashboardDailyMetric {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardDailyMetric value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardDailyMetric() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardDailyMetric value)  $default,){
final _that = this;
switch (_that) {
case _DashboardDailyMetric():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardDailyMetric value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardDailyMetric() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int rideCount,  double revenue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardDailyMetric() when $default != null:
return $default(_that.date,_that.rideCount,_that.revenue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int rideCount,  double revenue)  $default,) {final _that = this;
switch (_that) {
case _DashboardDailyMetric():
return $default(_that.date,_that.rideCount,_that.revenue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int rideCount,  double revenue)?  $default,) {final _that = this;
switch (_that) {
case _DashboardDailyMetric() when $default != null:
return $default(_that.date,_that.rideCount,_that.revenue);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardDailyMetric implements DashboardDailyMetric {
  const _DashboardDailyMetric({required this.date, this.rideCount = 0, this.revenue = 0.0});
  

@override final  DateTime date;
@override@JsonKey() final  int rideCount;
@override@JsonKey() final  double revenue;

/// Create a copy of DashboardDailyMetric
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardDailyMetricCopyWith<_DashboardDailyMetric> get copyWith => __$DashboardDailyMetricCopyWithImpl<_DashboardDailyMetric>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardDailyMetric&&(identical(other.date, date) || other.date == date)&&(identical(other.rideCount, rideCount) || other.rideCount == rideCount)&&(identical(other.revenue, revenue) || other.revenue == revenue));
}


@override
int get hashCode => Object.hash(runtimeType,date,rideCount,revenue);

@override
String toString() {
  return 'DashboardDailyMetric(date: $date, rideCount: $rideCount, revenue: $revenue)';
}


}

/// @nodoc
abstract mixin class _$DashboardDailyMetricCopyWith<$Res> implements $DashboardDailyMetricCopyWith<$Res> {
  factory _$DashboardDailyMetricCopyWith(_DashboardDailyMetric value, $Res Function(_DashboardDailyMetric) _then) = __$DashboardDailyMetricCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int rideCount, double revenue
});




}
/// @nodoc
class __$DashboardDailyMetricCopyWithImpl<$Res>
    implements _$DashboardDailyMetricCopyWith<$Res> {
  __$DashboardDailyMetricCopyWithImpl(this._self, this._then);

  final _DashboardDailyMetric _self;
  final $Res Function(_DashboardDailyMetric) _then;

/// Create a copy of DashboardDailyMetric
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? rideCount = null,Object? revenue = null,}) {
  return _then(_DashboardDailyMetric(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,rideCount: null == rideCount ? _self.rideCount : rideCount // ignore: cast_nullable_to_non_nullable
as int,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$DashboardWeeklyMetrics {

 int get todayRideCount; List<DashboardDailyMetric> get days;
/// Create a copy of DashboardWeeklyMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardWeeklyMetricsCopyWith<DashboardWeeklyMetrics> get copyWith => _$DashboardWeeklyMetricsCopyWithImpl<DashboardWeeklyMetrics>(this as DashboardWeeklyMetrics, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardWeeklyMetrics&&(identical(other.todayRideCount, todayRideCount) || other.todayRideCount == todayRideCount)&&const DeepCollectionEquality().equals(other.days, days));
}


@override
int get hashCode => Object.hash(runtimeType,todayRideCount,const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'DashboardWeeklyMetrics(todayRideCount: $todayRideCount, days: $days)';
}


}

/// @nodoc
abstract mixin class $DashboardWeeklyMetricsCopyWith<$Res>  {
  factory $DashboardWeeklyMetricsCopyWith(DashboardWeeklyMetrics value, $Res Function(DashboardWeeklyMetrics) _then) = _$DashboardWeeklyMetricsCopyWithImpl;
@useResult
$Res call({
 int todayRideCount, List<DashboardDailyMetric> days
});




}
/// @nodoc
class _$DashboardWeeklyMetricsCopyWithImpl<$Res>
    implements $DashboardWeeklyMetricsCopyWith<$Res> {
  _$DashboardWeeklyMetricsCopyWithImpl(this._self, this._then);

  final DashboardWeeklyMetrics _self;
  final $Res Function(DashboardWeeklyMetrics) _then;

/// Create a copy of DashboardWeeklyMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todayRideCount = null,Object? days = null,}) {
  return _then(_self.copyWith(
todayRideCount: null == todayRideCount ? _self.todayRideCount : todayRideCount // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<DashboardDailyMetric>,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardWeeklyMetrics].
extension DashboardWeeklyMetricsPatterns on DashboardWeeklyMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardWeeklyMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardWeeklyMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardWeeklyMetrics value)  $default,){
final _that = this;
switch (_that) {
case _DashboardWeeklyMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardWeeklyMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardWeeklyMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int todayRideCount,  List<DashboardDailyMetric> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardWeeklyMetrics() when $default != null:
return $default(_that.todayRideCount,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int todayRideCount,  List<DashboardDailyMetric> days)  $default,) {final _that = this;
switch (_that) {
case _DashboardWeeklyMetrics():
return $default(_that.todayRideCount,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int todayRideCount,  List<DashboardDailyMetric> days)?  $default,) {final _that = this;
switch (_that) {
case _DashboardWeeklyMetrics() when $default != null:
return $default(_that.todayRideCount,_that.days);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardWeeklyMetrics implements DashboardWeeklyMetrics {
  const _DashboardWeeklyMetrics({this.todayRideCount = 0, final  List<DashboardDailyMetric> days = const <DashboardDailyMetric>[]}): _days = days;
  

@override@JsonKey() final  int todayRideCount;
 final  List<DashboardDailyMetric> _days;
@override@JsonKey() List<DashboardDailyMetric> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of DashboardWeeklyMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardWeeklyMetricsCopyWith<_DashboardWeeklyMetrics> get copyWith => __$DashboardWeeklyMetricsCopyWithImpl<_DashboardWeeklyMetrics>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardWeeklyMetrics&&(identical(other.todayRideCount, todayRideCount) || other.todayRideCount == todayRideCount)&&const DeepCollectionEquality().equals(other._days, _days));
}


@override
int get hashCode => Object.hash(runtimeType,todayRideCount,const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'DashboardWeeklyMetrics(todayRideCount: $todayRideCount, days: $days)';
}


}

/// @nodoc
abstract mixin class _$DashboardWeeklyMetricsCopyWith<$Res> implements $DashboardWeeklyMetricsCopyWith<$Res> {
  factory _$DashboardWeeklyMetricsCopyWith(_DashboardWeeklyMetrics value, $Res Function(_DashboardWeeklyMetrics) _then) = __$DashboardWeeklyMetricsCopyWithImpl;
@override @useResult
$Res call({
 int todayRideCount, List<DashboardDailyMetric> days
});




}
/// @nodoc
class __$DashboardWeeklyMetricsCopyWithImpl<$Res>
    implements _$DashboardWeeklyMetricsCopyWith<$Res> {
  __$DashboardWeeklyMetricsCopyWithImpl(this._self, this._then);

  final _DashboardWeeklyMetrics _self;
  final $Res Function(_DashboardWeeklyMetrics) _then;

/// Create a copy of DashboardWeeklyMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todayRideCount = null,Object? days = null,}) {
  return _then(_DashboardWeeklyMetrics(
todayRideCount: null == todayRideCount ? _self.todayRideCount : todayRideCount // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<DashboardDailyMetric>,
  ));
}


}

// dart format on
