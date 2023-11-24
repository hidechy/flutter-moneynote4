// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seiyu_purchase_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SeiyuPurchaseResponseState {
  AsyncValue<List<SeiyuPurchase>> get seiyuPurchaseList =>
      throw _privateConstructorUsedError;
  AsyncValue<List<SeiyuItem>> get seiyuItemList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeiyuPurchaseResponseStateCopyWith<SeiyuPurchaseResponseState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeiyuPurchaseResponseStateCopyWith<$Res> {
  factory $SeiyuPurchaseResponseStateCopyWith(SeiyuPurchaseResponseState value,
          $Res Function(SeiyuPurchaseResponseState) then) =
      _$SeiyuPurchaseResponseStateCopyWithImpl<$Res,
          SeiyuPurchaseResponseState>;
  @useResult
  $Res call(
      {AsyncValue<List<SeiyuPurchase>> seiyuPurchaseList,
      AsyncValue<List<SeiyuItem>> seiyuItemList});
}

/// @nodoc
class _$SeiyuPurchaseResponseStateCopyWithImpl<$Res,
        $Val extends SeiyuPurchaseResponseState>
    implements $SeiyuPurchaseResponseStateCopyWith<$Res> {
  _$SeiyuPurchaseResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seiyuPurchaseList = null,
    Object? seiyuItemList = null,
  }) {
    return _then(_value.copyWith(
      seiyuPurchaseList: null == seiyuPurchaseList
          ? _value.seiyuPurchaseList
          : seiyuPurchaseList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SeiyuPurchase>>,
      seiyuItemList: null == seiyuItemList
          ? _value.seiyuItemList
          : seiyuItemList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SeiyuItem>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SeiyuPurchaseResponseStateCopyWith<$Res>
    implements $SeiyuPurchaseResponseStateCopyWith<$Res> {
  factory _$$_SeiyuPurchaseResponseStateCopyWith(
          _$_SeiyuPurchaseResponseState value,
          $Res Function(_$_SeiyuPurchaseResponseState) then) =
      __$$_SeiyuPurchaseResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncValue<List<SeiyuPurchase>> seiyuPurchaseList,
      AsyncValue<List<SeiyuItem>> seiyuItemList});
}

/// @nodoc
class __$$_SeiyuPurchaseResponseStateCopyWithImpl<$Res>
    extends _$SeiyuPurchaseResponseStateCopyWithImpl<$Res,
        _$_SeiyuPurchaseResponseState>
    implements _$$_SeiyuPurchaseResponseStateCopyWith<$Res> {
  __$$_SeiyuPurchaseResponseStateCopyWithImpl(
      _$_SeiyuPurchaseResponseState _value,
      $Res Function(_$_SeiyuPurchaseResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seiyuPurchaseList = null,
    Object? seiyuItemList = null,
  }) {
    return _then(_$_SeiyuPurchaseResponseState(
      seiyuPurchaseList: null == seiyuPurchaseList
          ? _value.seiyuPurchaseList
          : seiyuPurchaseList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SeiyuPurchase>>,
      seiyuItemList: null == seiyuItemList
          ? _value.seiyuItemList
          : seiyuItemList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<SeiyuItem>>,
    ));
  }
}

/// @nodoc

class _$_SeiyuPurchaseResponseState implements _SeiyuPurchaseResponseState {
  const _$_SeiyuPurchaseResponseState(
      {this.seiyuPurchaseList = const AsyncValue<List<SeiyuPurchase>>.loading(),
      this.seiyuItemList = const AsyncValue<List<SeiyuItem>>.loading()});

  @override
  @JsonKey()
  final AsyncValue<List<SeiyuPurchase>> seiyuPurchaseList;
  @override
  @JsonKey()
  final AsyncValue<List<SeiyuItem>> seiyuItemList;

  @override
  String toString() {
    return 'SeiyuPurchaseResponseState(seiyuPurchaseList: $seiyuPurchaseList, seiyuItemList: $seiyuItemList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeiyuPurchaseResponseState &&
            (identical(other.seiyuPurchaseList, seiyuPurchaseList) ||
                other.seiyuPurchaseList == seiyuPurchaseList) &&
            (identical(other.seiyuItemList, seiyuItemList) ||
                other.seiyuItemList == seiyuItemList));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, seiyuPurchaseList, seiyuItemList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SeiyuPurchaseResponseStateCopyWith<_$_SeiyuPurchaseResponseState>
      get copyWith => __$$_SeiyuPurchaseResponseStateCopyWithImpl<
          _$_SeiyuPurchaseResponseState>(this, _$identity);
}

abstract class _SeiyuPurchaseResponseState
    implements SeiyuPurchaseResponseState {
  const factory _SeiyuPurchaseResponseState(
          {final AsyncValue<List<SeiyuPurchase>> seiyuPurchaseList,
          final AsyncValue<List<SeiyuItem>> seiyuItemList}) =
      _$_SeiyuPurchaseResponseState;

  @override
  AsyncValue<List<SeiyuPurchase>> get seiyuPurchaseList;
  @override
  AsyncValue<List<SeiyuItem>> get seiyuItemList;
  @override
  @JsonKey(ignore: true)
  _$$_SeiyuPurchaseResponseStateCopyWith<_$_SeiyuPurchaseResponseState>
      get copyWith => throw _privateConstructorUsedError;
}
