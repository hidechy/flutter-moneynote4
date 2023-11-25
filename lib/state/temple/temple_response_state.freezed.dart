// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'temple_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TempleResponseState {
  Map<String, Temple> get templeMap => throw _privateConstructorUsedError; //
  AsyncValue<List<Temple>> get templeList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TempleResponseStateCopyWith<TempleResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempleResponseStateCopyWith<$Res> {
  factory $TempleResponseStateCopyWith(
          TempleResponseState value, $Res Function(TempleResponseState) then) =
      _$TempleResponseStateCopyWithImpl<$Res, TempleResponseState>;
  @useResult
  $Res call(
      {Map<String, Temple> templeMap, AsyncValue<List<Temple>> templeList});
}

/// @nodoc
class _$TempleResponseStateCopyWithImpl<$Res, $Val extends TempleResponseState>
    implements $TempleResponseStateCopyWith<$Res> {
  _$TempleResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templeMap = null,
    Object? templeList = null,
  }) {
    return _then(_value.copyWith(
      templeMap: null == templeMap
          ? _value.templeMap
          : templeMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Temple>,
      templeList: null == templeList
          ? _value.templeList
          : templeList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Temple>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TempleResponseStateImplCopyWith<$Res>
    implements $TempleResponseStateCopyWith<$Res> {
  factory _$$TempleResponseStateImplCopyWith(_$TempleResponseStateImpl value,
          $Res Function(_$TempleResponseStateImpl) then) =
      __$$TempleResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, Temple> templeMap, AsyncValue<List<Temple>> templeList});
}

/// @nodoc
class __$$TempleResponseStateImplCopyWithImpl<$Res>
    extends _$TempleResponseStateCopyWithImpl<$Res, _$TempleResponseStateImpl>
    implements _$$TempleResponseStateImplCopyWith<$Res> {
  __$$TempleResponseStateImplCopyWithImpl(_$TempleResponseStateImpl _value,
      $Res Function(_$TempleResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templeMap = null,
    Object? templeList = null,
  }) {
    return _then(_$TempleResponseStateImpl(
      templeMap: null == templeMap
          ? _value._templeMap
          : templeMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Temple>,
      templeList: null == templeList
          ? _value.templeList
          : templeList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Temple>>,
    ));
  }
}

/// @nodoc

class _$TempleResponseStateImpl implements _TempleResponseState {
  const _$TempleResponseStateImpl(
      {final Map<String, Temple> templeMap = const {},
      this.templeList = const AsyncValue<List<Temple>>.loading()})
      : _templeMap = templeMap;

  final Map<String, Temple> _templeMap;
  @override
  @JsonKey()
  Map<String, Temple> get templeMap {
    if (_templeMap is EqualUnmodifiableMapView) return _templeMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_templeMap);
  }

//
  @override
  @JsonKey()
  final AsyncValue<List<Temple>> templeList;

  @override
  String toString() {
    return 'TempleResponseState(templeMap: $templeMap, templeList: $templeList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TempleResponseStateImpl &&
            const DeepCollectionEquality()
                .equals(other._templeMap, _templeMap) &&
            (identical(other.templeList, templeList) ||
                other.templeList == templeList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_templeMap), templeList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TempleResponseStateImplCopyWith<_$TempleResponseStateImpl> get copyWith =>
      __$$TempleResponseStateImplCopyWithImpl<_$TempleResponseStateImpl>(
          this, _$identity);
}

abstract class _TempleResponseState implements TempleResponseState {
  const factory _TempleResponseState(
      {final Map<String, Temple> templeMap,
      final AsyncValue<List<Temple>> templeList}) = _$TempleResponseStateImpl;

  @override
  Map<String, Temple> get templeMap;
  @override //
  AsyncValue<List<Temple>> get templeList;
  @override
  @JsonKey(ignore: true)
  _$$TempleResponseStateImplCopyWith<_$TempleResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
