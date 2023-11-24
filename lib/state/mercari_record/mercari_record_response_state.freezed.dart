// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mercari_record_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MercariRecordResponseState {
  AsyncValue<List<MercariRecord>> get mercariRecordList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MercariRecordResponseStateCopyWith<MercariRecordResponseState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MercariRecordResponseStateCopyWith<$Res> {
  factory $MercariRecordResponseStateCopyWith(MercariRecordResponseState value,
          $Res Function(MercariRecordResponseState) then) =
      _$MercariRecordResponseStateCopyWithImpl<$Res,
          MercariRecordResponseState>;
  @useResult
  $Res call({AsyncValue<List<MercariRecord>> mercariRecordList});
}

/// @nodoc
class _$MercariRecordResponseStateCopyWithImpl<$Res,
        $Val extends MercariRecordResponseState>
    implements $MercariRecordResponseStateCopyWith<$Res> {
  _$MercariRecordResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mercariRecordList = null,
  }) {
    return _then(_value.copyWith(
      mercariRecordList: null == mercariRecordList
          ? _value.mercariRecordList
          : mercariRecordList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<MercariRecord>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MercariRecordResponseStateImplCopyWith<$Res>
    implements $MercariRecordResponseStateCopyWith<$Res> {
  factory _$$MercariRecordResponseStateImplCopyWith(
          _$MercariRecordResponseStateImpl value,
          $Res Function(_$MercariRecordResponseStateImpl) then) =
      __$$MercariRecordResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<MercariRecord>> mercariRecordList});
}

/// @nodoc
class __$$MercariRecordResponseStateImplCopyWithImpl<$Res>
    extends _$MercariRecordResponseStateCopyWithImpl<$Res,
        _$MercariRecordResponseStateImpl>
    implements _$$MercariRecordResponseStateImplCopyWith<$Res> {
  __$$MercariRecordResponseStateImplCopyWithImpl(
      _$MercariRecordResponseStateImpl _value,
      $Res Function(_$MercariRecordResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mercariRecordList = null,
  }) {
    return _then(_$MercariRecordResponseStateImpl(
      mercariRecordList: null == mercariRecordList
          ? _value.mercariRecordList
          : mercariRecordList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<MercariRecord>>,
    ));
  }
}

/// @nodoc

class _$MercariRecordResponseStateImpl implements _MercariRecordResponseState {
  const _$MercariRecordResponseStateImpl(
      {this.mercariRecordList =
          const AsyncValue<List<MercariRecord>>.loading()});

  @override
  @JsonKey()
  final AsyncValue<List<MercariRecord>> mercariRecordList;

  @override
  String toString() {
    return 'MercariRecordResponseState(mercariRecordList: $mercariRecordList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MercariRecordResponseStateImpl &&
            (identical(other.mercariRecordList, mercariRecordList) ||
                other.mercariRecordList == mercariRecordList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mercariRecordList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MercariRecordResponseStateImplCopyWith<_$MercariRecordResponseStateImpl>
      get copyWith => __$$MercariRecordResponseStateImplCopyWithImpl<
          _$MercariRecordResponseStateImpl>(this, _$identity);
}

abstract class _MercariRecordResponseState
    implements MercariRecordResponseState {
  const factory _MercariRecordResponseState(
          {final AsyncValue<List<MercariRecord>> mercariRecordList}) =
      _$MercariRecordResponseStateImpl;

  @override
  AsyncValue<List<MercariRecord>> get mercariRecordList;
  @override
  @JsonKey(ignore: true)
  _$$MercariRecordResponseStateImplCopyWith<_$MercariRecordResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
