// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_location_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TimeLocationResponseState {
  AsyncValue<List<TimeLocation>> get timeLocationList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimeLocationResponseStateCopyWith<TimeLocationResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeLocationResponseStateCopyWith<$Res> {
  factory $TimeLocationResponseStateCopyWith(TimeLocationResponseState value,
          $Res Function(TimeLocationResponseState) then) =
      _$TimeLocationResponseStateCopyWithImpl<$Res, TimeLocationResponseState>;
  @useResult
  $Res call({AsyncValue<List<TimeLocation>> timeLocationList});
}

/// @nodoc
class _$TimeLocationResponseStateCopyWithImpl<$Res,
        $Val extends TimeLocationResponseState>
    implements $TimeLocationResponseStateCopyWith<$Res> {
  _$TimeLocationResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeLocationList = null,
  }) {
    return _then(_value.copyWith(
      timeLocationList: null == timeLocationList
          ? _value.timeLocationList
          : timeLocationList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TimeLocation>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TimeLocationResponseStateCopyWith<$Res>
    implements $TimeLocationResponseStateCopyWith<$Res> {
  factory _$$_TimeLocationResponseStateCopyWith(
          _$_TimeLocationResponseState value,
          $Res Function(_$_TimeLocationResponseState) then) =
      __$$_TimeLocationResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<TimeLocation>> timeLocationList});
}

/// @nodoc
class __$$_TimeLocationResponseStateCopyWithImpl<$Res>
    extends _$TimeLocationResponseStateCopyWithImpl<$Res,
        _$_TimeLocationResponseState>
    implements _$$_TimeLocationResponseStateCopyWith<$Res> {
  __$$_TimeLocationResponseStateCopyWithImpl(
      _$_TimeLocationResponseState _value,
      $Res Function(_$_TimeLocationResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeLocationList = null,
  }) {
    return _then(_$_TimeLocationResponseState(
      timeLocationList: null == timeLocationList
          ? _value.timeLocationList
          : timeLocationList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TimeLocation>>,
    ));
  }
}

/// @nodoc

class _$_TimeLocationResponseState implements _TimeLocationResponseState {
  const _$_TimeLocationResponseState(
      {this.timeLocationList = const AsyncValue<List<TimeLocation>>.loading()});

  @override
  @JsonKey()
  final AsyncValue<List<TimeLocation>> timeLocationList;

  @override
  String toString() {
    return 'TimeLocationResponseState(timeLocationList: $timeLocationList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimeLocationResponseState &&
            (identical(other.timeLocationList, timeLocationList) ||
                other.timeLocationList == timeLocationList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timeLocationList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TimeLocationResponseStateCopyWith<_$_TimeLocationResponseState>
      get copyWith => __$$_TimeLocationResponseStateCopyWithImpl<
          _$_TimeLocationResponseState>(this, _$identity);
}

abstract class _TimeLocationResponseState implements TimeLocationResponseState {
  const factory _TimeLocationResponseState(
          {final AsyncValue<List<TimeLocation>> timeLocationList}) =
      _$_TimeLocationResponseState;

  @override
  AsyncValue<List<TimeLocation>> get timeLocationList;
  @override
  @JsonKey(ignore: true)
  _$$_TimeLocationResponseStateCopyWith<_$_TimeLocationResponseState>
      get copyWith => throw _privateConstructorUsedError;
}
