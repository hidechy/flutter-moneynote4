// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'device_info_request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeviceInfoRequestState {
  String get name => throw _privateConstructorUsedError;
  String get systemName => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceInfoRequestStateCopyWith<DeviceInfoRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoRequestStateCopyWith<$Res> {
  factory $DeviceInfoRequestStateCopyWith(DeviceInfoRequestState value,
          $Res Function(DeviceInfoRequestState) then) =
      _$DeviceInfoRequestStateCopyWithImpl<$Res, DeviceInfoRequestState>;
  @useResult
  $Res call({String name, String systemName, String model});
}

/// @nodoc
class _$DeviceInfoRequestStateCopyWithImpl<$Res,
        $Val extends DeviceInfoRequestState>
    implements $DeviceInfoRequestStateCopyWith<$Res> {
  _$DeviceInfoRequestStateCopyWithImpl(this._value, this._then);

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
abstract class _$$_DeviceInfoRequestStateCopyWith<$Res>
    implements $DeviceInfoRequestStateCopyWith<$Res> {
  factory _$$_DeviceInfoRequestStateCopyWith(_$_DeviceInfoRequestState value,
          $Res Function(_$_DeviceInfoRequestState) then) =
      __$$_DeviceInfoRequestStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String systemName, String model});
}

/// @nodoc
class __$$_DeviceInfoRequestStateCopyWithImpl<$Res>
    extends _$DeviceInfoRequestStateCopyWithImpl<$Res,
        _$_DeviceInfoRequestState>
    implements _$$_DeviceInfoRequestStateCopyWith<$Res> {
  __$$_DeviceInfoRequestStateCopyWithImpl(_$_DeviceInfoRequestState _value,
      $Res Function(_$_DeviceInfoRequestState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? systemName = null,
    Object? model = null,
  }) {
    return _then(_$_DeviceInfoRequestState(
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

class _$_DeviceInfoRequestState implements _DeviceInfoRequestState {
  const _$_DeviceInfoRequestState(
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
    return 'DeviceInfoRequestState(name: $name, systemName: $systemName, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeviceInfoRequestState &&
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
  _$$_DeviceInfoRequestStateCopyWith<_$_DeviceInfoRequestState> get copyWith =>
      __$$_DeviceInfoRequestStateCopyWithImpl<_$_DeviceInfoRequestState>(
          this, _$identity);
}

abstract class _DeviceInfoRequestState implements DeviceInfoRequestState {
  const factory _DeviceInfoRequestState(
      {final String name,
      final String systemName,
      final String model}) = _$_DeviceInfoRequestState;

  @override
  String get name;
  @override
  String get systemName;
  @override
  String get model;
  @override
  @JsonKey(ignore: true)
  _$$_DeviceInfoRequestStateCopyWith<_$_DeviceInfoRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}
