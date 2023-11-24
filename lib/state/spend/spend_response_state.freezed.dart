// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spend_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpendResponseState {
  AsyncValue<List<SpendSummary>> get spendSummaryList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpendResponseStateCopyWith<SpendResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpendResponseStateCopyWith<$Res> {
  factory $SpendResponseStateCopyWith(
          SpendResponseState value, $Res Function(SpendResponseState) then) =
      _$SpendResponseStateCopyWithImpl<$Res, SpendResponseState>;
  @useResult
  $Res call({AsyncValue<List<SpendSummary>> spendSummaryList});
}

/// @nodoc
class _$SpendResponseStateCopyWithImpl<$Res, $Val extends SpendResponseState>
    implements $SpendResponseStateCopyWith<$Res> {
  _$SpendResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spendSummaryList = null,
  }) {
    return _then(_value.copyWith(
      spendSummaryList: null == spendSummaryList
          ? _value.spendSummaryList
          : spendSummaryList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SpendSummary>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpendResponseStateImplCopyWith<$Res>
    implements $SpendResponseStateCopyWith<$Res> {
  factory _$$SpendResponseStateImplCopyWith(_$SpendResponseStateImpl value,
          $Res Function(_$SpendResponseStateImpl) then) =
      __$$SpendResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<SpendSummary>> spendSummaryList});
}

/// @nodoc
class __$$SpendResponseStateImplCopyWithImpl<$Res>
    extends _$SpendResponseStateCopyWithImpl<$Res, _$SpendResponseStateImpl>
    implements _$$SpendResponseStateImplCopyWith<$Res> {
  __$$SpendResponseStateImplCopyWithImpl(_$SpendResponseStateImpl _value,
      $Res Function(_$SpendResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spendSummaryList = null,
  }) {
    return _then(_$SpendResponseStateImpl(
      spendSummaryList: null == spendSummaryList
          ? _value.spendSummaryList
          : spendSummaryList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SpendSummary>>,
    ));
  }
}

/// @nodoc

class _$SpendResponseStateImpl implements _SpendResponseState {
  const _$SpendResponseStateImpl(
      {this.spendSummaryList = const AsyncValue<List<SpendSummary>>.loading()});

  @override
  @JsonKey()
  final AsyncValue<List<SpendSummary>> spendSummaryList;

  @override
  String toString() {
    return 'SpendResponseState(spendSummaryList: $spendSummaryList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpendResponseStateImpl &&
            (identical(other.spendSummaryList, spendSummaryList) ||
                other.spendSummaryList == spendSummaryList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, spendSummaryList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpendResponseStateImplCopyWith<_$SpendResponseStateImpl> get copyWith =>
      __$$SpendResponseStateImplCopyWithImpl<_$SpendResponseStateImpl>(
          this, _$identity);
}

abstract class _SpendResponseState implements SpendResponseState {
  const factory _SpendResponseState(
          {final AsyncValue<List<SpendSummary>> spendSummaryList}) =
      _$SpendResponseStateImpl;

  @override
  AsyncValue<List<SpendSummary>> get spendSummaryList;
  @override
  @JsonKey(ignore: true)
  _$$SpendResponseStateImplCopyWith<_$SpendResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
