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
abstract class _$$_HomeFixResponseStateCopyWith<$Res>
    implements $HomeFixResponseStateCopyWith<$Res> {
  factory _$$_HomeFixResponseStateCopyWith(_$_HomeFixResponseState value,
          $Res Function(_$_HomeFixResponseState) then) =
      __$$_HomeFixResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<HomeFix>> homeFixList});
}

/// @nodoc
class __$$_HomeFixResponseStateCopyWithImpl<$Res>
    extends _$HomeFixResponseStateCopyWithImpl<$Res, _$_HomeFixResponseState>
    implements _$$_HomeFixResponseStateCopyWith<$Res> {
  __$$_HomeFixResponseStateCopyWithImpl(_$_HomeFixResponseState _value,
      $Res Function(_$_HomeFixResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeFixList = null,
  }) {
    return _then(_$_HomeFixResponseState(
      homeFixList: null == homeFixList
          ? _value.homeFixList
          : homeFixList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<HomeFix>>,
    ));
  }
}

/// @nodoc

class _$_HomeFixResponseState implements _HomeFixResponseState {
  const _$_HomeFixResponseState(
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
            other is _$_HomeFixResponseState &&
            (identical(other.homeFixList, homeFixList) ||
                other.homeFixList == homeFixList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, homeFixList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeFixResponseStateCopyWith<_$_HomeFixResponseState> get copyWith =>
      __$$_HomeFixResponseStateCopyWithImpl<_$_HomeFixResponseState>(
          this, _$identity);
}

abstract class _HomeFixResponseState implements HomeFixResponseState {
  const factory _HomeFixResponseState(
      {final AsyncValue<List<HomeFix>> homeFixList}) = _$_HomeFixResponseState;

  @override
  AsyncValue<List<HomeFix>> get homeFixList;
  @override
  @JsonKey(ignore: true)
  _$$_HomeFixResponseStateCopyWith<_$_HomeFixResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}
