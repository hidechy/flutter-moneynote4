// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_transit_param_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RouteTransitParamState {
  String get start => throw _privateConstructorUsedError;
  String get goal => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RouteTransitParamStateCopyWith<RouteTransitParamState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteTransitParamStateCopyWith<$Res> {
  factory $RouteTransitParamStateCopyWith(RouteTransitParamState value,
          $Res Function(RouteTransitParamState) then) =
      _$RouteTransitParamStateCopyWithImpl<$Res, RouteTransitParamState>;
  @useResult
  $Res call({String start, String goal, String startTime});
}

/// @nodoc
class _$RouteTransitParamStateCopyWithImpl<$Res,
        $Val extends RouteTransitParamState>
    implements $RouteTransitParamStateCopyWith<$Res> {
  _$RouteTransitParamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? goal = null,
    Object? startTime = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RouteTransitParamStateCopyWith<$Res>
    implements $RouteTransitParamStateCopyWith<$Res> {
  factory _$$_RouteTransitParamStateCopyWith(_$_RouteTransitParamState value,
          $Res Function(_$_RouteTransitParamState) then) =
      __$$_RouteTransitParamStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String start, String goal, String startTime});
}

/// @nodoc
class __$$_RouteTransitParamStateCopyWithImpl<$Res>
    extends _$RouteTransitParamStateCopyWithImpl<$Res,
        _$_RouteTransitParamState>
    implements _$$_RouteTransitParamStateCopyWith<$Res> {
  __$$_RouteTransitParamStateCopyWithImpl(_$_RouteTransitParamState _value,
      $Res Function(_$_RouteTransitParamState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? goal = null,
    Object? startTime = null,
  }) {
    return _then(_$_RouteTransitParamState(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RouteTransitParamState implements _RouteTransitParamState {
  const _$_RouteTransitParamState(
      {this.start = '', this.goal = '', this.startTime = ''});

  @override
  @JsonKey()
  final String start;
  @override
  @JsonKey()
  final String goal;
  @override
  @JsonKey()
  final String startTime;

  @override
  String toString() {
    return 'RouteTransitParamState(start: $start, goal: $goal, startTime: $startTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RouteTransitParamState &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, start, goal, startTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RouteTransitParamStateCopyWith<_$_RouteTransitParamState> get copyWith =>
      __$$_RouteTransitParamStateCopyWithImpl<_$_RouteTransitParamState>(
          this, _$identity);
}

abstract class _RouteTransitParamState implements RouteTransitParamState {
  const factory _RouteTransitParamState(
      {final String start,
      final String goal,
      final String startTime}) = _$_RouteTransitParamState;

  @override
  String get start;
  @override
  String get goal;
  @override
  String get startTime;
  @override
  @JsonKey(ignore: true)
  _$$_RouteTransitParamStateCopyWith<_$_RouteTransitParamState> get copyWith =>
      throw _privateConstructorUsedError;
}
