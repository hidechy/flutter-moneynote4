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
  List<String> get selectItems => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get checkItems =>
      throw _privateConstructorUsedError;
  int get monthTotal => throw _privateConstructorUsedError;
  dynamic get selectedCategory => throw _privateConstructorUsedError;

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
  $Res call(
      {List<String> selectItems,
      List<Map<String, dynamic>> checkItems,
      int monthTotal,
      dynamic selectedCategory});
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
    Object? selectItems = null,
    Object? checkItems = null,
    Object? monthTotal = null,
    Object? selectedCategory = null,
  }) {
    return _then(_value.copyWith(
      selectItems: null == selectItems
          ? _value.selectItems
          : selectItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      checkItems: null == checkItems
          ? _value.checkItems
          : checkItems // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      monthTotal: null == monthTotal
          ? _value.monthTotal
          : monthTotal // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCategory: null == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as dynamic,
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
  $Res call(
      {List<String> selectItems,
      List<Map<String, dynamic>> checkItems,
      int monthTotal,
      dynamic selectedCategory});
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
    Object? selectItems = null,
    Object? checkItems = null,
    Object? monthTotal = null,
    Object? selectedCategory = null,
  }) {
    return _then(_$_MonthlySpendCheckState(
      selectItems: null == selectItems
          ? _value._selectItems
          : selectItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      checkItems: null == checkItems
          ? _value._checkItems
          : checkItems // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      monthTotal: null == monthTotal
          ? _value.monthTotal
          : monthTotal // ignore: cast_nullable_to_non_nullable
              as int,
      selectedCategory:
          null == selectedCategory ? _value.selectedCategory : selectedCategory,
    ));
  }
}

/// @nodoc

class _$_MonthlySpendCheckState implements _MonthlySpendCheckState {
  const _$_MonthlySpendCheckState(
      {final List<String> selectItems = const [],
      final List<Map<String, dynamic>> checkItems = const [],
      this.monthTotal = 0,
      this.selectedCategory = ''})
      : _selectItems = selectItems,
        _checkItems = checkItems;

  final List<String> _selectItems;
  @override
  @JsonKey()
  List<String> get selectItems {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectItems);
  }

  final List<Map<String, dynamic>> _checkItems;
  @override
  @JsonKey()
  List<Map<String, dynamic>> get checkItems {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_checkItems);
  }

  @override
  @JsonKey()
  final int monthTotal;
  @override
  @JsonKey()
  final dynamic selectedCategory;

  @override
  String toString() {
    return 'MonthlySpendCheckState(selectItems: $selectItems, checkItems: $checkItems, monthTotal: $monthTotal, selectedCategory: $selectedCategory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MonthlySpendCheckState &&
            const DeepCollectionEquality()
                .equals(other._selectItems, _selectItems) &&
            const DeepCollectionEquality()
                .equals(other._checkItems, _checkItems) &&
            (identical(other.monthTotal, monthTotal) ||
                other.monthTotal == monthTotal) &&
            const DeepCollectionEquality()
                .equals(other.selectedCategory, selectedCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_selectItems),
      const DeepCollectionEquality().hash(_checkItems),
      monthTotal,
      const DeepCollectionEquality().hash(selectedCategory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MonthlySpendCheckStateCopyWith<_$_MonthlySpendCheckState> get copyWith =>
      __$$_MonthlySpendCheckStateCopyWithImpl<_$_MonthlySpendCheckState>(
          this, _$identity);
}

abstract class _MonthlySpendCheckState implements MonthlySpendCheckState {
  const factory _MonthlySpendCheckState(
      {final List<String> selectItems,
      final List<Map<String, dynamic>> checkItems,
      final int monthTotal,
      final dynamic selectedCategory}) = _$_MonthlySpendCheckState;

  @override
  List<String> get selectItems;
  @override
  List<Map<String, dynamic>> get checkItems;
  @override
  int get monthTotal;
  @override
  dynamic get selectedCategory;
  @override
  @JsonKey(ignore: true)
  _$$_MonthlySpendCheckStateCopyWith<_$_MonthlySpendCheckState> get copyWith =>
      throw _privateConstructorUsedError;
}
