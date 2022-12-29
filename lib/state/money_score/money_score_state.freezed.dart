// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'money_score_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MoneyScoreState {
  List<MoneyScore> get list => throw _privateConstructorUsedError;
  bool get saving => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MoneyScoreStateCopyWith<MoneyScoreState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyScoreStateCopyWith<$Res> {
  factory $MoneyScoreStateCopyWith(
          MoneyScoreState value, $Res Function(MoneyScoreState) then) =
      _$MoneyScoreStateCopyWithImpl<$Res, MoneyScoreState>;
  @useResult
  $Res call({List<MoneyScore> list, bool saving});
}

/// @nodoc
class _$MoneyScoreStateCopyWithImpl<$Res, $Val extends MoneyScoreState>
    implements $MoneyScoreStateCopyWith<$Res> {
  _$MoneyScoreStateCopyWithImpl(this._value, this._then);

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
              as List<MoneyScore>,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MoneyScoreStateCopyWith<$Res>
    implements $MoneyScoreStateCopyWith<$Res> {
  factory _$$_MoneyScoreStateCopyWith(
          _$_MoneyScoreState value, $Res Function(_$_MoneyScoreState) then) =
      __$$_MoneyScoreStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MoneyScore> list, bool saving});
}

/// @nodoc
class __$$_MoneyScoreStateCopyWithImpl<$Res>
    extends _$MoneyScoreStateCopyWithImpl<$Res, _$_MoneyScoreState>
    implements _$$_MoneyScoreStateCopyWith<$Res> {
  __$$_MoneyScoreStateCopyWithImpl(
      _$_MoneyScoreState _value, $Res Function(_$_MoneyScoreState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? saving = null,
  }) {
    return _then(_$_MoneyScoreState(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<MoneyScore>,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_MoneyScoreState implements _MoneyScoreState {
  const _$_MoneyScoreState(
      {final List<MoneyScore> list = const [], this.saving = false})
      : _list = list;

  final List<MoneyScore> _list;
  @override
  @JsonKey()
  List<MoneyScore> get list {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final bool saving;

  @override
  String toString() {
    return 'MoneyScoreState(list: $list, saving: $saving)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MoneyScoreState &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.saving, saving) || other.saving == saving));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_list), saving);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MoneyScoreStateCopyWith<_$_MoneyScoreState> get copyWith =>
      __$$_MoneyScoreStateCopyWithImpl<_$_MoneyScoreState>(this, _$identity);
}

abstract class _MoneyScoreState implements MoneyScoreState {
  const factory _MoneyScoreState(
      {final List<MoneyScore> list, final bool saving}) = _$_MoneyScoreState;

  @override
  List<MoneyScore> get list;
  @override
  bool get saving;
  @override
  @JsonKey(ignore: true)
  _$$_MoneyScoreStateCopyWith<_$_MoneyScoreState> get copyWith =>
      throw _privateConstructorUsedError;
}
