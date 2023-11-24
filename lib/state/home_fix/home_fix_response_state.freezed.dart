// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_fix_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeFixResponseState {
  AsyncValue<List<HomeFix>> get homeFixList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeFixResponseStateCopyWith<HomeFixResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeFixResponseStateCopyWith<$Res> {
  factory $HomeFixResponseStateCopyWith(HomeFixResponseState value,
          $Res Function(HomeFixResponseState) then) =
      _$HomeFixResponseStateCopyWithImpl<$Res, HomeFixResponseState>;
  @useResult
  $Res call({AsyncValue<List<HomeFix>> homeFixList});
}

/// @nodoc
class _$HomeFixResponseStateCopyWithImpl<$Res,
        $Val extends HomeFixResponseState>
    implements $HomeFixResponseStateCopyWith<$Res> {
  _$HomeFixResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeFixList = null,
  }) {
    return _then(_value.copyWith(
      homeFixList: null == homeFixList
          ? _value.homeFixList
          : homeFixList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<HomeFix>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeFixResponseStateImplCopyWith<$Res>
    implements $HomeFixResponseStateCopyWith<$Res> {
  factory _$$HomeFixResponseStateImplCopyWith(_$HomeFixResponseStateImpl value,
          $Res Function(_$HomeFixResponseStateImpl) then) =
      __$$HomeFixResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<HomeFix>> homeFixList});
}

/// @nodoc
class __$$HomeFixResponseStateImplCopyWithImpl<$Res>
    extends _$HomeFixResponseStateCopyWithImpl<$Res, _$HomeFixResponseStateImpl>
    implements _$$HomeFixResponseStateImplCopyWith<$Res> {
  __$$HomeFixResponseStateImplCopyWithImpl(_$HomeFixResponseStateImpl _value,
      $Res Function(_$HomeFixResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeFixList = null,
  }) {
    return _then(_$HomeFixResponseStateImpl(
      homeFixList: null == homeFixList
          ? _value.homeFixList
          : homeFixList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<HomeFix>>,
    ));
  }
}

/// @nodoc

class _$HomeFixResponseStateImpl implements _HomeFixResponseState {
  const _$HomeFixResponseStateImpl(
      {this.homeFixList = const AsyncValue<List<HomeFix>>.loading()});

  @override
  @JsonKey()
  final AsyncValue<List<HomeFix>> homeFixList;

  @override
  String toString() {
    return 'HomeFixResponseState(homeFixList: $homeFixList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeFixResponseStateImpl &&
            (identical(other.homeFixList, homeFixList) ||
                other.homeFixList == homeFixList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, homeFixList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeFixResponseStateImplCopyWith<_$HomeFixResponseStateImpl>
      get copyWith =>
          __$$HomeFixResponseStateImplCopyWithImpl<_$HomeFixResponseStateImpl>(
              this, _$identity);
}

abstract class _HomeFixResponseState implements HomeFixResponseState {
  const factory _HomeFixResponseState(
          {final AsyncValue<List<HomeFix>> homeFixList}) =
      _$HomeFixResponseStateImpl;

  @override
  AsyncValue<List<HomeFix>> get homeFixList;
  @override
  @JsonKey(ignore: true)
  _$$HomeFixResponseStateImplCopyWith<_$HomeFixResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
