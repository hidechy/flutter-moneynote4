// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'temple_photos_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TemplePhotosResponseState {
  Map<String, List<TemplePhoto>> get templePhotoDateMap =>
      throw _privateConstructorUsedError;
  Map<String, List<TemplePhoto>> get templePhotoTempleMap =>
      throw _privateConstructorUsedError; //
  AsyncValue<List<TemplePhoto>> get templePhotoList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TemplePhotosResponseStateCopyWith<TemplePhotosResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemplePhotosResponseStateCopyWith<$Res> {
  factory $TemplePhotosResponseStateCopyWith(TemplePhotosResponseState value,
          $Res Function(TemplePhotosResponseState) then) =
      _$TemplePhotosResponseStateCopyWithImpl<$Res, TemplePhotosResponseState>;
  @useResult
  $Res call(
      {Map<String, List<TemplePhoto>> templePhotoDateMap,
      Map<String, List<TemplePhoto>> templePhotoTempleMap,
      AsyncValue<List<TemplePhoto>> templePhotoList});
}

/// @nodoc
class _$TemplePhotosResponseStateCopyWithImpl<$Res,
        $Val extends TemplePhotosResponseState>
    implements $TemplePhotosResponseStateCopyWith<$Res> {
  _$TemplePhotosResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templePhotoDateMap = null,
    Object? templePhotoTempleMap = null,
    Object? templePhotoList = null,
  }) {
    return _then(_value.copyWith(
      templePhotoDateMap: null == templePhotoDateMap
          ? _value.templePhotoDateMap
          : templePhotoDateMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<TemplePhoto>>,
      templePhotoTempleMap: null == templePhotoTempleMap
          ? _value.templePhotoTempleMap
          : templePhotoTempleMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<TemplePhoto>>,
      templePhotoList: null == templePhotoList
          ? _value.templePhotoList
          : templePhotoList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TemplePhoto>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TemplePhotosResponseStateImplCopyWith<$Res>
    implements $TemplePhotosResponseStateCopyWith<$Res> {
  factory _$$TemplePhotosResponseStateImplCopyWith(
          _$TemplePhotosResponseStateImpl value,
          $Res Function(_$TemplePhotosResponseStateImpl) then) =
      __$$TemplePhotosResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, List<TemplePhoto>> templePhotoDateMap,
      Map<String, List<TemplePhoto>> templePhotoTempleMap,
      AsyncValue<List<TemplePhoto>> templePhotoList});
}

/// @nodoc
class __$$TemplePhotosResponseStateImplCopyWithImpl<$Res>
    extends _$TemplePhotosResponseStateCopyWithImpl<$Res,
        _$TemplePhotosResponseStateImpl>
    implements _$$TemplePhotosResponseStateImplCopyWith<$Res> {
  __$$TemplePhotosResponseStateImplCopyWithImpl(
      _$TemplePhotosResponseStateImpl _value,
      $Res Function(_$TemplePhotosResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templePhotoDateMap = null,
    Object? templePhotoTempleMap = null,
    Object? templePhotoList = null,
  }) {
    return _then(_$TemplePhotosResponseStateImpl(
      templePhotoDateMap: null == templePhotoDateMap
          ? _value._templePhotoDateMap
          : templePhotoDateMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<TemplePhoto>>,
      templePhotoTempleMap: null == templePhotoTempleMap
          ? _value._templePhotoTempleMap
          : templePhotoTempleMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<TemplePhoto>>,
      templePhotoList: null == templePhotoList
          ? _value.templePhotoList
          : templePhotoList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TemplePhoto>>,
    ));
  }
}

/// @nodoc

class _$TemplePhotosResponseStateImpl implements _TemplePhotosResponseState {
  const _$TemplePhotosResponseStateImpl(
      {final Map<String, List<TemplePhoto>> templePhotoDateMap = const {},
      final Map<String, List<TemplePhoto>> templePhotoTempleMap = const {},
      this.templePhotoList = const AsyncValue<List<TemplePhoto>>.loading()})
      : _templePhotoDateMap = templePhotoDateMap,
        _templePhotoTempleMap = templePhotoTempleMap;

  final Map<String, List<TemplePhoto>> _templePhotoDateMap;
  @override
  @JsonKey()
  Map<String, List<TemplePhoto>> get templePhotoDateMap {
    if (_templePhotoDateMap is EqualUnmodifiableMapView)
      return _templePhotoDateMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_templePhotoDateMap);
  }

  final Map<String, List<TemplePhoto>> _templePhotoTempleMap;
  @override
  @JsonKey()
  Map<String, List<TemplePhoto>> get templePhotoTempleMap {
    if (_templePhotoTempleMap is EqualUnmodifiableMapView)
      return _templePhotoTempleMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_templePhotoTempleMap);
  }

//
  @override
  @JsonKey()
  final AsyncValue<List<TemplePhoto>> templePhotoList;

  @override
  String toString() {
    return 'TemplePhotosResponseState(templePhotoDateMap: $templePhotoDateMap, templePhotoTempleMap: $templePhotoTempleMap, templePhotoList: $templePhotoList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemplePhotosResponseStateImpl &&
            const DeepCollectionEquality()
                .equals(other._templePhotoDateMap, _templePhotoDateMap) &&
            const DeepCollectionEquality()
                .equals(other._templePhotoTempleMap, _templePhotoTempleMap) &&
            (identical(other.templePhotoList, templePhotoList) ||
                other.templePhotoList == templePhotoList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_templePhotoDateMap),
      const DeepCollectionEquality().hash(_templePhotoTempleMap),
      templePhotoList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TemplePhotosResponseStateImplCopyWith<_$TemplePhotosResponseStateImpl>
      get copyWith => __$$TemplePhotosResponseStateImplCopyWithImpl<
          _$TemplePhotosResponseStateImpl>(this, _$identity);
}

abstract class _TemplePhotosResponseState implements TemplePhotosResponseState {
  const factory _TemplePhotosResponseState(
          {final Map<String, List<TemplePhoto>> templePhotoDateMap,
          final Map<String, List<TemplePhoto>> templePhotoTempleMap,
          final AsyncValue<List<TemplePhoto>> templePhotoList}) =
      _$TemplePhotosResponseStateImpl;

  @override
  Map<String, List<TemplePhoto>> get templePhotoDateMap;
  @override
  Map<String, List<TemplePhoto>> get templePhotoTempleMap;
  @override //
  AsyncValue<List<TemplePhoto>> get templePhotoList;
  @override
  @JsonKey(ignore: true)
  _$$TemplePhotosResponseStateImplCopyWith<_$TemplePhotosResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
