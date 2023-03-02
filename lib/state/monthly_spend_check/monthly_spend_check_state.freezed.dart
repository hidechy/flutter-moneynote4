// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'monthly_spend_check_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MonthlySpendCheckState {
  List<String> get selectItem => throw _privateConstructorUsedError;
  int get monthTotal => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MonthlySpendCheckStateCopyWith<MonthlySpendCheckState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlySpendCheckStateCopyWith<$Res> {
  factory $MonthlySpendCheckStateCopyWith(MonthlySpendCheckState value,
          $Res Function(MonthlySpendCheckState) then) =
      _$MonthlySpendCheckStateCopyWithImpl<$Res, MonthlySpendCheckState>;
  @useResult
  $Res call({List<String> selectItem, int monthTotal});
}

/// @nodoc
class _$MonthlySpendCheckStateCopyWithImpl<$Res,
        $Val extends MonthlySpendCheckState>
    implements $MonthlySpendCheckStateCopyWith<$Res> {
  _$MonthlySpendCheckStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectItem = null,
    Object? monthTotal = null,
  }) {
    return _then(_value.copyWith(
      selectItem: null == selectItem
          ? _value.selectItem
          : selectItem // ignore: cast_nullable_to_non_nullable
              as List<String>,
      monthTotal: null == monthTotal
          ? _value.monthTotal
          : monthTotal // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MonthlySpendCheckStateCopyWith<$Res>
    implements $MonthlySpendCheckStateCopyWith<$Res> {
  factory _$$_MonthlySpendCheckStateCopyWith(_$_MonthlySpendCheckState value,
          $Res Function(_$_MonthlySpendCheckState) then) =
      __$$_MonthlySpendCheckStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> selectItem, int monthTotal});
}

/// @nodoc
class __$$_MonthlySpendCheckStateCopyWithImpl<$Res>
    extends _$MonthlySpendCheckStateCopyWithImpl<$Res,
        _$_MonthlySpendCheckState>
    implements _$$_MonthlySpendCheckStateCopyWith<$Res> {
  __$$_MonthlySpendCheckStateCopyWithImpl(_$_MonthlySpendCheckState _value,
      $Res Function(_$_MonthlySpendCheckState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectItem = null,
    Object? monthTotal = null,
  }) {
    return _then(_$_MonthlySpendCheckState(
      selectItem: null == selectItem
          ? _value._selectItem
          : selectItem // ignore: cast_nullable_to_non_nullable
              as List<String>,
      monthTotal: null == monthTotal
          ? _value.monthTotal
          : monthTotal // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_MonthlySpendCheckState implements _MonthlySpendCheckState {
  const _$_MonthlySpendCheckState(
      {final List<String> selectItem = const [], this.monthTotal = 0})
      : _selectItem = selectItem;

  final List<String> _selectItem;
  @override
  @JsonKey()
  List<String> get selectItem {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectItem);
  }

  @override
  @JsonKey()
  final int monthTotal;

  @override
  String toString() {
    return 'MonthlySpendCheckState(selectItem: $selectItem, monthTotal: $monthTotal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MonthlySpendCheckState &&
            const DeepCollectionEquality()
                .equals(other._selectItem, _selectItem) &&
            (identical(other.monthTotal, monthTotal) ||
                other.monthTotal == monthTotal));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_selectItem), monthTotal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MonthlySpendCheckStateCopyWith<_$_MonthlySpendCheckState> get copyWith =>
      __$$_MonthlySpendCheckStateCopyWithImpl<_$_MonthlySpendCheckState>(
          this, _$identity);
}

abstract class _MonthlySpendCheckState implements MonthlySpendCheckState {
  const factory _MonthlySpendCheckState(
      {final List<String> selectItem,
      final int monthTotal}) = _$_MonthlySpendCheckState;

  @override
  List<String> get selectItem;
  @override
  int get monthTotal;
  @override
  @JsonKey(ignore: true)
  _$$_MonthlySpendCheckStateCopyWith<_$_MonthlySpendCheckState> get copyWith =>
      throw _privateConstructorUsedError;
}
