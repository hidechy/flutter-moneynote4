// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'walk_record_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WalkRecordResponseState {
  AsyncValue<List<WalkRecord>> get walkRecordList =>
      throw _privateConstructorUsedError;
  AsyncValue<Map<String, WalkRecord>> get walkRecordMap =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalkRecordResponseStateCopyWith<WalkRecordResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalkRecordResponseStateCopyWith<$Res> {
  factory $WalkRecordResponseStateCopyWith(WalkRecordResponseState value,
          $Res Function(WalkRecordResponseState) then) =
      _$WalkRecordResponseStateCopyWithImpl<$Res, WalkRecordResponseState>;
  @useResult
  $Res call(
      {AsyncValue<List<WalkRecord>> walkRecordList,
      AsyncValue<Map<String, WalkRecord>> walkRecordMap});
}

/// @nodoc
class _$WalkRecordResponseStateCopyWithImpl<$Res,
        $Val extends WalkRecordResponseState>
    implements $WalkRecordResponseStateCopyWith<$Res> {
  _$WalkRecordResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walkRecordList = null,
    Object? walkRecordMap = null,
  }) {
    return _then(_value.copyWith(
      walkRecordList: null == walkRecordList
          ? _value.walkRecordList
          : walkRecordList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<WalkRecord>>,
      walkRecordMap: null == walkRecordMap
          ? _value.walkRecordMap
          : walkRecordMap // ignore: cast_nullable_to_non_nullable
              as AsyncValue<Map<String, WalkRecord>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalkRecordResponseStateImplCopyWith<$Res>
    implements $WalkRecordResponseStateCopyWith<$Res> {
  factory _$$WalkRecordResponseStateImplCopyWith(
          _$WalkRecordResponseStateImpl value,
          $Res Function(_$WalkRecordResponseStateImpl) then) =
      __$$WalkRecordResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncValue<List<WalkRecord>> walkRecordList,
      AsyncValue<Map<String, WalkRecord>> walkRecordMap});
}

/// @nodoc
class __$$WalkRecordResponseStateImplCopyWithImpl<$Res>
    extends _$WalkRecordResponseStateCopyWithImpl<$Res,
        _$WalkRecordResponseStateImpl>
    implements _$$WalkRecordResponseStateImplCopyWith<$Res> {
  __$$WalkRecordResponseStateImplCopyWithImpl(
      _$WalkRecordResponseStateImpl _value,
      $Res Function(_$WalkRecordResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walkRecordList = null,
    Object? walkRecordMap = null,
  }) {
    return _then(_$WalkRecordResponseStateImpl(
      walkRecordList: null == walkRecordList
          ? _value.walkRecordList
          : walkRecordList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<WalkRecord>>,
      walkRecordMap: null == walkRecordMap
          ? _value.walkRecordMap
          : walkRecordMap // ignore: cast_nullable_to_non_nullable
              as AsyncValue<Map<String, WalkRecord>>,
    ));
  }
}

/// @nodoc

class _$WalkRecordResponseStateImpl implements _WalkRecordResponseState {
  const _$WalkRecordResponseStateImpl(
      {this.walkRecordList = const AsyncValue<List<WalkRecord>>.loading(),
      this.walkRecordMap =
          const AsyncValue<Map<String, WalkRecord>>.loading()});

  @override
  @JsonKey()
  final AsyncValue<List<WalkRecord>> walkRecordList;
  @override
  @JsonKey()
  final AsyncValue<Map<String, WalkRecord>> walkRecordMap;

  @override
  String toString() {
    return 'WalkRecordResponseState(walkRecordList: $walkRecordList, walkRecordMap: $walkRecordMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalkRecordResponseStateImpl &&
            (identical(other.walkRecordList, walkRecordList) ||
                other.walkRecordList == walkRecordList) &&
            (identical(other.walkRecordMap, walkRecordMap) ||
                other.walkRecordMap == walkRecordMap));
  }

  @override
  int get hashCode => Object.hash(runtimeType, walkRecordList, walkRecordMap);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalkRecordResponseStateImplCopyWith<_$WalkRecordResponseStateImpl>
      get copyWith => __$$WalkRecordResponseStateImplCopyWithImpl<
          _$WalkRecordResponseStateImpl>(this, _$identity);
}

abstract class _WalkRecordResponseState implements WalkRecordResponseState {
  const factory _WalkRecordResponseState(
          {final AsyncValue<List<WalkRecord>> walkRecordList,
          final AsyncValue<Map<String, WalkRecord>> walkRecordMap}) =
      _$WalkRecordResponseStateImpl;

  @override
  AsyncValue<List<WalkRecord>> get walkRecordList;
  @override
  AsyncValue<Map<String, WalkRecord>> get walkRecordMap;
  @override
  @JsonKey(ignore: true)
  _$$WalkRecordResponseStateImplCopyWith<_$WalkRecordResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
