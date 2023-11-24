// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeplace_input_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TimeplaceInputState {
  List<String> get time => throw _privateConstructorUsedError;
  List<String> get place => throw _privateConstructorUsedError;
  List<int> get spendPrice => throw _privateConstructorUsedError;
  int get itemPos => throw _privateConstructorUsedError;
  String get baseDiff => throw _privateConstructorUsedError;
  int get diff => throw _privateConstructorUsedError;
  List<bool> get minusCheck => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimeplaceInputStateCopyWith<TimeplaceInputState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeplaceInputStateCopyWith<$Res> {
  factory $TimeplaceInputStateCopyWith(
          TimeplaceInputState value, $Res Function(TimeplaceInputState) then) =
      _$TimeplaceInputStateCopyWithImpl<$Res, TimeplaceInputState>;
  @useResult
  $Res call(
      {List<String> time,
      List<String> place,
      List<int> spendPrice,
      int itemPos,
      String baseDiff,
      int diff,
      List<bool> minusCheck});
}

/// @nodoc
class _$TimeplaceInputStateCopyWithImpl<$Res, $Val extends TimeplaceInputState>
    implements $TimeplaceInputStateCopyWith<$Res> {
  _$TimeplaceInputStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? place = null,
    Object? spendPrice = null,
    Object? itemPos = null,
    Object? baseDiff = null,
    Object? diff = null,
    Object? minusCheck = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as List<String>,
      place: null == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spendPrice: null == spendPrice
          ? _value.spendPrice
          : spendPrice // ignore: cast_nullable_to_non_nullable
              as List<int>,
      itemPos: null == itemPos
          ? _value.itemPos
          : itemPos // ignore: cast_nullable_to_non_nullable
              as int,
      baseDiff: null == baseDiff
          ? _value.baseDiff
          : baseDiff // ignore: cast_nullable_to_non_nullable
              as String,
      diff: null == diff
          ? _value.diff
          : diff // ignore: cast_nullable_to_non_nullable
              as int,
      minusCheck: null == minusCheck
          ? _value.minusCheck
          : minusCheck // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeplaceInputStateImplCopyWith<$Res>
    implements $TimeplaceInputStateCopyWith<$Res> {
  factory _$$TimeplaceInputStateImplCopyWith(_$TimeplaceInputStateImpl value,
          $Res Function(_$TimeplaceInputStateImpl) then) =
      __$$TimeplaceInputStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> time,
      List<String> place,
      List<int> spendPrice,
      int itemPos,
      String baseDiff,
      int diff,
      List<bool> minusCheck});
}

/// @nodoc
class __$$TimeplaceInputStateImplCopyWithImpl<$Res>
    extends _$TimeplaceInputStateCopyWithImpl<$Res, _$TimeplaceInputStateImpl>
    implements _$$TimeplaceInputStateImplCopyWith<$Res> {
  __$$TimeplaceInputStateImplCopyWithImpl(_$TimeplaceInputStateImpl _value,
      $Res Function(_$TimeplaceInputStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? place = null,
    Object? spendPrice = null,
    Object? itemPos = null,
    Object? baseDiff = null,
    Object? diff = null,
    Object? minusCheck = null,
  }) {
    return _then(_$TimeplaceInputStateImpl(
      time: null == time
          ? _value._time
          : time // ignore: cast_nullable_to_non_nullable
              as List<String>,
      place: null == place
          ? _value._place
          : place // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spendPrice: null == spendPrice
          ? _value._spendPrice
          : spendPrice // ignore: cast_nullable_to_non_nullable
              as List<int>,
      itemPos: null == itemPos
          ? _value.itemPos
          : itemPos // ignore: cast_nullable_to_non_nullable
              as int,
      baseDiff: null == baseDiff
          ? _value.baseDiff
          : baseDiff // ignore: cast_nullable_to_non_nullable
              as String,
      diff: null == diff
          ? _value.diff
          : diff // ignore: cast_nullable_to_non_nullable
              as int,
      minusCheck: null == minusCheck
          ? _value._minusCheck
          : minusCheck // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ));
  }
}

/// @nodoc

class _$TimeplaceInputStateImpl implements _TimeplaceInputState {
  const _$TimeplaceInputStateImpl(
      {final List<String> time = const [],
      final List<String> place = const [],
      final List<int> spendPrice = const [],
      this.itemPos = 0,
      this.baseDiff = '',
      this.diff = 0,
      final List<bool> minusCheck = const []})
      : _time = time,
        _place = place,
        _spendPrice = spendPrice,
        _minusCheck = minusCheck;

  final List<String> _time;
  @override
  @JsonKey()
  List<String> get time {
    if (_time is EqualUnmodifiableListView) return _time;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_time);
  }

  final List<String> _place;
  @override
  @JsonKey()
  List<String> get place {
    if (_place is EqualUnmodifiableListView) return _place;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_place);
  }

  final List<int> _spendPrice;
  @override
  @JsonKey()
  List<int> get spendPrice {
    if (_spendPrice is EqualUnmodifiableListView) return _spendPrice;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spendPrice);
  }

  @override
  @JsonKey()
  final int itemPos;
  @override
  @JsonKey()
  final String baseDiff;
  @override
  @JsonKey()
  final int diff;
  final List<bool> _minusCheck;
  @override
  @JsonKey()
  List<bool> get minusCheck {
    if (_minusCheck is EqualUnmodifiableListView) return _minusCheck;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_minusCheck);
  }

  @override
  String toString() {
    return 'TimeplaceInputState(time: $time, place: $place, spendPrice: $spendPrice, itemPos: $itemPos, baseDiff: $baseDiff, diff: $diff, minusCheck: $minusCheck)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeplaceInputStateImpl &&
            const DeepCollectionEquality().equals(other._time, _time) &&
            const DeepCollectionEquality().equals(other._place, _place) &&
            const DeepCollectionEquality()
                .equals(other._spendPrice, _spendPrice) &&
            (identical(other.itemPos, itemPos) || other.itemPos == itemPos) &&
            (identical(other.baseDiff, baseDiff) ||
                other.baseDiff == baseDiff) &&
            (identical(other.diff, diff) || other.diff == diff) &&
            const DeepCollectionEquality()
                .equals(other._minusCheck, _minusCheck));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_time),
      const DeepCollectionEquality().hash(_place),
      const DeepCollectionEquality().hash(_spendPrice),
      itemPos,
      baseDiff,
      diff,
      const DeepCollectionEquality().hash(_minusCheck));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeplaceInputStateImplCopyWith<_$TimeplaceInputStateImpl> get copyWith =>
      __$$TimeplaceInputStateImplCopyWithImpl<_$TimeplaceInputStateImpl>(
          this, _$identity);
}

abstract class _TimeplaceInputState implements TimeplaceInputState {
  const factory _TimeplaceInputState(
      {final List<String> time,
      final List<String> place,
      final List<int> spendPrice,
      final int itemPos,
      final String baseDiff,
      final int diff,
      final List<bool> minusCheck}) = _$TimeplaceInputStateImpl;

  @override
  List<String> get time;
  @override
  List<String> get place;
  @override
  List<int> get spendPrice;
  @override
  int get itemPos;
  @override
  String get baseDiff;
  @override
  int get diff;
  @override
  List<bool> get minusCheck;
  @override
  @JsonKey(ignore: true)
  _$$TimeplaceInputStateImplCopyWith<_$TimeplaceInputStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
