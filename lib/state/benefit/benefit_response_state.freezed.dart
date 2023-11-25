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
  Map<String, Benefit> get benefitMap => throw _privateConstructorUsedError; //
  AsyncValue<List<Benefit>> get benefitList =>
      throw _privateConstructorUsedError;

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
  $Res call(
      {Map<String, Benefit> benefitMap, AsyncValue<List<Benefit>> benefitList});
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
    Object? benefitMap = null,
    Object? benefitList = null,
  }) {
    return _then(_value.copyWith(
      benefitMap: null == benefitMap
          ? _value.benefitMap
          : benefitMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Benefit>,
      benefitList: null == benefitList
          ? _value.benefitList
          : benefitList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Benefit>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BenefitResponseStateImplCopyWith<$Res>
    implements $BenefitResponseStateCopyWith<$Res> {
  factory _$$BenefitResponseStateImplCopyWith(_$BenefitResponseStateImpl value,
          $Res Function(_$BenefitResponseStateImpl) then) =
      __$$BenefitResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, Benefit> benefitMap, AsyncValue<List<Benefit>> benefitList});
}

/// @nodoc
class __$$BenefitResponseStateImplCopyWithImpl<$Res>
    extends _$BenefitResponseStateCopyWithImpl<$Res, _$BenefitResponseStateImpl>
    implements _$$BenefitResponseStateImplCopyWith<$Res> {
  __$$BenefitResponseStateImplCopyWithImpl(_$BenefitResponseStateImpl _value,
      $Res Function(_$BenefitResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? benefitMap = null,
    Object? benefitList = null,
  }) {
    return _then(_$BenefitResponseStateImpl(
      benefitMap: null == benefitMap
          ? _value._benefitMap
          : benefitMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Benefit>,
      benefitList: null == benefitList
          ? _value.benefitList
          : benefitList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Benefit>>,
    ));
  }
}

/// @nodoc

class _$BenefitResponseStateImpl implements _BenefitResponseState {
  const _$BenefitResponseStateImpl(
      {final Map<String, Benefit> benefitMap = const {},
      this.benefitList = const AsyncValue<List<Benefit>>.loading()})
      : _benefitMap = benefitMap;

  final Map<String, Benefit> _benefitMap;
  @override
  @JsonKey()
  Map<String, Benefit> get benefitMap {
    if (_benefitMap is EqualUnmodifiableMapView) return _benefitMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_benefitMap);
  }

//
  @override
  @JsonKey()
  final AsyncValue<List<Benefit>> benefitList;

  @override
  String toString() {
    return 'BenefitResponseState(benefitMap: $benefitMap, benefitList: $benefitList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BenefitResponseStateImpl &&
            const DeepCollectionEquality()
                .equals(other._benefitMap, _benefitMap) &&
            (identical(other.benefitList, benefitList) ||
                other.benefitList == benefitList));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_benefitMap), benefitList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BenefitResponseStateImplCopyWith<_$BenefitResponseStateImpl>
      get copyWith =>
          __$$BenefitResponseStateImplCopyWithImpl<_$BenefitResponseStateImpl>(
              this, _$identity);
}

abstract class _BenefitResponseState implements BenefitResponseState {
  const factory _BenefitResponseState(
          {final Map<String, Benefit> benefitMap,
          final AsyncValue<List<Benefit>> benefitList}) =
      _$BenefitResponseStateImpl;

  @override
  Map<String, Benefit> get benefitMap;
  @override //
  AsyncValue<List<Benefit>> get benefitList;
  @override
  @JsonKey(ignore: true)
  _$$BenefitResponseStateImplCopyWith<_$BenefitResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
