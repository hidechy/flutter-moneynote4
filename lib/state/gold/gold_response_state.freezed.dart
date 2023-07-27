// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gold_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GoldResponseState {
  Gold? get lastGold => throw _privateConstructorUsedError;
  List<Gold> get goldList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GoldResponseStateCopyWith<GoldResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoldResponseStateCopyWith<$Res> {
  factory $GoldResponseStateCopyWith(
          GoldResponseState value, $Res Function(GoldResponseState) then) =
      _$GoldResponseStateCopyWithImpl<$Res, GoldResponseState>;
  @useResult
  $Res call({Gold? lastGold, List<Gold> goldList});
}

/// @nodoc
class _$GoldResponseStateCopyWithImpl<$Res, $Val extends GoldResponseState>
    implements $GoldResponseStateCopyWith<$Res> {
  _$GoldResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastGold = freezed,
    Object? goldList = null,
  }) {
    return _then(_value.copyWith(
      lastGold: freezed == lastGold
          ? _value.lastGold
          : lastGold // ignore: cast_nullable_to_non_nullable
              as Gold?,
      goldList: null == goldList
          ? _value.goldList
          : goldList // ignore: cast_nullable_to_non_nullable
              as List<Gold>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GoldResponseStateCopyWith<$Res>
    implements $GoldResponseStateCopyWith<$Res> {
  factory _$$_GoldResponseStateCopyWith(_$_GoldResponseState value,
          $Res Function(_$_GoldResponseState) then) =
      __$$_GoldResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Gold? lastGold, List<Gold> goldList});
}

/// @nodoc
class __$$_GoldResponseStateCopyWithImpl<$Res>
    extends _$GoldResponseStateCopyWithImpl<$Res, _$_GoldResponseState>
    implements _$$_GoldResponseStateCopyWith<$Res> {
  __$$_GoldResponseStateCopyWithImpl(
      _$_GoldResponseState _value, $Res Function(_$_GoldResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastGold = freezed,
    Object? goldList = null,
  }) {
    return _then(_$_GoldResponseState(
      lastGold: freezed == lastGold
          ? _value.lastGold
          : lastGold // ignore: cast_nullable_to_non_nullable
              as Gold?,
      goldList: null == goldList
          ? _value._goldList
          : goldList // ignore: cast_nullable_to_non_nullable
              as List<Gold>,
    ));
  }
}

/// @nodoc

class _$_GoldResponseState implements _GoldResponseState {
  const _$_GoldResponseState(
      {this.lastGold, final List<Gold> goldList = const []})
      : _goldList = goldList;

  @override
  final Gold? lastGold;
  final List<Gold> _goldList;
  @override
  @JsonKey()
  List<Gold> get goldList {
    if (_goldList is EqualUnmodifiableListView) return _goldList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goldList);
  }

  @override
  String toString() {
    return 'GoldResponseState(lastGold: $lastGold, goldList: $goldList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GoldResponseState &&
            (identical(other.lastGold, lastGold) ||
                other.lastGold == lastGold) &&
            const DeepCollectionEquality().equals(other._goldList, _goldList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, lastGold, const DeepCollectionEquality().hash(_goldList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GoldResponseStateCopyWith<_$_GoldResponseState> get copyWith =>
      __$$_GoldResponseStateCopyWithImpl<_$_GoldResponseState>(
          this, _$identity);
}

abstract class _GoldResponseState implements GoldResponseState {
  const factory _GoldResponseState(
      {final Gold? lastGold, final List<Gold> goldList}) = _$_GoldResponseState;

  @override
  Gold? get lastGold;
  @override
  List<Gold> get goldList;
  @override
  @JsonKey(ignore: true)
  _$$_GoldResponseStateCopyWith<_$_GoldResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}
