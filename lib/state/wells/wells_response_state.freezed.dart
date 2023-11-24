// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wells_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WellsResponseState {
  AsyncValue<List<Wells>> get wellsList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WellsResponseStateCopyWith<WellsResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WellsResponseStateCopyWith<$Res> {
  factory $WellsResponseStateCopyWith(
          WellsResponseState value, $Res Function(WellsResponseState) then) =
      _$WellsResponseStateCopyWithImpl<$Res, WellsResponseState>;
  @useResult
  $Res call({AsyncValue<List<Wells>> wellsList});
}

/// @nodoc
class _$WellsResponseStateCopyWithImpl<$Res, $Val extends WellsResponseState>
    implements $WellsResponseStateCopyWith<$Res> {
  _$WellsResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wellsList = null,
  }) {
    return _then(_value.copyWith(
      wellsList: null == wellsList
          ? _value.wellsList
          : wellsList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Wells>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WellsResponseStateImplCopyWith<$Res>
    implements $WellsResponseStateCopyWith<$Res> {
  factory _$$WellsResponseStateImplCopyWith(_$WellsResponseStateImpl value,
          $Res Function(_$WellsResponseStateImpl) then) =
      __$$WellsResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<Wells>> wellsList});
}

/// @nodoc
class __$$WellsResponseStateImplCopyWithImpl<$Res>
    extends _$WellsResponseStateCopyWithImpl<$Res, _$WellsResponseStateImpl>
    implements _$$WellsResponseStateImplCopyWith<$Res> {
  __$$WellsResponseStateImplCopyWithImpl(_$WellsResponseStateImpl _value,
      $Res Function(_$WellsResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wellsList = null,
  }) {
    return _then(_$WellsResponseStateImpl(
      wellsList: null == wellsList
          ? _value.wellsList
          : wellsList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Wells>>,
    ));
  }
}

/// @nodoc

class _$WellsResponseStateImpl implements _WellsResponseState {
  const _$WellsResponseStateImpl(
      {this.wellsList = const AsyncValue<List<Wells>>.loading()});

  @override
  @JsonKey()
  final AsyncValue<List<Wells>> wellsList;

  @override
  String toString() {
    return 'WellsResponseState(wellsList: $wellsList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WellsResponseStateImpl &&
            (identical(other.wellsList, wellsList) ||
                other.wellsList == wellsList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, wellsList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WellsResponseStateImplCopyWith<_$WellsResponseStateImpl> get copyWith =>
      __$$WellsResponseStateImplCopyWithImpl<_$WellsResponseStateImpl>(
          this, _$identity);
}

abstract class _WellsResponseState implements WellsResponseState {
  const factory _WellsResponseState({final AsyncValue<List<Wells>> wellsList}) =
      _$WellsResponseStateImpl;

  @override
  AsyncValue<List<Wells>> get wellsList;
  @override
  @JsonKey(ignore: true)
  _$$WellsResponseStateImplCopyWith<_$WellsResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
