// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'station_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StationResponseState {
  List<Station> get stationList => throw _privateConstructorUsedError;
  Map<String, Station> get stationMap => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StationResponseStateCopyWith<StationResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StationResponseStateCopyWith<$Res> {
  factory $StationResponseStateCopyWith(StationResponseState value,
          $Res Function(StationResponseState) then) =
      _$StationResponseStateCopyWithImpl<$Res, StationResponseState>;
  @useResult
  $Res call({List<Station> stationList, Map<String, Station> stationMap});
}

/// @nodoc
class _$StationResponseStateCopyWithImpl<$Res,
        $Val extends StationResponseState>
    implements $StationResponseStateCopyWith<$Res> {
  _$StationResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationList = null,
    Object? stationMap = null,
  }) {
    return _then(_value.copyWith(
      stationList: null == stationList
          ? _value.stationList
          : stationList // ignore: cast_nullable_to_non_nullable
              as List<Station>,
      stationMap: null == stationMap
          ? _value.stationMap
          : stationMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Station>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StationResponseStateImplCopyWith<$Res>
    implements $StationResponseStateCopyWith<$Res> {
  factory _$$StationResponseStateImplCopyWith(_$StationResponseStateImpl value,
          $Res Function(_$StationResponseStateImpl) then) =
      __$$StationResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Station> stationList, Map<String, Station> stationMap});
}

/// @nodoc
class __$$StationResponseStateImplCopyWithImpl<$Res>
    extends _$StationResponseStateCopyWithImpl<$Res, _$StationResponseStateImpl>
    implements _$$StationResponseStateImplCopyWith<$Res> {
  __$$StationResponseStateImplCopyWithImpl(_$StationResponseStateImpl _value,
      $Res Function(_$StationResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stationList = null,
    Object? stationMap = null,
  }) {
    return _then(_$StationResponseStateImpl(
      stationList: null == stationList
          ? _value._stationList
          : stationList // ignore: cast_nullable_to_non_nullable
              as List<Station>,
      stationMap: null == stationMap
          ? _value._stationMap
          : stationMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Station>,
    ));
  }
}

/// @nodoc

class _$StationResponseStateImpl implements _StationResponseState {
  const _$StationResponseStateImpl(
      {final List<Station> stationList = const [],
      final Map<String, Station> stationMap = const {}})
      : _stationList = stationList,
        _stationMap = stationMap;

  final List<Station> _stationList;
  @override
  @JsonKey()
  List<Station> get stationList {
    if (_stationList is EqualUnmodifiableListView) return _stationList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stationList);
  }

  final Map<String, Station> _stationMap;
  @override
  @JsonKey()
  Map<String, Station> get stationMap {
    if (_stationMap is EqualUnmodifiableMapView) return _stationMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stationMap);
  }

  @override
  String toString() {
    return 'StationResponseState(stationList: $stationList, stationMap: $stationMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StationResponseStateImpl &&
            const DeepCollectionEquality()
                .equals(other._stationList, _stationList) &&
            const DeepCollectionEquality()
                .equals(other._stationMap, _stationMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_stationList),
      const DeepCollectionEquality().hash(_stationMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StationResponseStateImplCopyWith<_$StationResponseStateImpl>
      get copyWith =>
          __$$StationResponseStateImplCopyWithImpl<_$StationResponseStateImpl>(
              this, _$identity);
}

abstract class _StationResponseState implements StationResponseState {
  const factory _StationResponseState(
      {final List<Station> stationList,
      final Map<String, Station> stationMap}) = _$StationResponseStateImpl;

  @override
  List<Station> get stationList;
  @override
  Map<String, Station> get stationMap;
  @override
  @JsonKey(ignore: true)
  _$$StationResponseStateImplCopyWith<_$StationResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
