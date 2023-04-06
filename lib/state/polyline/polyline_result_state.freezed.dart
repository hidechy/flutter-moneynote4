// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'polyline_result_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PolylineResultState {
  LatLngBounds get bounds => throw _privateConstructorUsedError;
  String get distance => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;
  List<PointLatLng> get polylinePoints => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PolylineResultStateCopyWith<PolylineResultState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolylineResultStateCopyWith<$Res> {
  factory $PolylineResultStateCopyWith(
          PolylineResultState value, $Res Function(PolylineResultState) then) =
      _$PolylineResultStateCopyWithImpl<$Res, PolylineResultState>;
  @useResult
  $Res call(
      {LatLngBounds bounds,
      String distance,
      String duration,
      List<PointLatLng> polylinePoints});
}

/// @nodoc
class _$PolylineResultStateCopyWithImpl<$Res, $Val extends PolylineResultState>
    implements $PolylineResultStateCopyWith<$Res> {
  _$PolylineResultStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bounds = null,
    Object? distance = null,
    Object? duration = null,
    Object? polylinePoints = null,
  }) {
    return _then(_value.copyWith(
      bounds: null == bounds
          ? _value.bounds
          : bounds // ignore: cast_nullable_to_non_nullable
              as LatLngBounds,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      polylinePoints: null == polylinePoints
          ? _value.polylinePoints
          : polylinePoints // ignore: cast_nullable_to_non_nullable
              as List<PointLatLng>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PolylineResultStateCopyWith<$Res>
    implements $PolylineResultStateCopyWith<$Res> {
  factory _$$_PolylineResultStateCopyWith(_$_PolylineResultState value,
          $Res Function(_$_PolylineResultState) then) =
      __$$_PolylineResultStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LatLngBounds bounds,
      String distance,
      String duration,
      List<PointLatLng> polylinePoints});
}

/// @nodoc
class __$$_PolylineResultStateCopyWithImpl<$Res>
    extends _$PolylineResultStateCopyWithImpl<$Res, _$_PolylineResultState>
    implements _$$_PolylineResultStateCopyWith<$Res> {
  __$$_PolylineResultStateCopyWithImpl(_$_PolylineResultState _value,
      $Res Function(_$_PolylineResultState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bounds = null,
    Object? distance = null,
    Object? duration = null,
    Object? polylinePoints = null,
  }) {
    return _then(_$_PolylineResultState(
      bounds: null == bounds
          ? _value.bounds
          : bounds // ignore: cast_nullable_to_non_nullable
              as LatLngBounds,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      polylinePoints: null == polylinePoints
          ? _value._polylinePoints
          : polylinePoints // ignore: cast_nullable_to_non_nullable
              as List<PointLatLng>,
    ));
  }
}

/// @nodoc

class _$_PolylineResultState implements _PolylineResultState {
  const _$_PolylineResultState(
      {required this.bounds,
      required this.distance,
      required this.duration,
      required final List<PointLatLng> polylinePoints})
      : _polylinePoints = polylinePoints;

  @override
  final LatLngBounds bounds;
  @override
  final String distance;
  @override
  final String duration;
  final List<PointLatLng> _polylinePoints;
  @override
  List<PointLatLng> get polylinePoints {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_polylinePoints);
  }

  @override
  String toString() {
    return 'PolylineResultState(bounds: $bounds, distance: $distance, duration: $duration, polylinePoints: $polylinePoints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PolylineResultState &&
            (identical(other.bounds, bounds) || other.bounds == bounds) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality()
                .equals(other._polylinePoints, _polylinePoints));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bounds, distance, duration,
      const DeepCollectionEquality().hash(_polylinePoints));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PolylineResultStateCopyWith<_$_PolylineResultState> get copyWith =>
      __$$_PolylineResultStateCopyWithImpl<_$_PolylineResultState>(
          this, _$identity);
}

abstract class _PolylineResultState implements PolylineResultState {
  const factory _PolylineResultState(
          {required final LatLngBounds bounds,
          required final String distance,
          required final String duration,
          required final List<PointLatLng> polylinePoints}) =
      _$_PolylineResultState;

  @override
  LatLngBounds get bounds;
  @override
  String get distance;
  @override
  String get duration;
  @override
  List<PointLatLng> get polylinePoints;
  @override
  @JsonKey(ignore: true)
  _$$_PolylineResultStateCopyWith<_$_PolylineResultState> get copyWith =>
      throw _privateConstructorUsedError;
}
