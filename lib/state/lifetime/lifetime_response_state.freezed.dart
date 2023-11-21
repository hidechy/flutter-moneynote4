// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lifetime_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LifetimeResponseState {
  Lifetime? get lifetime => throw _privateConstructorUsedError;
  DateTime? get selectedCalendarDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LifetimeResponseStateCopyWith<LifetimeResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LifetimeResponseStateCopyWith<$Res> {
  factory $LifetimeResponseStateCopyWith(LifetimeResponseState value,
          $Res Function(LifetimeResponseState) then) =
      _$LifetimeResponseStateCopyWithImpl<$Res, LifetimeResponseState>;
  @useResult
  $Res call({Lifetime? lifetime, DateTime? selectedCalendarDate});
}

/// @nodoc
class _$LifetimeResponseStateCopyWithImpl<$Res,
        $Val extends LifetimeResponseState>
    implements $LifetimeResponseStateCopyWith<$Res> {
  _$LifetimeResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lifetime = freezed,
    Object? selectedCalendarDate = freezed,
  }) {
    return _then(_value.copyWith(
      lifetime: freezed == lifetime
          ? _value.lifetime
          : lifetime // ignore: cast_nullable_to_non_nullable
              as Lifetime?,
      selectedCalendarDate: freezed == selectedCalendarDate
          ? _value.selectedCalendarDate
          : selectedCalendarDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LifetimeResponseStateCopyWith<$Res>
    implements $LifetimeResponseStateCopyWith<$Res> {
  factory _$$_LifetimeResponseStateCopyWith(_$_LifetimeResponseState value,
          $Res Function(_$_LifetimeResponseState) then) =
      __$$_LifetimeResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Lifetime? lifetime, DateTime? selectedCalendarDate});
}

/// @nodoc
class __$$_LifetimeResponseStateCopyWithImpl<$Res>
    extends _$LifetimeResponseStateCopyWithImpl<$Res, _$_LifetimeResponseState>
    implements _$$_LifetimeResponseStateCopyWith<$Res> {
  __$$_LifetimeResponseStateCopyWithImpl(_$_LifetimeResponseState _value,
      $Res Function(_$_LifetimeResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lifetime = freezed,
    Object? selectedCalendarDate = freezed,
  }) {
    return _then(_$_LifetimeResponseState(
      lifetime: freezed == lifetime
          ? _value.lifetime
          : lifetime // ignore: cast_nullable_to_non_nullable
              as Lifetime?,
      selectedCalendarDate: freezed == selectedCalendarDate
          ? _value.selectedCalendarDate
          : selectedCalendarDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_LifetimeResponseState implements _LifetimeResponseState {
  const _$_LifetimeResponseState({this.lifetime, this.selectedCalendarDate});

  @override
  final Lifetime? lifetime;
  @override
  final DateTime? selectedCalendarDate;

  @override
  String toString() {
    return 'LifetimeResponseState(lifetime: $lifetime, selectedCalendarDate: $selectedCalendarDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LifetimeResponseState &&
            (identical(other.lifetime, lifetime) ||
                other.lifetime == lifetime) &&
            (identical(other.selectedCalendarDate, selectedCalendarDate) ||
                other.selectedCalendarDate == selectedCalendarDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lifetime, selectedCalendarDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LifetimeResponseStateCopyWith<_$_LifetimeResponseState> get copyWith =>
      __$$_LifetimeResponseStateCopyWithImpl<_$_LifetimeResponseState>(
          this, _$identity);
}

abstract class _LifetimeResponseState implements LifetimeResponseState {
  const factory _LifetimeResponseState(
      {final Lifetime? lifetime,
      final DateTime? selectedCalendarDate}) = _$_LifetimeResponseState;

  @override
  Lifetime? get lifetime;
  @override
  DateTime? get selectedCalendarDate;
  @override
  @JsonKey(ignore: true)
  _$$_LifetimeResponseStateCopyWith<_$_LifetimeResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}
