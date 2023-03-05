// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'keihi_list_request_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$KeihiListRequestState {
  DateTime? get selectDate => throw _privateConstructorUsedError;
  String get selectOrder => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KeihiListRequestStateCopyWith<KeihiListRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeihiListRequestStateCopyWith<$Res> {
  factory $KeihiListRequestStateCopyWith(KeihiListRequestState value,
          $Res Function(KeihiListRequestState) then) =
      _$KeihiListRequestStateCopyWithImpl<$Res, KeihiListRequestState>;
  @useResult
  $Res call({DateTime? selectDate, String selectOrder});
}

/// @nodoc
class _$KeihiListRequestStateCopyWithImpl<$Res,
        $Val extends KeihiListRequestState>
    implements $KeihiListRequestStateCopyWith<$Res> {
  _$KeihiListRequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectDate = freezed,
    Object? selectOrder = null,
  }) {
    return _then(_value.copyWith(
      selectDate: freezed == selectDate
          ? _value.selectDate
          : selectDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectOrder: null == selectOrder
          ? _value.selectOrder
          : selectOrder // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_KeihiListRequestStateCopyWith<$Res>
    implements $KeihiListRequestStateCopyWith<$Res> {
  factory _$$_KeihiListRequestStateCopyWith(_$_KeihiListRequestState value,
          $Res Function(_$_KeihiListRequestState) then) =
      __$$_KeihiListRequestStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? selectDate, String selectOrder});
}

/// @nodoc
class __$$_KeihiListRequestStateCopyWithImpl<$Res>
    extends _$KeihiListRequestStateCopyWithImpl<$Res, _$_KeihiListRequestState>
    implements _$$_KeihiListRequestStateCopyWith<$Res> {
  __$$_KeihiListRequestStateCopyWithImpl(_$_KeihiListRequestState _value,
      $Res Function(_$_KeihiListRequestState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectDate = freezed,
    Object? selectOrder = null,
  }) {
    return _then(_$_KeihiListRequestState(
      selectDate: freezed == selectDate
          ? _value.selectDate
          : selectDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectOrder: null == selectOrder
          ? _value.selectOrder
          : selectOrder // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_KeihiListRequestState implements _KeihiListRequestState {
  const _$_KeihiListRequestState({this.selectDate, this.selectOrder = ''});

  @override
  final DateTime? selectDate;
  @override
  @JsonKey()
  final String selectOrder;

  @override
  String toString() {
    return 'KeihiListRequestState(selectDate: $selectDate, selectOrder: $selectOrder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_KeihiListRequestState &&
            (identical(other.selectDate, selectDate) ||
                other.selectDate == selectDate) &&
            (identical(other.selectOrder, selectOrder) ||
                other.selectOrder == selectOrder));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectDate, selectOrder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_KeihiListRequestStateCopyWith<_$_KeihiListRequestState> get copyWith =>
      __$$_KeihiListRequestStateCopyWithImpl<_$_KeihiListRequestState>(
          this, _$identity);
}

abstract class _KeihiListRequestState implements KeihiListRequestState {
  const factory _KeihiListRequestState(
      {final DateTime? selectDate,
      final String selectOrder}) = _$_KeihiListRequestState;

  @override
  DateTime? get selectDate;
  @override
  String get selectOrder;
  @override
  @JsonKey(ignore: true)
  _$$_KeihiListRequestStateCopyWith<_$_KeihiListRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}
