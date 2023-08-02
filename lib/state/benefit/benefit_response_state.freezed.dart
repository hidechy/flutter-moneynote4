// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'benefit_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BenefitResponseState {
  List<Benefit> get benefitList => throw _privateConstructorUsedError;
  Map<String, Benefit> get benefitMap => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BenefitResponseStateCopyWith<BenefitResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BenefitResponseStateCopyWith<$Res> {
  factory $BenefitResponseStateCopyWith(BenefitResponseState value,
          $Res Function(BenefitResponseState) then) =
      _$BenefitResponseStateCopyWithImpl<$Res, BenefitResponseState>;
  @useResult
  $Res call({List<Benefit> benefitList, Map<String, Benefit> benefitMap});
}

/// @nodoc
class _$BenefitResponseStateCopyWithImpl<$Res,
        $Val extends BenefitResponseState>
    implements $BenefitResponseStateCopyWith<$Res> {
  _$BenefitResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? benefitList = null,
    Object? benefitMap = null,
  }) {
    return _then(_value.copyWith(
      benefitList: null == benefitList
          ? _value.benefitList
          : benefitList // ignore: cast_nullable_to_non_nullable
              as List<Benefit>,
      benefitMap: null == benefitMap
          ? _value.benefitMap
          : benefitMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Benefit>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BenefitResponseStateCopyWith<$Res>
    implements $BenefitResponseStateCopyWith<$Res> {
  factory _$$_BenefitResponseStateCopyWith(_$_BenefitResponseState value,
          $Res Function(_$_BenefitResponseState) then) =
      __$$_BenefitResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Benefit> benefitList, Map<String, Benefit> benefitMap});
}

/// @nodoc
class __$$_BenefitResponseStateCopyWithImpl<$Res>
    extends _$BenefitResponseStateCopyWithImpl<$Res, _$_BenefitResponseState>
    implements _$$_BenefitResponseStateCopyWith<$Res> {
  __$$_BenefitResponseStateCopyWithImpl(_$_BenefitResponseState _value,
      $Res Function(_$_BenefitResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? benefitList = null,
    Object? benefitMap = null,
  }) {
    return _then(_$_BenefitResponseState(
      benefitList: null == benefitList
          ? _value._benefitList
          : benefitList // ignore: cast_nullable_to_non_nullable
              as List<Benefit>,
      benefitMap: null == benefitMap
          ? _value._benefitMap
          : benefitMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Benefit>,
    ));
  }
}

/// @nodoc

class _$_BenefitResponseState implements _BenefitResponseState {
  const _$_BenefitResponseState(
      {final List<Benefit> benefitList = const [],
      final Map<String, Benefit> benefitMap = const {}})
      : _benefitList = benefitList,
        _benefitMap = benefitMap;

  final List<Benefit> _benefitList;
  @override
  @JsonKey()
  List<Benefit> get benefitList {
    if (_benefitList is EqualUnmodifiableListView) return _benefitList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_benefitList);
  }

  final Map<String, Benefit> _benefitMap;
  @override
  @JsonKey()
  Map<String, Benefit> get benefitMap {
    if (_benefitMap is EqualUnmodifiableMapView) return _benefitMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_benefitMap);
  }

  @override
  String toString() {
    return 'BenefitResponseState(benefitList: $benefitList, benefitMap: $benefitMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BenefitResponseState &&
            const DeepCollectionEquality()
                .equals(other._benefitList, _benefitList) &&
            const DeepCollectionEquality()
                .equals(other._benefitMap, _benefitMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_benefitList),
      const DeepCollectionEquality().hash(_benefitMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BenefitResponseStateCopyWith<_$_BenefitResponseState> get copyWith =>
      __$$_BenefitResponseStateCopyWithImpl<_$_BenefitResponseState>(
          this, _$identity);
}

abstract class _BenefitResponseState implements BenefitResponseState {
  const factory _BenefitResponseState(
      {final List<Benefit> benefitList,
      final Map<String, Benefit> benefitMap}) = _$_BenefitResponseState;

  @override
  List<Benefit> get benefitList;
  @override
  Map<String, Benefit> get benefitMap;
  @override
  @JsonKey(ignore: true)
  _$$_BenefitResponseStateCopyWith<_$_BenefitResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}
