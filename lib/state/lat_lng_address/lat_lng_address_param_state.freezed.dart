// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lat_lng_address_param_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LatLngAddressParamState {
  String get latitude => throw _privateConstructorUsedError;
  String get longitude => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LatLngAddressParamStateCopyWith<LatLngAddressParamState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatLngAddressParamStateCopyWith<$Res> {
  factory $LatLngAddressParamStateCopyWith(LatLngAddressParamState value,
          $Res Function(LatLngAddressParamState) then) =
      _$LatLngAddressParamStateCopyWithImpl<$Res, LatLngAddressParamState>;
  @useResult
  $Res call({String latitude, String longitude});
}

/// @nodoc
class _$LatLngAddressParamStateCopyWithImpl<$Res,
        $Val extends LatLngAddressParamState>
    implements $LatLngAddressParamStateCopyWith<$Res> {
  _$LatLngAddressParamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LatLngAddressParamStateImplCopyWith<$Res>
    implements $LatLngAddressParamStateCopyWith<$Res> {
  factory _$$LatLngAddressParamStateImplCopyWith(
          _$LatLngAddressParamStateImpl value,
          $Res Function(_$LatLngAddressParamStateImpl) then) =
      __$$LatLngAddressParamStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String latitude, String longitude});
}

/// @nodoc
class __$$LatLngAddressParamStateImplCopyWithImpl<$Res>
    extends _$LatLngAddressParamStateCopyWithImpl<$Res,
        _$LatLngAddressParamStateImpl>
    implements _$$LatLngAddressParamStateImplCopyWith<$Res> {
  __$$LatLngAddressParamStateImplCopyWithImpl(
      _$LatLngAddressParamStateImpl _value,
      $Res Function(_$LatLngAddressParamStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$LatLngAddressParamStateImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LatLngAddressParamStateImpl implements _LatLngAddressParamState {
  const _$LatLngAddressParamStateImpl(
      {this.latitude = '', this.longitude = ''});

  @override
  @JsonKey()
  final String latitude;
  @override
  @JsonKey()
  final String longitude;

  @override
  String toString() {
    return 'LatLngAddressParamState(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatLngAddressParamStateImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LatLngAddressParamStateImplCopyWith<_$LatLngAddressParamStateImpl>
      get copyWith => __$$LatLngAddressParamStateImplCopyWithImpl<
          _$LatLngAddressParamStateImpl>(this, _$identity);
}

abstract class _LatLngAddressParamState implements LatLngAddressParamState {
  const factory _LatLngAddressParamState(
      {final String latitude,
      final String longitude}) = _$LatLngAddressParamStateImpl;

  @override
  String get latitude;
  @override
  String get longitude;
  @override
  @JsonKey(ignore: true)
  _$$LatLngAddressParamStateImplCopyWith<_$LatLngAddressParamStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
