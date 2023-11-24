// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keihi_list_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$KeihiListResponseState {
  TaxPaymentItem? get taxPaymentItem => throw _privateConstructorUsedError;
  AsyncValue<List<Keihi>> get keihiList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KeihiListResponseStateCopyWith<KeihiListResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeihiListResponseStateCopyWith<$Res> {
  factory $KeihiListResponseStateCopyWith(KeihiListResponseState value,
          $Res Function(KeihiListResponseState) then) =
      _$KeihiListResponseStateCopyWithImpl<$Res, KeihiListResponseState>;
  @useResult
  $Res call(
      {TaxPaymentItem? taxPaymentItem, AsyncValue<List<Keihi>> keihiList});
}

/// @nodoc
class _$KeihiListResponseStateCopyWithImpl<$Res,
        $Val extends KeihiListResponseState>
    implements $KeihiListResponseStateCopyWith<$Res> {
  _$KeihiListResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taxPaymentItem = freezed,
    Object? keihiList = null,
  }) {
    return _then(_value.copyWith(
      taxPaymentItem: freezed == taxPaymentItem
          ? _value.taxPaymentItem
          : taxPaymentItem // ignore: cast_nullable_to_non_nullable
              as TaxPaymentItem?,
      keihiList: null == keihiList
          ? _value.keihiList
          : keihiList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Keihi>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_KeihiListResponseStateCopyWith<$Res>
    implements $KeihiListResponseStateCopyWith<$Res> {
  factory _$$_KeihiListResponseStateCopyWith(_$_KeihiListResponseState value,
          $Res Function(_$_KeihiListResponseState) then) =
      __$$_KeihiListResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TaxPaymentItem? taxPaymentItem, AsyncValue<List<Keihi>> keihiList});
}

/// @nodoc
class __$$_KeihiListResponseStateCopyWithImpl<$Res>
    extends _$KeihiListResponseStateCopyWithImpl<$Res,
        _$_KeihiListResponseState>
    implements _$$_KeihiListResponseStateCopyWith<$Res> {
  __$$_KeihiListResponseStateCopyWithImpl(_$_KeihiListResponseState _value,
      $Res Function(_$_KeihiListResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taxPaymentItem = freezed,
    Object? keihiList = null,
  }) {
    return _then(_$_KeihiListResponseState(
      taxPaymentItem: freezed == taxPaymentItem
          ? _value.taxPaymentItem
          : taxPaymentItem // ignore: cast_nullable_to_non_nullable
              as TaxPaymentItem?,
      keihiList: null == keihiList
          ? _value.keihiList
          : keihiList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Keihi>>,
    ));
  }
}

/// @nodoc

class _$_KeihiListResponseState implements _KeihiListResponseState {
  const _$_KeihiListResponseState(
      {this.taxPaymentItem,
      this.keihiList = const AsyncValue<List<Keihi>>.loading()});

  @override
  final TaxPaymentItem? taxPaymentItem;
  @override
  @JsonKey()
  final AsyncValue<List<Keihi>> keihiList;

  @override
  String toString() {
    return 'KeihiListResponseState(taxPaymentItem: $taxPaymentItem, keihiList: $keihiList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_KeihiListResponseState &&
            (identical(other.taxPaymentItem, taxPaymentItem) ||
                other.taxPaymentItem == taxPaymentItem) &&
            (identical(other.keihiList, keihiList) ||
                other.keihiList == keihiList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taxPaymentItem, keihiList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_KeihiListResponseStateCopyWith<_$_KeihiListResponseState> get copyWith =>
      __$$_KeihiListResponseStateCopyWithImpl<_$_KeihiListResponseState>(
          this, _$identity);
}

abstract class _KeihiListResponseState implements KeihiListResponseState {
  const factory _KeihiListResponseState(
      {final TaxPaymentItem? taxPaymentItem,
      final AsyncValue<List<Keihi>> keihiList}) = _$_KeihiListResponseState;

  @override
  TaxPaymentItem? get taxPaymentItem;
  @override
  AsyncValue<List<Keihi>> get keihiList;
  @override
  @JsonKey(ignore: true)
  _$$_KeihiListResponseStateCopyWith<_$_KeihiListResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}
