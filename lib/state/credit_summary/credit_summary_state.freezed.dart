// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'credit_summary_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreditSummaryState {
  List<CreditSummary> get list => throw _privateConstructorUsedError;
  bool get saving => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreditSummaryStateCopyWith<CreditSummaryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditSummaryStateCopyWith<$Res> {
  factory $CreditSummaryStateCopyWith(
          CreditSummaryState value, $Res Function(CreditSummaryState) then) =
      _$CreditSummaryStateCopyWithImpl<$Res, CreditSummaryState>;
  @useResult
  $Res call({List<CreditSummary> list, bool saving});
}

/// @nodoc
class _$CreditSummaryStateCopyWithImpl<$Res, $Val extends CreditSummaryState>
    implements $CreditSummaryStateCopyWith<$Res> {
  _$CreditSummaryStateCopyWithImpl(this._value, this._then);

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
              as List<CreditSummary>,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreditSummaryStateCopyWith<$Res>
    implements $CreditSummaryStateCopyWith<$Res> {
  factory _$$_CreditSummaryStateCopyWith(_$_CreditSummaryState value,
          $Res Function(_$_CreditSummaryState) then) =
      __$$_CreditSummaryStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CreditSummary> list, bool saving});
}

/// @nodoc
class __$$_CreditSummaryStateCopyWithImpl<$Res>
    extends _$CreditSummaryStateCopyWithImpl<$Res, _$_CreditSummaryState>
    implements _$$_CreditSummaryStateCopyWith<$Res> {
  __$$_CreditSummaryStateCopyWithImpl(
      _$_CreditSummaryState _value, $Res Function(_$_CreditSummaryState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? saving = null,
  }) {
    return _then(_$_CreditSummaryState(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<CreditSummary>,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CreditSummaryState implements _CreditSummaryState {
  const _$_CreditSummaryState(
      {final List<CreditSummary> list = const [], this.saving = false})
      : _list = list;

  final List<CreditSummary> _list;
  @override
  @JsonKey()
  List<CreditSummary> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final bool saving;

  @override
  String toString() {
    return 'CreditSummaryState(list: $list, saving: $saving)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreditSummaryState &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.saving, saving) || other.saving == saving));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_list), saving);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreditSummaryStateCopyWith<_$_CreditSummaryState> get copyWith =>
      __$$_CreditSummaryStateCopyWithImpl<_$_CreditSummaryState>(
          this, _$identity);
}

abstract class _CreditSummaryState implements CreditSummaryState {
  const factory _CreditSummaryState(
      {final List<CreditSummary> list,
      final bool saving}) = _$_CreditSummaryState;

  @override
  List<CreditSummary> get list;
  @override
  bool get saving;
  @override
  @JsonKey(ignore: true)
  _$$_CreditSummaryStateCopyWith<_$_CreditSummaryState> get copyWith =>
      throw _privateConstructorUsedError;
}
