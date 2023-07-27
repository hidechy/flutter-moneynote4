// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shintaku_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ShintakuResponseState {
  Shintaku? get lastShintaku => throw _privateConstructorUsedError;
  ShintakuRecord? get lastShintakuRecord => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShintakuResponseStateCopyWith<ShintakuResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShintakuResponseStateCopyWith<$Res> {
  factory $ShintakuResponseStateCopyWith(ShintakuResponseState value,
          $Res Function(ShintakuResponseState) then) =
      _$ShintakuResponseStateCopyWithImpl<$Res, ShintakuResponseState>;
  @useResult
  $Res call({Shintaku? lastShintaku, ShintakuRecord? lastShintakuRecord});
}

/// @nodoc
class _$ShintakuResponseStateCopyWithImpl<$Res,
        $Val extends ShintakuResponseState>
    implements $ShintakuResponseStateCopyWith<$Res> {
  _$ShintakuResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastShintaku = freezed,
    Object? lastShintakuRecord = freezed,
  }) {
    return _then(_value.copyWith(
      lastShintaku: freezed == lastShintaku
          ? _value.lastShintaku
          : lastShintaku // ignore: cast_nullable_to_non_nullable
              as Shintaku?,
      lastShintakuRecord: freezed == lastShintakuRecord
          ? _value.lastShintakuRecord
          : lastShintakuRecord // ignore: cast_nullable_to_non_nullable
              as ShintakuRecord?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShintakuResponseStateCopyWith<$Res>
    implements $ShintakuResponseStateCopyWith<$Res> {
  factory _$$_ShintakuResponseStateCopyWith(_$_ShintakuResponseState value,
          $Res Function(_$_ShintakuResponseState) then) =
      __$$_ShintakuResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Shintaku? lastShintaku, ShintakuRecord? lastShintakuRecord});
}

/// @nodoc
class __$$_ShintakuResponseStateCopyWithImpl<$Res>
    extends _$ShintakuResponseStateCopyWithImpl<$Res, _$_ShintakuResponseState>
    implements _$$_ShintakuResponseStateCopyWith<$Res> {
  __$$_ShintakuResponseStateCopyWithImpl(_$_ShintakuResponseState _value,
      $Res Function(_$_ShintakuResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastShintaku = freezed,
    Object? lastShintakuRecord = freezed,
  }) {
    return _then(_$_ShintakuResponseState(
      lastShintaku: freezed == lastShintaku
          ? _value.lastShintaku
          : lastShintaku // ignore: cast_nullable_to_non_nullable
              as Shintaku?,
      lastShintakuRecord: freezed == lastShintakuRecord
          ? _value.lastShintakuRecord
          : lastShintakuRecord // ignore: cast_nullable_to_non_nullable
              as ShintakuRecord?,
    ));
  }
}

/// @nodoc

class _$_ShintakuResponseState implements _ShintakuResponseState {
  const _$_ShintakuResponseState({this.lastShintaku, this.lastShintakuRecord});

  @override
  final Shintaku? lastShintaku;
  @override
  final ShintakuRecord? lastShintakuRecord;

  @override
  String toString() {
    return 'ShintakuResponseState(lastShintaku: $lastShintaku, lastShintakuRecord: $lastShintakuRecord)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShintakuResponseState &&
            (identical(other.lastShintaku, lastShintaku) ||
                other.lastShintaku == lastShintaku) &&
            (identical(other.lastShintakuRecord, lastShintakuRecord) ||
                other.lastShintakuRecord == lastShintakuRecord));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, lastShintaku, lastShintakuRecord);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShintakuResponseStateCopyWith<_$_ShintakuResponseState> get copyWith =>
      __$$_ShintakuResponseStateCopyWithImpl<_$_ShintakuResponseState>(
          this, _$identity);
}

abstract class _ShintakuResponseState implements ShintakuResponseState {
  const factory _ShintakuResponseState(
      {final Shintaku? lastShintaku,
      final ShintakuRecord? lastShintakuRecord}) = _$_ShintakuResponseState;

  @override
  Shintaku? get lastShintaku;
  @override
  ShintakuRecord? get lastShintakuRecord;
  @override
  @JsonKey(ignore: true)
  _$$_ShintakuResponseStateCopyWith<_$_ShintakuResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}
