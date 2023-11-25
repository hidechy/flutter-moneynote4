// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'temple_latlng_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TempleLatLngResponseState {
  Map<String, TempleLatLng> get templeLatLngMap =>
      throw _privateConstructorUsedError; //
  AsyncValue<List<TempleLatLng>> get templeLatLngList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TempleLatLngResponseStateCopyWith<TempleLatLngResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempleLatLngResponseStateCopyWith<$Res> {
  factory $TempleLatLngResponseStateCopyWith(TempleLatLngResponseState value,
          $Res Function(TempleLatLngResponseState) then) =
      _$TempleLatLngResponseStateCopyWithImpl<$Res, TempleLatLngResponseState>;
  @useResult
  $Res call(
      {Map<String, TempleLatLng> templeLatLngMap,
      AsyncValue<List<TempleLatLng>> templeLatLngList});
}

/// @nodoc
class _$TempleLatLngResponseStateCopyWithImpl<$Res,
        $Val extends TempleLatLngResponseState>
    implements $TempleLatLngResponseStateCopyWith<$Res> {
  _$TempleLatLngResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templeLatLngMap = null,
    Object? templeLatLngList = null,
  }) {
    return _then(_value.copyWith(
      templeLatLngMap: null == templeLatLngMap
          ? _value.templeLatLngMap
          : templeLatLngMap // ignore: cast_nullable_to_non_nullable
              as Map<String, TempleLatLng>,
      templeLatLngList: null == templeLatLngList
          ? _value.templeLatLngList
          : templeLatLngList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TempleLatLng>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TempleLatLngResponseStateImplCopyWith<$Res>
    implements $TempleLatLngResponseStateCopyWith<$Res> {
  factory _$$TempleLatLngResponseStateImplCopyWith(
          _$TempleLatLngResponseStateImpl value,
          $Res Function(_$TempleLatLngResponseStateImpl) then) =
      __$$TempleLatLngResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, TempleLatLng> templeLatLngMap,
      AsyncValue<List<TempleLatLng>> templeLatLngList});
}

/// @nodoc
class __$$TempleLatLngResponseStateImplCopyWithImpl<$Res>
    extends _$TempleLatLngResponseStateCopyWithImpl<$Res,
        _$TempleLatLngResponseStateImpl>
    implements _$$TempleLatLngResponseStateImplCopyWith<$Res> {
  __$$TempleLatLngResponseStateImplCopyWithImpl(
      _$TempleLatLngResponseStateImpl _value,
      $Res Function(_$TempleLatLngResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templeLatLngMap = null,
    Object? templeLatLngList = null,
  }) {
    return _then(_$TempleLatLngResponseStateImpl(
      templeLatLngMap: null == templeLatLngMap
          ? _value._templeLatLngMap
          : templeLatLngMap // ignore: cast_nullable_to_non_nullable
              as Map<String, TempleLatLng>,
      templeLatLngList: null == templeLatLngList
          ? _value.templeLatLngList
          : templeLatLngList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TempleLatLng>>,
    ));
  }
}

/// @nodoc

class _$TempleLatLngResponseStateImpl implements _TempleLatLngResponseState {
  const _$TempleLatLngResponseStateImpl(
      {final Map<String, TempleLatLng> templeLatLngMap = const {},
      this.templeLatLngList = const AsyncValue<List<TempleLatLng>>.loading()})
      : _templeLatLngMap = templeLatLngMap;

  final Map<String, TempleLatLng> _templeLatLngMap;
  @override
  @JsonKey()
  Map<String, TempleLatLng> get templeLatLngMap {
    if (_templeLatLngMap is EqualUnmodifiableMapView) return _templeLatLngMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_templeLatLngMap);
  }

//
  @override
  @JsonKey()
  final AsyncValue<List<TempleLatLng>> templeLatLngList;

  @override
  String toString() {
    return 'TempleLatLngResponseState(templeLatLngMap: $templeLatLngMap, templeLatLngList: $templeLatLngList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TempleLatLngResponseStateImpl &&
            const DeepCollectionEquality()
                .equals(other._templeLatLngMap, _templeLatLngMap) &&
            (identical(other.templeLatLngList, templeLatLngList) ||
                other.templeLatLngList == templeLatLngList));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_templeLatLngMap), templeLatLngList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TempleLatLngResponseStateImplCopyWith<_$TempleLatLngResponseStateImpl>
      get copyWith => __$$TempleLatLngResponseStateImplCopyWithImpl<
          _$TempleLatLngResponseStateImpl>(this, _$identity);
}

abstract class _TempleLatLngResponseState implements TempleLatLngResponseState {
  const factory _TempleLatLngResponseState(
          {final Map<String, TempleLatLng> templeLatLngMap,
          final AsyncValue<List<TempleLatLng>> templeLatLngList}) =
      _$TempleLatLngResponseStateImpl;

  @override
  Map<String, TempleLatLng> get templeLatLngMap;
  @override //
  AsyncValue<List<TempleLatLng>> get templeLatLngList;
  @override
  @JsonKey(ignore: true)
  _$$TempleLatLngResponseStateImplCopyWith<_$TempleLatLngResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
