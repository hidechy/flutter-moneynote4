// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StockResponseState {
  Stock? get lastStock => throw _privateConstructorUsedError;
  StockRecord? get lastStockRecord => throw _privateConstructorUsedError;
  Map<String, AssetsData> get stockMap => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StockResponseStateCopyWith<StockResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockResponseStateCopyWith<$Res> {
  factory $StockResponseStateCopyWith(
          StockResponseState value, $Res Function(StockResponseState) then) =
      _$StockResponseStateCopyWithImpl<$Res, StockResponseState>;
  @useResult
  $Res call(
      {Stock? lastStock,
      StockRecord? lastStockRecord,
      Map<String, AssetsData> stockMap});
}

/// @nodoc
class _$StockResponseStateCopyWithImpl<$Res, $Val extends StockResponseState>
    implements $StockResponseStateCopyWith<$Res> {
  _$StockResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastStock = freezed,
    Object? lastStockRecord = freezed,
    Object? stockMap = null,
  }) {
    return _then(_value.copyWith(
      lastStock: freezed == lastStock
          ? _value.lastStock
          : lastStock // ignore: cast_nullable_to_non_nullable
              as Stock?,
      lastStockRecord: freezed == lastStockRecord
          ? _value.lastStockRecord
          : lastStockRecord // ignore: cast_nullable_to_non_nullable
              as StockRecord?,
      stockMap: null == stockMap
          ? _value.stockMap
          : stockMap // ignore: cast_nullable_to_non_nullable
              as Map<String, AssetsData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockResponseStateImplCopyWith<$Res>
    implements $StockResponseStateCopyWith<$Res> {
  factory _$$StockResponseStateImplCopyWith(_$StockResponseStateImpl value,
          $Res Function(_$StockResponseStateImpl) then) =
      __$$StockResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Stock? lastStock,
      StockRecord? lastStockRecord,
      Map<String, AssetsData> stockMap});
}

/// @nodoc
class __$$StockResponseStateImplCopyWithImpl<$Res>
    extends _$StockResponseStateCopyWithImpl<$Res, _$StockResponseStateImpl>
    implements _$$StockResponseStateImplCopyWith<$Res> {
  __$$StockResponseStateImplCopyWithImpl(_$StockResponseStateImpl _value,
      $Res Function(_$StockResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastStock = freezed,
    Object? lastStockRecord = freezed,
    Object? stockMap = null,
  }) {
    return _then(_$StockResponseStateImpl(
      lastStock: freezed == lastStock
          ? _value.lastStock
          : lastStock // ignore: cast_nullable_to_non_nullable
              as Stock?,
      lastStockRecord: freezed == lastStockRecord
          ? _value.lastStockRecord
          : lastStockRecord // ignore: cast_nullable_to_non_nullable
              as StockRecord?,
      stockMap: null == stockMap
          ? _value._stockMap
          : stockMap // ignore: cast_nullable_to_non_nullable
              as Map<String, AssetsData>,
    ));
  }
}

/// @nodoc

class _$StockResponseStateImpl implements _StockResponseState {
  const _$StockResponseStateImpl(
      {this.lastStock,
      this.lastStockRecord,
      final Map<String, AssetsData> stockMap = const {}})
      : _stockMap = stockMap;

  @override
  final Stock? lastStock;
  @override
  final StockRecord? lastStockRecord;
  final Map<String, AssetsData> _stockMap;
  @override
  @JsonKey()
  Map<String, AssetsData> get stockMap {
    if (_stockMap is EqualUnmodifiableMapView) return _stockMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stockMap);
  }

  @override
  String toString() {
    return 'StockResponseState(lastStock: $lastStock, lastStockRecord: $lastStockRecord, stockMap: $stockMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockResponseStateImpl &&
            (identical(other.lastStock, lastStock) ||
                other.lastStock == lastStock) &&
            (identical(other.lastStockRecord, lastStockRecord) ||
                other.lastStockRecord == lastStockRecord) &&
            const DeepCollectionEquality().equals(other._stockMap, _stockMap));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastStock, lastStockRecord,
      const DeepCollectionEquality().hash(_stockMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StockResponseStateImplCopyWith<_$StockResponseStateImpl> get copyWith =>
      __$$StockResponseStateImplCopyWithImpl<_$StockResponseStateImpl>(
          this, _$identity);
}

abstract class _StockResponseState implements StockResponseState {
  const factory _StockResponseState(
      {final Stock? lastStock,
      final StockRecord? lastStockRecord,
      final Map<String, AssetsData> stockMap}) = _$StockResponseStateImpl;

  @override
  Stock? get lastStock;
  @override
  StockRecord? get lastStockRecord;
  @override
  Map<String, AssetsData> get stockMap;
  @override
  @JsonKey(ignore: true)
  _$$StockResponseStateImplCopyWith<_$StockResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
