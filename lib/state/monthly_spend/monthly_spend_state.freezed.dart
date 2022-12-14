// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'monthly_spend_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MonthlySpendState {
  List<SpendYearly> get list => throw _privateConstructorUsedError;
  bool get saving => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MonthlySpendStateCopyWith<MonthlySpendState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlySpendStateCopyWith<$Res> {
  factory $MonthlySpendStateCopyWith(
          MonthlySpendState value, $Res Function(MonthlySpendState) then) =
      _$MonthlySpendStateCopyWithImpl<$Res, MonthlySpendState>;
  @useResult
  $Res call({List<SpendYearly> list, bool saving});
}

/// @nodoc
class _$MonthlySpendStateCopyWithImpl<$Res, $Val extends MonthlySpendState>
    implements $MonthlySpendStateCopyWith<$Res> {
  _$MonthlySpendStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? saving = null,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<SpendYearly>,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MonthlySpendStateCopyWith<$Res>
    implements $MonthlySpendStateCopyWith<$Res> {
  factory _$$_MonthlySpendStateCopyWith(_$_MonthlySpendState value,
          $Res Function(_$_MonthlySpendState) then) =
      __$$_MonthlySpendStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SpendYearly> list, bool saving});
}

/// @nodoc
class __$$_MonthlySpendStateCopyWithImpl<$Res>
    extends _$MonthlySpendStateCopyWithImpl<$Res, _$_MonthlySpendState>
    implements _$$_MonthlySpendStateCopyWith<$Res> {
  __$$_MonthlySpendStateCopyWithImpl(
      _$_MonthlySpendState _value, $Res Function(_$_MonthlySpendState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? saving = null,
  }) {
    return _then(_$_MonthlySpendState(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<SpendYearly>,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_MonthlySpendState implements _MonthlySpendState {
  const _$_MonthlySpendState(
      {final List<SpendYearly> list = const [], this.saving = false})
      : _list = list;

  final List<SpendYearly> _list;
  @override
  @JsonKey()
  List<SpendYearly> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final bool saving;

  @override
  String toString() {
    return 'MonthlySpendState(list: $list, saving: $saving)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MonthlySpendState &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.saving, saving) || other.saving == saving));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_list), saving);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MonthlySpendStateCopyWith<_$_MonthlySpendState> get copyWith =>
      __$$_MonthlySpendStateCopyWithImpl<_$_MonthlySpendState>(
          this, _$identity);
}

abstract class _MonthlySpendState implements MonthlySpendState {
  const factory _MonthlySpendState(
      {final List<SpendYearly> list, final bool saving}) = _$_MonthlySpendState;

  @override
  List<SpendYearly> get list;
  @override
  bool get saving;
  @override
  @JsonKey(ignore: true)
  _$$_MonthlySpendStateCopyWith<_$_MonthlySpendState> get copyWith =>
      throw _privateConstructorUsedError;
}
