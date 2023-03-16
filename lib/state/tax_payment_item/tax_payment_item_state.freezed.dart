// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tax_payment_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TaxPaymentItemState {
  List<String> get paymentItems => throw _privateConstructorUsedError;
  List<int> get paymentPrices => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaxPaymentItemStateCopyWith<TaxPaymentItemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaxPaymentItemStateCopyWith<$Res> {
  factory $TaxPaymentItemStateCopyWith(
          TaxPaymentItemState value, $Res Function(TaxPaymentItemState) then) =
      _$TaxPaymentItemStateCopyWithImpl<$Res, TaxPaymentItemState>;
  @useResult
  $Res call({List<String> paymentItems, List<int> paymentPrices});
}

/// @nodoc
class _$TaxPaymentItemStateCopyWithImpl<$Res, $Val extends TaxPaymentItemState>
    implements $TaxPaymentItemStateCopyWith<$Res> {
  _$TaxPaymentItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentItems = null,
    Object? paymentPrices = null,
  }) {
    return _then(_value.copyWith(
      paymentItems: null == paymentItems
          ? _value.paymentItems
          : paymentItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      paymentPrices: null == paymentPrices
          ? _value.paymentPrices
          : paymentPrices // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaxPaymentItemStateCopyWith<$Res>
    implements $TaxPaymentItemStateCopyWith<$Res> {
  factory _$$_TaxPaymentItemStateCopyWith(_$_TaxPaymentItemState value,
          $Res Function(_$_TaxPaymentItemState) then) =
      __$$_TaxPaymentItemStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> paymentItems, List<int> paymentPrices});
}

/// @nodoc
class __$$_TaxPaymentItemStateCopyWithImpl<$Res>
    extends _$TaxPaymentItemStateCopyWithImpl<$Res, _$_TaxPaymentItemState>
    implements _$$_TaxPaymentItemStateCopyWith<$Res> {
  __$$_TaxPaymentItemStateCopyWithImpl(_$_TaxPaymentItemState _value,
      $Res Function(_$_TaxPaymentItemState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentItems = null,
    Object? paymentPrices = null,
  }) {
    return _then(_$_TaxPaymentItemState(
      paymentItems: null == paymentItems
          ? _value._paymentItems
          : paymentItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      paymentPrices: null == paymentPrices
          ? _value._paymentPrices
          : paymentPrices // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$_TaxPaymentItemState implements _TaxPaymentItemState {
  const _$_TaxPaymentItemState(
      {final List<String> paymentItems = const [],
      final List<int> paymentPrices = const []})
      : _paymentItems = paymentItems,
        _paymentPrices = paymentPrices;

  final List<String> _paymentItems;
  @override
  @JsonKey()
  List<String> get paymentItems {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentItems);
  }

  final List<int> _paymentPrices;
  @override
  @JsonKey()
  List<int> get paymentPrices {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentPrices);
  }

  @override
  String toString() {
    return 'TaxPaymentItemState(paymentItems: $paymentItems, paymentPrices: $paymentPrices)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaxPaymentItemState &&
            const DeepCollectionEquality()
                .equals(other._paymentItems, _paymentItems) &&
            const DeepCollectionEquality()
                .equals(other._paymentPrices, _paymentPrices));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_paymentItems),
      const DeepCollectionEquality().hash(_paymentPrices));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaxPaymentItemStateCopyWith<_$_TaxPaymentItemState> get copyWith =>
      __$$_TaxPaymentItemStateCopyWithImpl<_$_TaxPaymentItemState>(
          this, _$identity);
}

abstract class _TaxPaymentItemState implements TaxPaymentItemState {
  const factory _TaxPaymentItemState(
      {final List<String> paymentItems,
      final List<int> paymentPrices}) = _$_TaxPaymentItemState;

  @override
  List<String> get paymentItems;
  @override
  List<int> get paymentPrices;
  @override
  @JsonKey(ignore: true)
  _$$_TaxPaymentItemStateCopyWith<_$_TaxPaymentItemState> get copyWith =>
      throw _privateConstructorUsedError;
}
