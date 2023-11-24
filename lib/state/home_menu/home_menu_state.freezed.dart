// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_menu_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeMenuState {
  String get menuFlag => throw _privateConstructorUsedError;
  String get menuName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeMenuStateCopyWith<HomeMenuState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeMenuStateCopyWith<$Res> {
  factory $HomeMenuStateCopyWith(
          HomeMenuState value, $Res Function(HomeMenuState) then) =
      _$HomeMenuStateCopyWithImpl<$Res, HomeMenuState>;
  @useResult
  $Res call({String menuFlag, String menuName});
}

/// @nodoc
class _$HomeMenuStateCopyWithImpl<$Res, $Val extends HomeMenuState>
    implements $HomeMenuStateCopyWith<$Res> {
  _$HomeMenuStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuFlag = null,
    Object? menuName = null,
  }) {
    return _then(_value.copyWith(
      menuFlag: null == menuFlag
          ? _value.menuFlag
          : menuFlag // ignore: cast_nullable_to_non_nullable
              as String,
      menuName: null == menuName
          ? _value.menuName
          : menuName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeMenuStateImplCopyWith<$Res>
    implements $HomeMenuStateCopyWith<$Res> {
  factory _$$HomeMenuStateImplCopyWith(
          _$HomeMenuStateImpl value, $Res Function(_$HomeMenuStateImpl) then) =
      __$$HomeMenuStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String menuFlag, String menuName});
}

/// @nodoc
class __$$HomeMenuStateImplCopyWithImpl<$Res>
    extends _$HomeMenuStateCopyWithImpl<$Res, _$HomeMenuStateImpl>
    implements _$$HomeMenuStateImplCopyWith<$Res> {
  __$$HomeMenuStateImplCopyWithImpl(
      _$HomeMenuStateImpl _value, $Res Function(_$HomeMenuStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuFlag = null,
    Object? menuName = null,
  }) {
    return _then(_$HomeMenuStateImpl(
      menuFlag: null == menuFlag
          ? _value.menuFlag
          : menuFlag // ignore: cast_nullable_to_non_nullable
              as String,
      menuName: null == menuName
          ? _value.menuName
          : menuName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HomeMenuStateImpl implements _HomeMenuState {
  const _$HomeMenuStateImpl({this.menuFlag = '', this.menuName = ''});

  @override
  @JsonKey()
  final String menuFlag;
  @override
  @JsonKey()
  final String menuName;

  @override
  String toString() {
    return 'HomeMenuState(menuFlag: $menuFlag, menuName: $menuName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeMenuStateImpl &&
            (identical(other.menuFlag, menuFlag) ||
                other.menuFlag == menuFlag) &&
            (identical(other.menuName, menuName) ||
                other.menuName == menuName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, menuFlag, menuName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeMenuStateImplCopyWith<_$HomeMenuStateImpl> get copyWith =>
      __$$HomeMenuStateImplCopyWithImpl<_$HomeMenuStateImpl>(this, _$identity);
}

abstract class _HomeMenuState implements HomeMenuState {
  const factory _HomeMenuState({final String menuFlag, final String menuName}) =
      _$HomeMenuStateImpl;

  @override
  String get menuFlag;
  @override
  String get menuName;
  @override
  @JsonKey(ignore: true)
  _$$HomeMenuStateImplCopyWith<_$HomeMenuStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
