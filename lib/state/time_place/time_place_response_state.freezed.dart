// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_place_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TimePlaceResponseState {
  AsyncValue<List<SpendTimeplace>> get timePlaceList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimePlaceResponseStateCopyWith<TimePlaceResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimePlaceResponseStateCopyWith<$Res> {
  factory $TimePlaceResponseStateCopyWith(TimePlaceResponseState value,
          $Res Function(TimePlaceResponseState) then) =
      _$TimePlaceResponseStateCopyWithImpl<$Res, TimePlaceResponseState>;
  @useResult
  $Res call({AsyncValue<List<SpendTimeplace>> timePlaceList});
}

/// @nodoc
class _$TimePlaceResponseStateCopyWithImpl<$Res,
        $Val extends TimePlaceResponseState>
    implements $TimePlaceResponseStateCopyWith<$Res> {
  _$TimePlaceResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timePlaceList = null,
  }) {
    return _then(_value.copyWith(
      timePlaceList: null == timePlaceList
          ? _value.timePlaceList
          : timePlaceList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SpendTimeplace>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TimePlaceResponseStateCopyWith<$Res>
    implements $TimePlaceResponseStateCopyWith<$Res> {
  factory _$$_TimePlaceResponseStateCopyWith(_$_TimePlaceResponseState value,
          $Res Function(_$_TimePlaceResponseState) then) =
      __$$_TimePlaceResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<SpendTimeplace>> timePlaceList});
}

/// @nodoc
class __$$_TimePlaceResponseStateCopyWithImpl<$Res>
    extends _$TimePlaceResponseStateCopyWithImpl<$Res,
        _$_TimePlaceResponseState>
    implements _$$_TimePlaceResponseStateCopyWith<$Res> {
  __$$_TimePlaceResponseStateCopyWithImpl(_$_TimePlaceResponseState _value,
      $Res Function(_$_TimePlaceResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timePlaceList = null,
  }) {
    return _then(_$_TimePlaceResponseState(
      timePlaceList: null == timePlaceList
          ? _value.timePlaceList
          : timePlaceList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SpendTimeplace>>,
    ));
  }
}

/// @nodoc

class _$_TimePlaceResponseState implements _TimePlaceResponseState {
  const _$_TimePlaceResponseState(
      {this.timePlaceList = const AsyncValue<List<SpendTimeplace>>.loading()});

  @override
  @JsonKey()
  final AsyncValue<List<SpendTimeplace>> timePlaceList;

  @override
  String toString() {
    return 'TimePlaceResponseState(timePlaceList: $timePlaceList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimePlaceResponseState &&
            (identical(other.timePlaceList, timePlaceList) ||
                other.timePlaceList == timePlaceList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timePlaceList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TimePlaceResponseStateCopyWith<_$_TimePlaceResponseState> get copyWith =>
      __$$_TimePlaceResponseStateCopyWithImpl<_$_TimePlaceResponseState>(
          this, _$identity);
}

abstract class _TimePlaceResponseState implements TimePlaceResponseState {
  const factory _TimePlaceResponseState(
          {final AsyncValue<List<SpendTimeplace>> timePlaceList}) =
      _$_TimePlaceResponseState;

  @override
  AsyncValue<List<SpendTimeplace>> get timePlaceList;
  @override
  @JsonKey(ignore: true)
  _$$_TimePlaceResponseStateCopyWith<_$_TimePlaceResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}
