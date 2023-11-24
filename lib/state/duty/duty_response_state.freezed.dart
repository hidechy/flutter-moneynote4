// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duty_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DutyResponseState {
  AsyncValue<List<Duty>> get dutyList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DutyResponseStateCopyWith<DutyResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DutyResponseStateCopyWith<$Res> {
  factory $DutyResponseStateCopyWith(
          DutyResponseState value, $Res Function(DutyResponseState) then) =
      _$DutyResponseStateCopyWithImpl<$Res, DutyResponseState>;
  @useResult
  $Res call({AsyncValue<List<Duty>> dutyList});
}

/// @nodoc
class _$DutyResponseStateCopyWithImpl<$Res, $Val extends DutyResponseState>
    implements $DutyResponseStateCopyWith<$Res> {
  _$DutyResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dutyList = null,
  }) {
    return _then(_value.copyWith(
      dutyList: null == dutyList
          ? _value.dutyList
          : dutyList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Duty>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DutyResponseStateCopyWith<$Res>
    implements $DutyResponseStateCopyWith<$Res> {
  factory _$$_DutyResponseStateCopyWith(_$_DutyResponseState value,
          $Res Function(_$_DutyResponseState) then) =
      __$$_DutyResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<Duty>> dutyList});
}

/// @nodoc
class __$$_DutyResponseStateCopyWithImpl<$Res>
    extends _$DutyResponseStateCopyWithImpl<$Res, _$_DutyResponseState>
    implements _$$_DutyResponseStateCopyWith<$Res> {
  __$$_DutyResponseStateCopyWithImpl(
      _$_DutyResponseState _value, $Res Function(_$_DutyResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dutyList = null,
  }) {
    return _then(_$_DutyResponseState(
      dutyList: null == dutyList
          ? _value.dutyList
          : dutyList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Duty>>,
    ));
  }
}

/// @nodoc

class _$_DutyResponseState implements _DutyResponseState {
  const _$_DutyResponseState(
      {this.dutyList = const AsyncValue<List<Duty>>.loading()});

  @override
  @JsonKey()
  final AsyncValue<List<Duty>> dutyList;

  @override
  String toString() {
    return 'DutyResponseState(dutyList: $dutyList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DutyResponseState &&
            (identical(other.dutyList, dutyList) ||
                other.dutyList == dutyList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dutyList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DutyResponseStateCopyWith<_$_DutyResponseState> get copyWith =>
      __$$_DutyResponseStateCopyWithImpl<_$_DutyResponseState>(
          this, _$identity);
}

abstract class _DutyResponseState implements DutyResponseState {
  const factory _DutyResponseState({final AsyncValue<List<Duty>> dutyList}) =
      _$_DutyResponseState;

  @override
  AsyncValue<List<Duty>> get dutyList;
  @override
  @JsonKey(ignore: true)
  _$$_DutyResponseStateCopyWith<_$_DutyResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}
