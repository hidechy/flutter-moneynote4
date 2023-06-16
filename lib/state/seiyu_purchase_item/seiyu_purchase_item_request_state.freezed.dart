// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seiyu_purchase_item_request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SeiyuPurchaseItemRequestState {
  DateTime? get date => throw _privateConstructorUsedError;
  String get item => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeiyuPurchaseItemRequestStateCopyWith<SeiyuPurchaseItemRequestState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeiyuPurchaseItemRequestStateCopyWith<$Res> {
  factory $SeiyuPurchaseItemRequestStateCopyWith(
          SeiyuPurchaseItemRequestState value,
          $Res Function(SeiyuPurchaseItemRequestState) then) =
      _$SeiyuPurchaseItemRequestStateCopyWithImpl<$Res,
          SeiyuPurchaseItemRequestState>;
  @useResult
  $Res call({DateTime? date, String item});
}

/// @nodoc
class _$SeiyuPurchaseItemRequestStateCopyWithImpl<$Res,
        $Val extends SeiyuPurchaseItemRequestState>
    implements $SeiyuPurchaseItemRequestStateCopyWith<$Res> {
  _$SeiyuPurchaseItemRequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? item = null,
  }) {
    return _then(_value.copyWith(
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SeiyuPurchaseItemRequestStateCopyWith<$Res>
    implements $SeiyuPurchaseItemRequestStateCopyWith<$Res> {
  factory _$$_SeiyuPurchaseItemRequestStateCopyWith(
          _$_SeiyuPurchaseItemRequestState value,
          $Res Function(_$_SeiyuPurchaseItemRequestState) then) =
      __$$_SeiyuPurchaseItemRequestStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? date, String item});
}

/// @nodoc
class __$$_SeiyuPurchaseItemRequestStateCopyWithImpl<$Res>
    extends _$SeiyuPurchaseItemRequestStateCopyWithImpl<$Res,
        _$_SeiyuPurchaseItemRequestState>
    implements _$$_SeiyuPurchaseItemRequestStateCopyWith<$Res> {
  __$$_SeiyuPurchaseItemRequestStateCopyWithImpl(
      _$_SeiyuPurchaseItemRequestState _value,
      $Res Function(_$_SeiyuPurchaseItemRequestState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? item = null,
  }) {
    return _then(_$_SeiyuPurchaseItemRequestState(
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SeiyuPurchaseItemRequestState
    implements _SeiyuPurchaseItemRequestState {
  const _$_SeiyuPurchaseItemRequestState({this.date, this.item = ''});

  @override
  final DateTime? date;
  @override
  @JsonKey()
  final String item;

  @override
  String toString() {
    return 'SeiyuPurchaseItemRequestState(date: $date, item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeiyuPurchaseItemRequestState &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, item);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SeiyuPurchaseItemRequestStateCopyWith<_$_SeiyuPurchaseItemRequestState>
      get copyWith => __$$_SeiyuPurchaseItemRequestStateCopyWithImpl<
          _$_SeiyuPurchaseItemRequestState>(this, _$identity);
}

abstract class _SeiyuPurchaseItemRequestState
    implements SeiyuPurchaseItemRequestState {
  const factory _SeiyuPurchaseItemRequestState(
      {final DateTime? date,
      final String item}) = _$_SeiyuPurchaseItemRequestState;

  @override
  DateTime? get date;
  @override
  String get item;
  @override
  @JsonKey(ignore: true)
  _$$_SeiyuPurchaseItemRequestStateCopyWith<_$_SeiyuPurchaseItemRequestState>
      get copyWith => throw _privateConstructorUsedError;
}
