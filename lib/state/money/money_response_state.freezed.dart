// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'money_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MoneyResponseState {
  Money? get money => throw _privateConstructorUsedError;
  AsyncValue<List<Money>> get moneyList => throw _privateConstructorUsedError;
  AsyncValue<List<MoneyEveryday>> get moneyEverydayList =>
      throw _privateConstructorUsedError;
  AsyncValue<List<MoneyScore>> get moneyScoreList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MoneyResponseStateCopyWith<MoneyResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyResponseStateCopyWith<$Res> {
  factory $MoneyResponseStateCopyWith(
          MoneyResponseState value, $Res Function(MoneyResponseState) then) =
      _$MoneyResponseStateCopyWithImpl<$Res, MoneyResponseState>;
  @useResult
  $Res call(
      {Money? money,
      AsyncValue<List<Money>> moneyList,
      AsyncValue<List<MoneyEveryday>> moneyEverydayList,
      AsyncValue<List<MoneyScore>> moneyScoreList});
}

/// @nodoc
class _$MoneyResponseStateCopyWithImpl<$Res, $Val extends MoneyResponseState>
    implements $MoneyResponseStateCopyWith<$Res> {
  _$MoneyResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? money = freezed,
    Object? moneyList = null,
    Object? moneyEverydayList = null,
    Object? moneyScoreList = null,
  }) {
    return _then(_value.copyWith(
      money: freezed == money
          ? _value.money
          : money // ignore: cast_nullable_to_non_nullable
              as Money?,
      moneyList: null == moneyList
          ? _value.moneyList
          : moneyList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Money>>,
      moneyEverydayList: null == moneyEverydayList
          ? _value.moneyEverydayList
          : moneyEverydayList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<MoneyEveryday>>,
      moneyScoreList: null == moneyScoreList
          ? _value.moneyScoreList
          : moneyScoreList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<MoneyScore>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoneyResponseStateImplCopyWith<$Res>
    implements $MoneyResponseStateCopyWith<$Res> {
  factory _$$MoneyResponseStateImplCopyWith(_$MoneyResponseStateImpl value,
          $Res Function(_$MoneyResponseStateImpl) then) =
      __$$MoneyResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Money? money,
      AsyncValue<List<Money>> moneyList,
      AsyncValue<List<MoneyEveryday>> moneyEverydayList,
      AsyncValue<List<MoneyScore>> moneyScoreList});
}

/// @nodoc
class __$$MoneyResponseStateImplCopyWithImpl<$Res>
    extends _$MoneyResponseStateCopyWithImpl<$Res, _$MoneyResponseStateImpl>
    implements _$$MoneyResponseStateImplCopyWith<$Res> {
  __$$MoneyResponseStateImplCopyWithImpl(_$MoneyResponseStateImpl _value,
      $Res Function(_$MoneyResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? money = freezed,
    Object? moneyList = null,
    Object? moneyEverydayList = null,
    Object? moneyScoreList = null,
  }) {
    return _then(_$MoneyResponseStateImpl(
      money: freezed == money
          ? _value.money
          : money // ignore: cast_nullable_to_non_nullable
              as Money?,
      moneyList: null == moneyList
          ? _value.moneyList
          : moneyList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Money>>,
      moneyEverydayList: null == moneyEverydayList
          ? _value.moneyEverydayList
          : moneyEverydayList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<MoneyEveryday>>,
      moneyScoreList: null == moneyScoreList
          ? _value.moneyScoreList
          : moneyScoreList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<MoneyScore>>,
    ));
  }
}

/// @nodoc

class _$MoneyResponseStateImpl implements _MoneyResponseState {
  const _$MoneyResponseStateImpl(
      {this.money,
      this.moneyList = const AsyncValue<List<Money>>.loading(),
      this.moneyEverydayList = const AsyncValue<List<MoneyEveryday>>.loading(),
      this.moneyScoreList = const AsyncValue<List<MoneyScore>>.loading()});

  @override
  final Money? money;
  @override
  @JsonKey()
  final AsyncValue<List<Money>> moneyList;
  @override
  @JsonKey()
  final AsyncValue<List<MoneyEveryday>> moneyEverydayList;
  @override
  @JsonKey()
  final AsyncValue<List<MoneyScore>> moneyScoreList;

  @override
  String toString() {
    return 'MoneyResponseState(money: $money, moneyList: $moneyList, moneyEverydayList: $moneyEverydayList, moneyScoreList: $moneyScoreList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoneyResponseStateImpl &&
            (identical(other.money, money) || other.money == money) &&
            (identical(other.moneyList, moneyList) ||
                other.moneyList == moneyList) &&
            (identical(other.moneyEverydayList, moneyEverydayList) ||
                other.moneyEverydayList == moneyEverydayList) &&
            (identical(other.moneyScoreList, moneyScoreList) ||
                other.moneyScoreList == moneyScoreList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, money, moneyList, moneyEverydayList, moneyScoreList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoneyResponseStateImplCopyWith<_$MoneyResponseStateImpl> get copyWith =>
      __$$MoneyResponseStateImplCopyWithImpl<_$MoneyResponseStateImpl>(
          this, _$identity);
}

abstract class _MoneyResponseState implements MoneyResponseState {
  const factory _MoneyResponseState(
          {final Money? money,
          final AsyncValue<List<Money>> moneyList,
          final AsyncValue<List<MoneyEveryday>> moneyEverydayList,
          final AsyncValue<List<MoneyScore>> moneyScoreList}) =
      _$MoneyResponseStateImpl;

  @override
  Money? get money;
  @override
  AsyncValue<List<Money>> get moneyList;
  @override
  AsyncValue<List<MoneyEveryday>> get moneyEverydayList;
  @override
  AsyncValue<List<MoneyScore>> get moneyScoreList;
  @override
  @JsonKey(ignore: true)
  _$$MoneyResponseStateImplCopyWith<_$MoneyResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
