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
  AsyncValue<List<Gold>> get goldList => throw _privateConstructorUsedError;
  AsyncValue<Map<String, AssetsData>> get goldMap =>
      throw _privateConstructorUsedError;

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
  $Res call(
      {Gold? lastGold,
      AsyncValue<List<Gold>> goldList,
      AsyncValue<Map<String, AssetsData>> goldMap});
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
    Object? goldMap = null,
  }) {
    return _then(_value.copyWith(
      lastGold: freezed == lastGold
          ? _value.lastGold
          : lastGold // ignore: cast_nullable_to_non_nullable
              as Gold?,
      goldList: null == goldList
          ? _value.goldList
          : goldList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Gold>>,
      goldMap: null == goldMap
          ? _value.goldMap
          : goldMap // ignore: cast_nullable_to_non_nullable
              as AsyncValue<Map<String, AssetsData>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoldResponseStateImplCopyWith<$Res>
    implements $GoldResponseStateCopyWith<$Res> {
  factory _$$GoldResponseStateImplCopyWith(_$GoldResponseStateImpl value,
          $Res Function(_$GoldResponseStateImpl) then) =
      __$$GoldResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Gold? lastGold,
      AsyncValue<List<Gold>> goldList,
      AsyncValue<Map<String, AssetsData>> goldMap});
}

/// @nodoc
class __$$GoldResponseStateImplCopyWithImpl<$Res>
    extends _$GoldResponseStateCopyWithImpl<$Res, _$GoldResponseStateImpl>
    implements _$$GoldResponseStateImplCopyWith<$Res> {
  __$$GoldResponseStateImplCopyWithImpl(_$GoldResponseStateImpl _value,
      $Res Function(_$GoldResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastGold = freezed,
    Object? goldList = null,
    Object? goldMap = null,
  }) {
    return _then(_$GoldResponseStateImpl(
      lastGold: freezed == lastGold
          ? _value.lastGold
          : lastGold // ignore: cast_nullable_to_non_nullable
              as Gold?,
      goldList: null == goldList
          ? _value.goldList
          : goldList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Gold>>,
      goldMap: null == goldMap
          ? _value.goldMap
          : goldMap // ignore: cast_nullable_to_non_nullable
              as AsyncValue<Map<String, AssetsData>>,
    ));
  }
}

/// @nodoc

class _$GoldResponseStateImpl implements _GoldResponseState {
  const _$GoldResponseStateImpl(
      {this.lastGold,
      this.goldList = const AsyncValue<List<Gold>>.loading(),
      this.goldMap = const AsyncValue<Map<String, AssetsData>>.loading()});

  @override
  final Gold? lastGold;
  @override
  @JsonKey()
  final AsyncValue<List<Gold>> goldList;
  @override
  @JsonKey()
  final AsyncValue<Map<String, AssetsData>> goldMap;

  @override
  String toString() {
    return 'GoldResponseState(lastGold: $lastGold, goldList: $goldList, goldMap: $goldMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoldResponseStateImpl &&
            (identical(other.lastGold, lastGold) ||
                other.lastGold == lastGold) &&
            (identical(other.goldList, goldList) ||
                other.goldList == goldList) &&
            (identical(other.goldMap, goldMap) || other.goldMap == goldMap));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastGold, goldList, goldMap);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoldResponseStateImplCopyWith<_$GoldResponseStateImpl> get copyWith =>
      __$$GoldResponseStateImplCopyWithImpl<_$GoldResponseStateImpl>(
          this, _$identity);
}

abstract class _GoldResponseState implements GoldResponseState {
  const factory _GoldResponseState(
          {final Gold? lastGold,
          final AsyncValue<List<Gold>> goldList,
          final AsyncValue<Map<String, AssetsData>> goldMap}) =
      _$GoldResponseStateImpl;

  @override
  Gold? get lastGold;
  @override
  AsyncValue<List<Gold>> get goldList;
  @override
  AsyncValue<Map<String, AssetsData>> get goldMap;
  @override
  @JsonKey(ignore: true)
  _$$GoldResponseStateImplCopyWith<_$GoldResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
