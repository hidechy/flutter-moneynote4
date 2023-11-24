// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shintaku_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ShintakuResponseState {
  Shintaku? get lastShintaku => throw _privateConstructorUsedError;
  ShintakuRecord? get lastShintakuRecord => throw _privateConstructorUsedError;
  Map<String, AssetsData> get shintakuMap => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShintakuResponseStateCopyWith<ShintakuResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShintakuResponseStateCopyWith<$Res> {
  factory $ShintakuResponseStateCopyWith(ShintakuResponseState value,
          $Res Function(ShintakuResponseState) then) =
      _$ShintakuResponseStateCopyWithImpl<$Res, ShintakuResponseState>;
  @useResult
  $Res call(
      {Shintaku? lastShintaku,
      ShintakuRecord? lastShintakuRecord,
      Map<String, AssetsData> shintakuMap});
}

/// @nodoc
class _$ShintakuResponseStateCopyWithImpl<$Res,
        $Val extends ShintakuResponseState>
    implements $ShintakuResponseStateCopyWith<$Res> {
  _$ShintakuResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastShintaku = freezed,
    Object? lastShintakuRecord = freezed,
    Object? shintakuMap = null,
  }) {
    return _then(_value.copyWith(
      lastShintaku: freezed == lastShintaku
          ? _value.lastShintaku
          : lastShintaku // ignore: cast_nullable_to_non_nullable
              as Shintaku?,
      lastShintakuRecord: freezed == lastShintakuRecord
          ? _value.lastShintakuRecord
          : lastShintakuRecord // ignore: cast_nullable_to_non_nullable
              as ShintakuRecord?,
      shintakuMap: null == shintakuMap
          ? _value.shintakuMap
          : shintakuMap // ignore: cast_nullable_to_non_nullable
              as Map<String, AssetsData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShintakuResponseStateImplCopyWith<$Res>
    implements $ShintakuResponseStateCopyWith<$Res> {
  factory _$$ShintakuResponseStateImplCopyWith(
          _$ShintakuResponseStateImpl value,
          $Res Function(_$ShintakuResponseStateImpl) then) =
      __$$ShintakuResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Shintaku? lastShintaku,
      ShintakuRecord? lastShintakuRecord,
      Map<String, AssetsData> shintakuMap});
}

/// @nodoc
class __$$ShintakuResponseStateImplCopyWithImpl<$Res>
    extends _$ShintakuResponseStateCopyWithImpl<$Res,
        _$ShintakuResponseStateImpl>
    implements _$$ShintakuResponseStateImplCopyWith<$Res> {
  __$$ShintakuResponseStateImplCopyWithImpl(_$ShintakuResponseStateImpl _value,
      $Res Function(_$ShintakuResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastShintaku = freezed,
    Object? lastShintakuRecord = freezed,
    Object? shintakuMap = null,
  }) {
    return _then(_$ShintakuResponseStateImpl(
      lastShintaku: freezed == lastShintaku
          ? _value.lastShintaku
          : lastShintaku // ignore: cast_nullable_to_non_nullable
              as Shintaku?,
      lastShintakuRecord: freezed == lastShintakuRecord
          ? _value.lastShintakuRecord
          : lastShintakuRecord // ignore: cast_nullable_to_non_nullable
              as ShintakuRecord?,
      shintakuMap: null == shintakuMap
          ? _value._shintakuMap
          : shintakuMap // ignore: cast_nullable_to_non_nullable
              as Map<String, AssetsData>,
    ));
  }
}

/// @nodoc

class _$ShintakuResponseStateImpl implements _ShintakuResponseState {
  const _$ShintakuResponseStateImpl(
      {this.lastShintaku,
      this.lastShintakuRecord,
      final Map<String, AssetsData> shintakuMap = const {}})
      : _shintakuMap = shintakuMap;

  @override
  final Shintaku? lastShintaku;
  @override
  final ShintakuRecord? lastShintakuRecord;
  final Map<String, AssetsData> _shintakuMap;
  @override
  @JsonKey()
  Map<String, AssetsData> get shintakuMap {
    if (_shintakuMap is EqualUnmodifiableMapView) return _shintakuMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_shintakuMap);
  }

  @override
  String toString() {
    return 'ShintakuResponseState(lastShintaku: $lastShintaku, lastShintakuRecord: $lastShintakuRecord, shintakuMap: $shintakuMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShintakuResponseStateImpl &&
            (identical(other.lastShintaku, lastShintaku) ||
                other.lastShintaku == lastShintaku) &&
            (identical(other.lastShintakuRecord, lastShintakuRecord) ||
                other.lastShintakuRecord == lastShintakuRecord) &&
            const DeepCollectionEquality()
                .equals(other._shintakuMap, _shintakuMap));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastShintaku, lastShintakuRecord,
      const DeepCollectionEquality().hash(_shintakuMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShintakuResponseStateImplCopyWith<_$ShintakuResponseStateImpl>
      get copyWith => __$$ShintakuResponseStateImplCopyWithImpl<
          _$ShintakuResponseStateImpl>(this, _$identity);
}

abstract class _ShintakuResponseState implements ShintakuResponseState {
  const factory _ShintakuResponseState(
      {final Shintaku? lastShintaku,
      final ShintakuRecord? lastShintakuRecord,
      final Map<String, AssetsData> shintakuMap}) = _$ShintakuResponseStateImpl;

  @override
  Shintaku? get lastShintaku;
  @override
  ShintakuRecord? get lastShintakuRecord;
  @override
  Map<String, AssetsData> get shintakuMap;
  @override
  @JsonKey(ignore: true)
  _$$ShintakuResponseStateImplCopyWith<_$ShintakuResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
