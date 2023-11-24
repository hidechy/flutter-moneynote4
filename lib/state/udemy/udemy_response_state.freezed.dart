// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'udemy_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UdemyResponseState {
  AsyncValue<List<Udemy>> get udemyList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UdemyResponseStateCopyWith<UdemyResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UdemyResponseStateCopyWith<$Res> {
  factory $UdemyResponseStateCopyWith(
          UdemyResponseState value, $Res Function(UdemyResponseState) then) =
      _$UdemyResponseStateCopyWithImpl<$Res, UdemyResponseState>;
  @useResult
  $Res call({AsyncValue<List<Udemy>> udemyList});
}

/// @nodoc
class _$UdemyResponseStateCopyWithImpl<$Res, $Val extends UdemyResponseState>
    implements $UdemyResponseStateCopyWith<$Res> {
  _$UdemyResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? udemyList = null,
  }) {
    return _then(_value.copyWith(
      udemyList: null == udemyList
          ? _value.udemyList
          : udemyList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Udemy>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UdemyResponseStateImplCopyWith<$Res>
    implements $UdemyResponseStateCopyWith<$Res> {
  factory _$$UdemyResponseStateImplCopyWith(_$UdemyResponseStateImpl value,
          $Res Function(_$UdemyResponseStateImpl) then) =
      __$$UdemyResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<Udemy>> udemyList});
}

/// @nodoc
class __$$UdemyResponseStateImplCopyWithImpl<$Res>
    extends _$UdemyResponseStateCopyWithImpl<$Res, _$UdemyResponseStateImpl>
    implements _$$UdemyResponseStateImplCopyWith<$Res> {
  __$$UdemyResponseStateImplCopyWithImpl(_$UdemyResponseStateImpl _value,
      $Res Function(_$UdemyResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? udemyList = null,
  }) {
    return _then(_$UdemyResponseStateImpl(
      udemyList: null == udemyList
          ? _value.udemyList
          : udemyList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Udemy>>,
    ));
  }
}

/// @nodoc

class _$UdemyResponseStateImpl implements _UdemyResponseState {
  const _$UdemyResponseStateImpl(
      {this.udemyList = const AsyncValue<List<Udemy>>.loading()});

  @override
  @JsonKey()
  final AsyncValue<List<Udemy>> udemyList;

  @override
  String toString() {
    return 'UdemyResponseState(udemyList: $udemyList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UdemyResponseStateImpl &&
            (identical(other.udemyList, udemyList) ||
                other.udemyList == udemyList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, udemyList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UdemyResponseStateImplCopyWith<_$UdemyResponseStateImpl> get copyWith =>
      __$$UdemyResponseStateImplCopyWithImpl<_$UdemyResponseStateImpl>(
          this, _$identity);
}

abstract class _UdemyResponseState implements UdemyResponseState {
  const factory _UdemyResponseState({final AsyncValue<List<Udemy>> udemyList}) =
      _$UdemyResponseStateImpl;

  @override
  AsyncValue<List<Udemy>> get udemyList;
  @override
  @JsonKey(ignore: true)
  _$$UdemyResponseStateImplCopyWith<_$UdemyResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
