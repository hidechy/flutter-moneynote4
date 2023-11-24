// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BankResponseState {
  BankCompanyChange? get bankCompanyChange =>
      throw _privateConstructorUsedError;
  AsyncValue<List<BankCompanyAll>> get bankCompanyList =>
      throw _privateConstructorUsedError;
  AsyncValue<List<BankMove>> get bankMoveList =>
      throw _privateConstructorUsedError;
  AsyncValue<List<BankMonthlySpend>> get bankMonthlySpendList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BankResponseStateCopyWith<BankResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankResponseStateCopyWith<$Res> {
  factory $BankResponseStateCopyWith(
          BankResponseState value, $Res Function(BankResponseState) then) =
      _$BankResponseStateCopyWithImpl<$Res, BankResponseState>;
  @useResult
  $Res call(
      {BankCompanyChange? bankCompanyChange,
      AsyncValue<List<BankCompanyAll>> bankCompanyList,
      AsyncValue<List<BankMove>> bankMoveList,
      AsyncValue<List<BankMonthlySpend>> bankMonthlySpendList});
}

/// @nodoc
class _$BankResponseStateCopyWithImpl<$Res, $Val extends BankResponseState>
    implements $BankResponseStateCopyWith<$Res> {
  _$BankResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankCompanyChange = freezed,
    Object? bankCompanyList = null,
    Object? bankMoveList = null,
    Object? bankMonthlySpendList = null,
  }) {
    return _then(_value.copyWith(
      bankCompanyChange: freezed == bankCompanyChange
          ? _value.bankCompanyChange
          : bankCompanyChange // ignore: cast_nullable_to_non_nullable
              as BankCompanyChange?,
      bankCompanyList: null == bankCompanyList
          ? _value.bankCompanyList
          : bankCompanyList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<BankCompanyAll>>,
      bankMoveList: null == bankMoveList
          ? _value.bankMoveList
          : bankMoveList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<BankMove>>,
      bankMonthlySpendList: null == bankMonthlySpendList
          ? _value.bankMonthlySpendList
          : bankMonthlySpendList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<BankMonthlySpend>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BankResponseStateImplCopyWith<$Res>
    implements $BankResponseStateCopyWith<$Res> {
  factory _$$BankResponseStateImplCopyWith(_$BankResponseStateImpl value,
          $Res Function(_$BankResponseStateImpl) then) =
      __$$BankResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BankCompanyChange? bankCompanyChange,
      AsyncValue<List<BankCompanyAll>> bankCompanyList,
      AsyncValue<List<BankMove>> bankMoveList,
      AsyncValue<List<BankMonthlySpend>> bankMonthlySpendList});
}

/// @nodoc
class __$$BankResponseStateImplCopyWithImpl<$Res>
    extends _$BankResponseStateCopyWithImpl<$Res, _$BankResponseStateImpl>
    implements _$$BankResponseStateImplCopyWith<$Res> {
  __$$BankResponseStateImplCopyWithImpl(_$BankResponseStateImpl _value,
      $Res Function(_$BankResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankCompanyChange = freezed,
    Object? bankCompanyList = null,
    Object? bankMoveList = null,
    Object? bankMonthlySpendList = null,
  }) {
    return _then(_$BankResponseStateImpl(
      bankCompanyChange: freezed == bankCompanyChange
          ? _value.bankCompanyChange
          : bankCompanyChange // ignore: cast_nullable_to_non_nullable
              as BankCompanyChange?,
      bankCompanyList: null == bankCompanyList
          ? _value.bankCompanyList
          : bankCompanyList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<BankCompanyAll>>,
      bankMoveList: null == bankMoveList
          ? _value.bankMoveList
          : bankMoveList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<BankMove>>,
      bankMonthlySpendList: null == bankMonthlySpendList
          ? _value.bankMonthlySpendList
          : bankMonthlySpendList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<BankMonthlySpend>>,
    ));
  }
}

/// @nodoc

class _$BankResponseStateImpl implements _BankResponseState {
  const _$BankResponseStateImpl(
      {this.bankCompanyChange,
      this.bankCompanyList = const AsyncValue<List<BankCompanyAll>>.loading(),
      this.bankMoveList = const AsyncValue<List<BankMove>>.loading(),
      this.bankMonthlySpendList =
          const AsyncValue<List<BankMonthlySpend>>.loading()});

  @override
  final BankCompanyChange? bankCompanyChange;
  @override
  @JsonKey()
  final AsyncValue<List<BankCompanyAll>> bankCompanyList;
  @override
  @JsonKey()
  final AsyncValue<List<BankMove>> bankMoveList;
  @override
  @JsonKey()
  final AsyncValue<List<BankMonthlySpend>> bankMonthlySpendList;

  @override
  String toString() {
    return 'BankResponseState(bankCompanyChange: $bankCompanyChange, bankCompanyList: $bankCompanyList, bankMoveList: $bankMoveList, bankMonthlySpendList: $bankMonthlySpendList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankResponseStateImpl &&
            (identical(other.bankCompanyChange, bankCompanyChange) ||
                other.bankCompanyChange == bankCompanyChange) &&
            (identical(other.bankCompanyList, bankCompanyList) ||
                other.bankCompanyList == bankCompanyList) &&
            (identical(other.bankMoveList, bankMoveList) ||
                other.bankMoveList == bankMoveList) &&
            (identical(other.bankMonthlySpendList, bankMonthlySpendList) ||
                other.bankMonthlySpendList == bankMonthlySpendList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bankCompanyChange,
      bankCompanyList, bankMoveList, bankMonthlySpendList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BankResponseStateImplCopyWith<_$BankResponseStateImpl> get copyWith =>
      __$$BankResponseStateImplCopyWithImpl<_$BankResponseStateImpl>(
          this, _$identity);
}

abstract class _BankResponseState implements BankResponseState {
  const factory _BankResponseState(
          {final BankCompanyChange? bankCompanyChange,
          final AsyncValue<List<BankCompanyAll>> bankCompanyList,
          final AsyncValue<List<BankMove>> bankMoveList,
          final AsyncValue<List<BankMonthlySpend>> bankMonthlySpendList}) =
      _$BankResponseStateImpl;

  @override
  BankCompanyChange? get bankCompanyChange;
  @override
  AsyncValue<List<BankCompanyAll>> get bankCompanyList;
  @override
  AsyncValue<List<BankMove>> get bankMoveList;
  @override
  AsyncValue<List<BankMonthlySpend>> get bankMonthlySpendList;
  @override
  @JsonKey(ignore: true)
  _$$BankResponseStateImplCopyWith<_$BankResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
