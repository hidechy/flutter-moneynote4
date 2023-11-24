// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_info_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeviceInfoResponseState {
  String get name => throw _privateConstructorUsedError;
  String get systemName => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceInfoResponseStateCopyWith<DeviceInfoResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoResponseStateCopyWith<$Res> {
  factory $DeviceInfoResponseStateCopyWith(DeviceInfoResponseState value,
          $Res Function(DeviceInfoResponseState) then) =
      _$DeviceInfoResponseStateCopyWithImpl<$Res, DeviceInfoResponseState>;
  @useResult
  $Res call({String name, String systemName, String model});
}

/// @nodoc
class _$DeviceInfoResponseStateCopyWithImpl<$Res,
        $Val extends DeviceInfoResponseState>
    implements $DeviceInfoResponseStateCopyWith<$Res> {
  _$DeviceInfoResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? systemName = null,
    Object? model = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      systemName: null == systemName
          ? _value.systemName
          : systemName // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceInfoResponseStateImplCopyWith<$Res>
    implements $DeviceInfoResponseStateCopyWith<$Res> {
  factory _$$DeviceInfoResponseStateImplCopyWith(
          _$DeviceInfoResponseStateImpl value,
          $Res Function(_$DeviceInfoResponseStateImpl) then) =
      __$$DeviceInfoResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String systemName, String model});
}

/// @nodoc
class __$$DeviceInfoResponseStateImplCopyWithImpl<$Res>
    extends _$DeviceInfoResponseStateCopyWithImpl<$Res,
        _$DeviceInfoResponseStateImpl>
    implements _$$DeviceInfoResponseStateImplCopyWith<$Res> {
  __$$DeviceInfoResponseStateImplCopyWithImpl(
      _$DeviceInfoResponseStateImpl _value,
      $Res Function(_$DeviceInfoResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? systemName = null,
    Object? model = null,
  }) {
    return _then(_$DeviceInfoResponseStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      systemName: null == systemName
          ? _value.systemName
          : systemName // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeviceInfoResponseStateImpl implements _DeviceInfoResponseState {
  const _$DeviceInfoResponseStateImpl(
      {this.name = '', this.systemName = '', this.model = ''});

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String systemName;
  @override
  @JsonKey()
  final String model;

  @override
  String toString() {
    return 'DeviceInfoResponseState(name: $name, systemName: $systemName, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceInfoResponseStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.systemName, systemName) ||
                other.systemName == systemName) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, systemName, model);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceInfoResponseStateImplCopyWith<_$DeviceInfoResponseStateImpl>
      get copyWith => __$$DeviceInfoResponseStateImplCopyWithImpl<
          _$DeviceInfoResponseStateImpl>(this, _$identity);
}

abstract class _DeviceInfoResponseState implements DeviceInfoResponseState {
  const factory _DeviceInfoResponseState(
      {final String name,
      final String systemName,
      final String model}) = _$DeviceInfoResponseStateImpl;

  @override
  String get name;
  @override
  String get systemName;
  @override
  String get model;
  @override
  @JsonKey(ignore: true)
  _$$DeviceInfoResponseStateImplCopyWith<_$DeviceInfoResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
