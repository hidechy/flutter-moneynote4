// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spend_item_input_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpendItemInputState {
  List<String> get spendItem => throw _privateConstructorUsedError;
  List<int> get spendPrice => throw _privateConstructorUsedError;
  int get itemPos => throw _privateConstructorUsedError;
  String get baseDiff => throw _privateConstructorUsedError;
  int get diff => throw _privateConstructorUsedError;
  List<bool> get minusCheck => throw _privateConstructorUsedError;

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
  $Res call(
      {List<String> spendItem,
      List<int> spendPrice,
      int itemPos,
      String baseDiff,
      int diff,
      List<bool> minusCheck});
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
    Object? spendItem = null,
    Object? spendPrice = null,
    Object? itemPos = null,
    Object? baseDiff = null,
    Object? diff = null,
    Object? minusCheck = null,
  }) {
    return _then(_value.copyWith(
      spendItem: null == spendItem
          ? _value.spendItem
          : spendItem // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spendPrice: null == spendPrice
          ? _value.spendPrice
          : spendPrice // ignore: cast_nullable_to_non_nullable
              as List<int>,
      itemPos: null == itemPos
          ? _value.itemPos
          : itemPos // ignore: cast_nullable_to_non_nullable
              as int,
      baseDiff: null == baseDiff
          ? _value.baseDiff
          : baseDiff // ignore: cast_nullable_to_non_nullable
              as String,
      diff: null == diff
          ? _value.diff
          : diff // ignore: cast_nullable_to_non_nullable
              as int,
      minusCheck: null == minusCheck
          ? _value.minusCheck
          : minusCheck // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpendItemInputStateImplCopyWith<$Res>
    implements $SpendItemInputStateCopyWith<$Res> {
  factory _$$SpendItemInputStateImplCopyWith(_$SpendItemInputStateImpl value,
          $Res Function(_$SpendItemInputStateImpl) then) =
      __$$SpendItemInputStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> spendItem,
      List<int> spendPrice,
      int itemPos,
      String baseDiff,
      int diff,
      List<bool> minusCheck});
}

/// @nodoc
class __$$SpendItemInputStateImplCopyWithImpl<$Res>
    extends _$SpendItemInputStateCopyWithImpl<$Res, _$SpendItemInputStateImpl>
    implements _$$SpendItemInputStateImplCopyWith<$Res> {
  __$$SpendItemInputStateImplCopyWithImpl(_$SpendItemInputStateImpl _value,
      $Res Function(_$SpendItemInputStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spendItem = null,
    Object? spendPrice = null,
    Object? itemPos = null,
    Object? baseDiff = null,
    Object? diff = null,
    Object? minusCheck = null,
  }) {
    return _then(_$SpendItemInputStateImpl(
      spendItem: null == spendItem
          ? _value._spendItem
          : spendItem // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spendPrice: null == spendPrice
          ? _value._spendPrice
          : spendPrice // ignore: cast_nullable_to_non_nullable
              as List<int>,
      itemPos: null == itemPos
          ? _value.itemPos
          : itemPos // ignore: cast_nullable_to_non_nullable
              as int,
      baseDiff: null == baseDiff
          ? _value.baseDiff
          : baseDiff // ignore: cast_nullable_to_non_nullable
              as String,
      diff: null == diff
          ? _value.diff
          : diff // ignore: cast_nullable_to_non_nullable
              as int,
      minusCheck: null == minusCheck
          ? _value._minusCheck
          : minusCheck // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ));
  }
}

/// @nodoc

class _$SpendItemInputStateImpl implements _SpendItemInputState {
  const _$SpendItemInputStateImpl(
      {final List<String> spendItem = const [],
      final List<int> spendPrice = const [],
      this.itemPos = 0,
      this.baseDiff = '',
      this.diff = 0,
      final List<bool> minusCheck = const []})
      : _spendItem = spendItem,
        _spendPrice = spendPrice,
        _minusCheck = minusCheck;

  final List<String> _spendItem;
  @override
  @JsonKey()
  List<String> get spendItem {
    if (_spendItem is EqualUnmodifiableListView) return _spendItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spendItem);
  }

  final List<int> _spendPrice;
  @override
  @JsonKey()
  List<int> get spendPrice {
    if (_spendPrice is EqualUnmodifiableListView) return _spendPrice;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spendPrice);
  }

  @override
  @JsonKey()
  final int itemPos;
  @override
  @JsonKey()
  final String baseDiff;
  @override
  @JsonKey()
  final int diff;
  final List<bool> _minusCheck;
  @override
  @JsonKey()
  List<bool> get minusCheck {
    if (_minusCheck is EqualUnmodifiableListView) return _minusCheck;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_minusCheck);
  }

  @override
  String toString() {
    return 'SpendItemInputState(spendItem: $spendItem, spendPrice: $spendPrice, itemPos: $itemPos, baseDiff: $baseDiff, diff: $diff, minusCheck: $minusCheck)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpendItemInputStateImpl &&
            const DeepCollectionEquality()
                .equals(other._spendItem, _spendItem) &&
            const DeepCollectionEquality()
                .equals(other._spendPrice, _spendPrice) &&
            (identical(other.itemPos, itemPos) || other.itemPos == itemPos) &&
            (identical(other.baseDiff, baseDiff) ||
                other.baseDiff == baseDiff) &&
            (identical(other.diff, diff) || other.diff == diff) &&
            const DeepCollectionEquality()
                .equals(other._minusCheck, _minusCheck));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_spendItem),
      const DeepCollectionEquality().hash(_spendPrice),
      itemPos,
      baseDiff,
      diff,
      const DeepCollectionEquality().hash(_minusCheck));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpendItemInputStateImplCopyWith<_$SpendItemInputStateImpl> get copyWith =>
      __$$SpendItemInputStateImplCopyWithImpl<_$SpendItemInputStateImpl>(
          this, _$identity);
}

abstract class _SpendItemInputState implements SpendItemInputState {
  const factory _SpendItemInputState(
      {final List<String> spendItem,
      final List<int> spendPrice,
      final int itemPos,
      final String baseDiff,
      final int diff,
      final List<bool> minusCheck}) = _$SpendItemInputStateImpl;

  @override
  List<String> get spendItem;
  @override
  List<int> get spendPrice;
  @override
  int get itemPos;
  @override
  String get baseDiff;
  @override
  int get diff;
  @override
  List<bool> get minusCheck;
  @override
  @JsonKey(ignore: true)
  _$$SpendItemInputStateImplCopyWith<_$SpendItemInputStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
