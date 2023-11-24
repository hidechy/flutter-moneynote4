// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_marker_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MapMarkerState {
  Set<Marker> get markers => throw _privateConstructorUsedError;
  String get selectTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MapMarkerStateCopyWith<MapMarkerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapMarkerStateCopyWith<$Res> {
  factory $MapMarkerStateCopyWith(
          MapMarkerState value, $Res Function(MapMarkerState) then) =
      _$MapMarkerStateCopyWithImpl<$Res, MapMarkerState>;
  @useResult
  $Res call({Set<Marker> markers, String selectTime});
}

/// @nodoc
class _$MapMarkerStateCopyWithImpl<$Res, $Val extends MapMarkerState>
    implements $MapMarkerStateCopyWith<$Res> {
  _$MapMarkerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? markers = null,
    Object? selectTime = null,
  }) {
    return _then(_value.copyWith(
      markers: null == markers
          ? _value.markers
          : markers // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      selectTime: null == selectTime
          ? _value.selectTime
          : selectTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapMarkerStateImplCopyWith<$Res>
    implements $MapMarkerStateCopyWith<$Res> {
  factory _$$MapMarkerStateImplCopyWith(_$MapMarkerStateImpl value,
          $Res Function(_$MapMarkerStateImpl) then) =
      __$$MapMarkerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Set<Marker> markers, String selectTime});
}

/// @nodoc
class __$$MapMarkerStateImplCopyWithImpl<$Res>
    extends _$MapMarkerStateCopyWithImpl<$Res, _$MapMarkerStateImpl>
    implements _$$MapMarkerStateImplCopyWith<$Res> {
  __$$MapMarkerStateImplCopyWithImpl(
      _$MapMarkerStateImpl _value, $Res Function(_$MapMarkerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? markers = null,
    Object? selectTime = null,
  }) {
    return _then(_$MapMarkerStateImpl(
      markers: null == markers
          ? _value._markers
          : markers // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      selectTime: null == selectTime
          ? _value.selectTime
          : selectTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MapMarkerStateImpl implements _MapMarkerState {
  const _$MapMarkerStateImpl(
      {final Set<Marker> markers = const {}, this.selectTime = ''})
      : _markers = markers;

  final Set<Marker> _markers;
  @override
  @JsonKey()
  Set<Marker> get markers {
    if (_markers is EqualUnmodifiableSetView) return _markers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_markers);
  }

  @override
  @JsonKey()
  final String selectTime;

  @override
  String toString() {
    return 'MapMarkerState(markers: $markers, selectTime: $selectTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapMarkerStateImpl &&
            const DeepCollectionEquality().equals(other._markers, _markers) &&
            (identical(other.selectTime, selectTime) ||
                other.selectTime == selectTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_markers), selectTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapMarkerStateImplCopyWith<_$MapMarkerStateImpl> get copyWith =>
      __$$MapMarkerStateImplCopyWithImpl<_$MapMarkerStateImpl>(
          this, _$identity);
}

abstract class _MapMarkerState implements MapMarkerState {
  const factory _MapMarkerState(
      {final Set<Marker> markers,
      final String selectTime}) = _$MapMarkerStateImpl;

  @override
  Set<Marker> get markers;
  @override
  String get selectTime;
  @override
  @JsonKey(ignore: true)
  _$$MapMarkerStateImplCopyWith<_$MapMarkerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
