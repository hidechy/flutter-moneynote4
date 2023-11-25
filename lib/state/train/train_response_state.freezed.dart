// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'train_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrainResponseState {
  Map<String, Train> get trainMap => throw _privateConstructorUsedError;
  AsyncValue<List<Train>> get trainList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrainResponseStateCopyWith<TrainResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainResponseStateCopyWith<$Res> {
  factory $TrainResponseStateCopyWith(
          TrainResponseState value, $Res Function(TrainResponseState) then) =
      _$TrainResponseStateCopyWithImpl<$Res, TrainResponseState>;
  @useResult
  $Res call({Map<String, Train> trainMap, AsyncValue<List<Train>> trainList});
}

/// @nodoc
class _$TrainResponseStateCopyWithImpl<$Res, $Val extends TrainResponseState>
    implements $TrainResponseStateCopyWith<$Res> {
  _$TrainResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainMap = null,
    Object? trainList = null,
  }) {
    return _then(_value.copyWith(
      trainMap: null == trainMap
          ? _value.trainMap
          : trainMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Train>,
      trainList: null == trainList
          ? _value.trainList
          : trainList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Train>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrainResponseStateImplCopyWith<$Res>
    implements $TrainResponseStateCopyWith<$Res> {
  factory _$$TrainResponseStateImplCopyWith(_$TrainResponseStateImpl value,
          $Res Function(_$TrainResponseStateImpl) then) =
      __$$TrainResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, Train> trainMap, AsyncValue<List<Train>> trainList});
}

/// @nodoc
class __$$TrainResponseStateImplCopyWithImpl<$Res>
    extends _$TrainResponseStateCopyWithImpl<$Res, _$TrainResponseStateImpl>
    implements _$$TrainResponseStateImplCopyWith<$Res> {
  __$$TrainResponseStateImplCopyWithImpl(_$TrainResponseStateImpl _value,
      $Res Function(_$TrainResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainMap = null,
    Object? trainList = null,
  }) {
    return _then(_$TrainResponseStateImpl(
      trainMap: null == trainMap
          ? _value._trainMap
          : trainMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Train>,
      trainList: null == trainList
          ? _value.trainList
          : trainList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<Train>>,
    ));
  }
}

/// @nodoc

class _$TrainResponseStateImpl implements _TrainResponseState {
  const _$TrainResponseStateImpl(
      {final Map<String, Train> trainMap = const {},
      this.trainList = const AsyncValue<List<Train>>.loading()})
      : _trainMap = trainMap;

  final Map<String, Train> _trainMap;
  @override
  @JsonKey()
  Map<String, Train> get trainMap {
    if (_trainMap is EqualUnmodifiableMapView) return _trainMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_trainMap);
  }

  @override
  @JsonKey()
  final AsyncValue<List<Train>> trainList;

  @override
  String toString() {
    return 'TrainResponseState(trainMap: $trainMap, trainList: $trainList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainResponseStateImpl &&
            const DeepCollectionEquality().equals(other._trainMap, _trainMap) &&
            (identical(other.trainList, trainList) ||
                other.trainList == trainList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_trainMap), trainList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainResponseStateImplCopyWith<_$TrainResponseStateImpl> get copyWith =>
      __$$TrainResponseStateImplCopyWithImpl<_$TrainResponseStateImpl>(
          this, _$identity);
}

abstract class _TrainResponseState implements TrainResponseState {
  const factory _TrainResponseState(
      {final Map<String, Train> trainMap,
      final AsyncValue<List<Train>> trainList}) = _$TrainResponseStateImpl;

  @override
  Map<String, Train> get trainMap;
  @override
  AsyncValue<List<Train>> get trainList;
  @override
  @JsonKey(ignore: true)
  _$$TrainResponseStateImplCopyWith<_$TrainResponseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
