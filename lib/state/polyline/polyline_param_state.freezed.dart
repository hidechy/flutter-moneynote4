// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'polyline_param_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PolylineParamState {
  String get origin => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PolylineParamStateCopyWith<PolylineParamState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolylineParamStateCopyWith<$Res> {
  factory $PolylineParamStateCopyWith(
          PolylineParamState value, $Res Function(PolylineParamState) then) =
      _$PolylineParamStateCopyWithImpl<$Res, PolylineParamState>;
  @useResult
  $Res call({String origin, String destination});
}

/// @nodoc
class _$PolylineParamStateCopyWithImpl<$Res, $Val extends PolylineParamState>
    implements $PolylineParamStateCopyWith<$Res> {
  _$PolylineParamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? destination = null,
  }) {
    return _then(_value.copyWith(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PolylineParamStateImplCopyWith<$Res>
    implements $PolylineParamStateCopyWith<$Res> {
  factory _$$PolylineParamStateImplCopyWith(_$PolylineParamStateImpl value,
          $Res Function(_$PolylineParamStateImpl) then) =
      __$$PolylineParamStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String origin, String destination});
}

/// @nodoc
class __$$PolylineParamStateImplCopyWithImpl<$Res>
    extends _$PolylineParamStateCopyWithImpl<$Res, _$PolylineParamStateImpl>
    implements _$$PolylineParamStateImplCopyWith<$Res> {
  __$$PolylineParamStateImplCopyWithImpl(_$PolylineParamStateImpl _value,
      $Res Function(_$PolylineParamStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? destination = null,
  }) {
    return _then(_$PolylineParamStateImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PolylineParamStateImpl implements _PolylineParamState {
  const _$PolylineParamStateImpl({this.origin = '', this.destination = ''});

  @override
  @JsonKey()
  final String origin;
  @override
  @JsonKey()
  final String destination;

  @override
  String toString() {
    return 'PolylineParamState(origin: $origin, destination: $destination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolylineParamStateImpl &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.destination, destination) ||
                other.destination == destination));
  }

  @override
  int get hashCode => Object.hash(runtimeType, origin, destination);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PolylineParamStateImplCopyWith<_$PolylineParamStateImpl> get copyWith =>
      __$$PolylineParamStateImplCopyWithImpl<_$PolylineParamStateImpl>(
          this, _$identity);
}

abstract class _PolylineParamState implements PolylineParamState {
  const factory _PolylineParamState(
      {final String origin,
      final String destination}) = _$PolylineParamStateImpl;

  @override
  String get origin;
  @override
  String get destination;
  @override
  @JsonKey(ignore: true)
  _$$PolylineParamStateImplCopyWith<_$PolylineParamStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
