// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'spend_summary_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpendSummaryState {
  List<SpendSummary> get list => throw _privateConstructorUsedError;
  bool get saving => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpendSummaryStateCopyWith<SpendSummaryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpendSummaryStateCopyWith<$Res> {
  factory $SpendSummaryStateCopyWith(
          SpendSummaryState value, $Res Function(SpendSummaryState) then) =
      _$SpendSummaryStateCopyWithImpl<$Res, SpendSummaryState>;
  @useResult
  $Res call({List<SpendSummary> list, bool saving});
}

/// @nodoc
class _$SpendSummaryStateCopyWithImpl<$Res, $Val extends SpendSummaryState>
    implements $SpendSummaryStateCopyWith<$Res> {
  _$SpendSummaryStateCopyWithImpl(this._value, this._then);

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
              as List<SpendSummary>,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SpendSummaryStateCopyWith<$Res>
    implements $SpendSummaryStateCopyWith<$Res> {
  factory _$$_SpendSummaryStateCopyWith(_$_SpendSummaryState value,
          $Res Function(_$_SpendSummaryState) then) =
      __$$_SpendSummaryStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SpendSummary> list, bool saving});
}

/// @nodoc
class __$$_SpendSummaryStateCopyWithImpl<$Res>
    extends _$SpendSummaryStateCopyWithImpl<$Res, _$_SpendSummaryState>
    implements _$$_SpendSummaryStateCopyWith<$Res> {
  __$$_SpendSummaryStateCopyWithImpl(
      _$_SpendSummaryState _value, $Res Function(_$_SpendSummaryState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? saving = null,
  }) {
    return _then(_$_SpendSummaryState(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<SpendSummary>,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SpendSummaryState implements _SpendSummaryState {
  const _$_SpendSummaryState(
      {final List<SpendSummary> list = const [], this.saving = false})
      : _list = list;

  final List<SpendSummary> _list;
  @override
  @JsonKey()
  List<SpendSummary> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final bool saving;

  @override
  String toString() {
    return 'SpendSummaryState(list: $list, saving: $saving)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpendSummaryState &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.saving, saving) || other.saving == saving));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_list), saving);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpendSummaryStateCopyWith<_$_SpendSummaryState> get copyWith =>
      __$$_SpendSummaryStateCopyWithImpl<_$_SpendSummaryState>(
          this, _$identity);
}

abstract class _SpendSummaryState implements SpendSummaryState {
  const factory _SpendSummaryState(
      {final List<SpendSummary> list,
      final bool saving}) = _$_SpendSummaryState;

  @override
  List<SpendSummary> get list;
  @override
  bool get saving;
  @override
  @JsonKey(ignore: true)
  _$$_SpendSummaryStateCopyWith<_$_SpendSummaryState> get copyWith =>
      throw _privateConstructorUsedError;
}
