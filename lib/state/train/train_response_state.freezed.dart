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
  List<Train> get trainList => throw _privateConstructorUsedError;
  Map<String, Train> get trainMap => throw _privateConstructorUsedError;

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
  $Res call({List<Train> trainList, Map<String, Train> trainMap});
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
    Object? trainList = null,
    Object? trainMap = null,
  }) {
    return _then(_value.copyWith(
      trainList: null == trainList
          ? _value.trainList
          : trainList // ignore: cast_nullable_to_non_nullable
              as List<Train>,
      trainMap: null == trainMap
          ? _value.trainMap
          : trainMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Train>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TrainResponseStateCopyWith<$Res>
    implements $TrainResponseStateCopyWith<$Res> {
  factory _$$_TrainResponseStateCopyWith(_$_TrainResponseState value,
          $Res Function(_$_TrainResponseState) then) =
      __$$_TrainResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Train> trainList, Map<String, Train> trainMap});
}

/// @nodoc
class __$$_TrainResponseStateCopyWithImpl<$Res>
    extends _$TrainResponseStateCopyWithImpl<$Res, _$_TrainResponseState>
    implements _$$_TrainResponseStateCopyWith<$Res> {
  __$$_TrainResponseStateCopyWithImpl(
      _$_TrainResponseState _value, $Res Function(_$_TrainResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trainList = null,
    Object? trainMap = null,
  }) {
    return _then(_$_TrainResponseState(
      trainList: null == trainList
          ? _value._trainList
          : trainList // ignore: cast_nullable_to_non_nullable
              as List<Train>,
      trainMap: null == trainMap
          ? _value._trainMap
          : trainMap // ignore: cast_nullable_to_non_nullable
              as Map<String, Train>,
    ));
  }
}

/// @nodoc

class _$_TrainResponseState implements _TrainResponseState {
  const _$_TrainResponseState(
      {final List<Train> trainList = const [],
      final Map<String, Train> trainMap = const {}})
      : _trainList = trainList,
        _trainMap = trainMap;

  final List<Train> _trainList;
  @override
  @JsonKey()
  List<Train> get trainList {
    if (_trainList is EqualUnmodifiableListView) return _trainList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trainList);
  }

  final Map<String, Train> _trainMap;
  @override
  @JsonKey()
  Map<String, Train> get trainMap {
    if (_trainMap is EqualUnmodifiableMapView) return _trainMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_trainMap);
  }

  @override
  String toString() {
    return 'TrainResponseState(trainList: $trainList, trainMap: $trainMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrainResponseState &&
            const DeepCollectionEquality()
                .equals(other._trainList, _trainList) &&
            const DeepCollectionEquality().equals(other._trainMap, _trainMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_trainList),
      const DeepCollectionEquality().hash(_trainMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrainResponseStateCopyWith<_$_TrainResponseState> get copyWith =>
      __$$_TrainResponseStateCopyWithImpl<_$_TrainResponseState>(
          this, _$identity);
}

abstract class _TrainResponseState implements TrainResponseState {
  const factory _TrainResponseState(
      {final List<Train> trainList,
      final Map<String, Train> trainMap}) = _$_TrainResponseState;

  @override
  List<Train> get trainList;
  @override
  Map<String, Train> get trainMap;
  @override
  @JsonKey(ignore: true)
  _$$_TrainResponseStateCopyWith<_$_TrainResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}
