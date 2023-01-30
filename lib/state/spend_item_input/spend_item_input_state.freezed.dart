// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'spend_item_input_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpendItemInputState {
  int get itemPos => throw _privateConstructorUsedError;
  List<String> get spendItem => throw _privateConstructorUsedError;
  List<String> get spendPrice => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpendItemInputStateCopyWith<SpendItemInputState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpendItemInputStateCopyWith<$Res> {
  factory $SpendItemInputStateCopyWith(
          SpendItemInputState value, $Res Function(SpendItemInputState) then) =
      _$SpendItemInputStateCopyWithImpl<$Res, SpendItemInputState>;
  @useResult
  $Res call({int itemPos, List<String> spendItem, List<String> spendPrice});
}

/// @nodoc
class _$SpendItemInputStateCopyWithImpl<$Res, $Val extends SpendItemInputState>
    implements $SpendItemInputStateCopyWith<$Res> {
  _$SpendItemInputStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemPos = null,
    Object? spendItem = null,
    Object? spendPrice = null,
  }) {
    return _then(_value.copyWith(
      itemPos: null == itemPos
          ? _value.itemPos
          : itemPos // ignore: cast_nullable_to_non_nullable
              as int,
      spendItem: null == spendItem
          ? _value.spendItem
          : spendItem // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spendPrice: null == spendPrice
          ? _value.spendPrice
          : spendPrice // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SpendItemInputStateCopyWith<$Res>
    implements $SpendItemInputStateCopyWith<$Res> {
  factory _$$_SpendItemInputStateCopyWith(_$_SpendItemInputState value,
          $Res Function(_$_SpendItemInputState) then) =
      __$$_SpendItemInputStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int itemPos, List<String> spendItem, List<String> spendPrice});
}

/// @nodoc
class __$$_SpendItemInputStateCopyWithImpl<$Res>
    extends _$SpendItemInputStateCopyWithImpl<$Res, _$_SpendItemInputState>
    implements _$$_SpendItemInputStateCopyWith<$Res> {
  __$$_SpendItemInputStateCopyWithImpl(_$_SpendItemInputState _value,
      $Res Function(_$_SpendItemInputState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemPos = null,
    Object? spendItem = null,
    Object? spendPrice = null,
  }) {
    return _then(_$_SpendItemInputState(
      itemPos: null == itemPos
          ? _value.itemPos
          : itemPos // ignore: cast_nullable_to_non_nullable
              as int,
      spendItem: null == spendItem
          ? _value._spendItem
          : spendItem // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spendPrice: null == spendPrice
          ? _value._spendPrice
          : spendPrice // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_SpendItemInputState implements _SpendItemInputState {
  const _$_SpendItemInputState(
      {required this.itemPos,
      required final List<String> spendItem,
      required final List<String> spendPrice})
      : _spendItem = spendItem,
        _spendPrice = spendPrice;

  @override
  final int itemPos;
  final List<String> _spendItem;
  @override
  List<String> get spendItem {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spendItem);
  }

  final List<String> _spendPrice;
  @override
  List<String> get spendPrice {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spendPrice);
  }

  @override
  String toString() {
    return 'SpendItemInputState(itemPos: $itemPos, spendItem: $spendItem, spendPrice: $spendPrice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpendItemInputState &&
            (identical(other.itemPos, itemPos) || other.itemPos == itemPos) &&
            const DeepCollectionEquality()
                .equals(other._spendItem, _spendItem) &&
            const DeepCollectionEquality()
                .equals(other._spendPrice, _spendPrice));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      itemPos,
      const DeepCollectionEquality().hash(_spendItem),
      const DeepCollectionEquality().hash(_spendPrice));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpendItemInputStateCopyWith<_$_SpendItemInputState> get copyWith =>
      __$$_SpendItemInputStateCopyWithImpl<_$_SpendItemInputState>(
          this, _$identity);
}

abstract class _SpendItemInputState implements SpendItemInputState {
  const factory _SpendItemInputState(
      {required final int itemPos,
      required final List<String> spendItem,
      required final List<String> spendPrice}) = _$_SpendItemInputState;

  @override
  int get itemPos;
  @override
  List<String> get spendItem;
  @override
  List<String> get spendPrice;
  @override
  @JsonKey(ignore: true)
  _$$_SpendItemInputStateCopyWith<_$_SpendItemInputState> get copyWith =>
      throw _privateConstructorUsedError;
}
