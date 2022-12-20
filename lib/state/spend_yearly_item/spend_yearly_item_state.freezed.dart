// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'spend_yearly_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpendYearlyItemState {
  DateTime get date => throw _privateConstructorUsedError;
  String get item => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpendYearlyItemStateCopyWith<SpendYearlyItemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpendYearlyItemStateCopyWith<$Res> {
  factory $SpendYearlyItemStateCopyWith(SpendYearlyItemState value,
          $Res Function(SpendYearlyItemState) then) =
      _$SpendYearlyItemStateCopyWithImpl<$Res, SpendYearlyItemState>;
  @useResult
  $Res call({DateTime date, String item, int? price});
}

/// @nodoc
class _$SpendYearlyItemStateCopyWithImpl<$Res,
        $Val extends SpendYearlyItemState>
    implements $SpendYearlyItemStateCopyWith<$Res> {
  _$SpendYearlyItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? item = null,
    Object? price = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SpendYearlyItemStateCopyWith<$Res>
    implements $SpendYearlyItemStateCopyWith<$Res> {
  factory _$$_SpendYearlyItemStateCopyWith(_$_SpendYearlyItemState value,
          $Res Function(_$_SpendYearlyItemState) then) =
      __$$_SpendYearlyItemStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, String item, int? price});
}

/// @nodoc
class __$$_SpendYearlyItemStateCopyWithImpl<$Res>
    extends _$SpendYearlyItemStateCopyWithImpl<$Res, _$_SpendYearlyItemState>
    implements _$$_SpendYearlyItemStateCopyWith<$Res> {
  __$$_SpendYearlyItemStateCopyWithImpl(_$_SpendYearlyItemState _value,
      $Res Function(_$_SpendYearlyItemState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? item = null,
    Object? price = freezed,
  }) {
    return _then(_$_SpendYearlyItemState(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_SpendYearlyItemState implements _SpendYearlyItemState {
  const _$_SpendYearlyItemState(
      {required this.date, required this.item, this.price});

  @override
  final DateTime date;
  @override
  final String item;
  @override
  final int? price;

  @override
  String toString() {
    return 'SpendYearlyItemState(date: $date, item: $item, price: $price)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpendYearlyItemState &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, item, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpendYearlyItemStateCopyWith<_$_SpendYearlyItemState> get copyWith =>
      __$$_SpendYearlyItemStateCopyWithImpl<_$_SpendYearlyItemState>(
          this, _$identity);
}

abstract class _SpendYearlyItemState implements SpendYearlyItemState {
  const factory _SpendYearlyItemState(
      {required final DateTime date,
      required final String item,
      final int? price}) = _$_SpendYearlyItemState;

  @override
  DateTime get date;
  @override
  String get item;
  @override
  int? get price;
  @override
  @JsonKey(ignore: true)
  _$$_SpendYearlyItemStateCopyWith<_$_SpendYearlyItemState> get copyWith =>
      throw _privateConstructorUsedError;
}
