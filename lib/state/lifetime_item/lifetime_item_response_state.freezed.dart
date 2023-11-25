// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lifetime_item_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LifetimeItemResponseState {
  ///
  String get selectedItem => throw _privateConstructorUsedError;
  int get itemPos => throw _privateConstructorUsedError;

  ///
  List<String?> get lifetimeStringList => throw _privateConstructorUsedError; //
  AsyncValue<List<LifetimeItem>> get lifetimeItemList =>
      throw _privateConstructorUsedError;
  AsyncValue<List<String>> get lifetimeItemStringList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LifetimeItemResponseStateCopyWith<LifetimeItemResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LifetimeItemResponseStateCopyWith<$Res> {
  factory $LifetimeItemResponseStateCopyWith(LifetimeItemResponseState value,
          $Res Function(LifetimeItemResponseState) then) =
      _$LifetimeItemResponseStateCopyWithImpl<$Res, LifetimeItemResponseState>;
  @useResult
  $Res call(
      {String selectedItem,
      int itemPos,
      List<String?> lifetimeStringList,
      AsyncValue<List<LifetimeItem>> lifetimeItemList,
      AsyncValue<List<String>> lifetimeItemStringList});
}

/// @nodoc
class _$LifetimeItemResponseStateCopyWithImpl<$Res,
        $Val extends LifetimeItemResponseState>
    implements $LifetimeItemResponseStateCopyWith<$Res> {
  _$LifetimeItemResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedItem = null,
    Object? itemPos = null,
    Object? lifetimeStringList = null,
    Object? lifetimeItemList = null,
    Object? lifetimeItemStringList = null,
  }) {
    return _then(_value.copyWith(
      selectedItem: null == selectedItem
          ? _value.selectedItem
          : selectedItem // ignore: cast_nullable_to_non_nullable
              as String,
      itemPos: null == itemPos
          ? _value.itemPos
          : itemPos // ignore: cast_nullable_to_non_nullable
              as int,
      lifetimeStringList: null == lifetimeStringList
          ? _value.lifetimeStringList
          : lifetimeStringList // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      lifetimeItemList: null == lifetimeItemList
          ? _value.lifetimeItemList
          : lifetimeItemList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<LifetimeItem>>,
      lifetimeItemStringList: null == lifetimeItemStringList
          ? _value.lifetimeItemStringList
          : lifetimeItemStringList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LifetimeItemResponseStateImplCopyWith<$Res>
    implements $LifetimeItemResponseStateCopyWith<$Res> {
  factory _$$LifetimeItemResponseStateImplCopyWith(
          _$LifetimeItemResponseStateImpl value,
          $Res Function(_$LifetimeItemResponseStateImpl) then) =
      __$$LifetimeItemResponseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String selectedItem,
      int itemPos,
      List<String?> lifetimeStringList,
      AsyncValue<List<LifetimeItem>> lifetimeItemList,
      AsyncValue<List<String>> lifetimeItemStringList});
}

/// @nodoc
class __$$LifetimeItemResponseStateImplCopyWithImpl<$Res>
    extends _$LifetimeItemResponseStateCopyWithImpl<$Res,
        _$LifetimeItemResponseStateImpl>
    implements _$$LifetimeItemResponseStateImplCopyWith<$Res> {
  __$$LifetimeItemResponseStateImplCopyWithImpl(
      _$LifetimeItemResponseStateImpl _value,
      $Res Function(_$LifetimeItemResponseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedItem = null,
    Object? itemPos = null,
    Object? lifetimeStringList = null,
    Object? lifetimeItemList = null,
    Object? lifetimeItemStringList = null,
  }) {
    return _then(_$LifetimeItemResponseStateImpl(
      selectedItem: null == selectedItem
          ? _value.selectedItem
          : selectedItem // ignore: cast_nullable_to_non_nullable
              as String,
      itemPos: null == itemPos
          ? _value.itemPos
          : itemPos // ignore: cast_nullable_to_non_nullable
              as int,
      lifetimeStringList: null == lifetimeStringList
          ? _value._lifetimeStringList
          : lifetimeStringList // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      lifetimeItemList: null == lifetimeItemList
          ? _value.lifetimeItemList
          : lifetimeItemList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<LifetimeItem>>,
      lifetimeItemStringList: null == lifetimeItemStringList
          ? _value.lifetimeItemStringList
          : lifetimeItemStringList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<String>>,
    ));
  }
}

/// @nodoc

class _$LifetimeItemResponseStateImpl implements _LifetimeItemResponseState {
  const _$LifetimeItemResponseStateImpl(
      {this.selectedItem = '',
      this.itemPos = 0,
      final List<String?> lifetimeStringList = const [],
      this.lifetimeItemList = const AsyncValue<List<LifetimeItem>>.loading(),
      this.lifetimeItemStringList = const AsyncValue<List<String>>.loading()})
      : _lifetimeStringList = lifetimeStringList;

  ///
  @override
  @JsonKey()
  final String selectedItem;
  @override
  @JsonKey()
  final int itemPos;

  ///
  final List<String?> _lifetimeStringList;

  ///
  @override
  @JsonKey()
  List<String?> get lifetimeStringList {
    if (_lifetimeStringList is EqualUnmodifiableListView)
      return _lifetimeStringList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lifetimeStringList);
  }

//
  @override
  @JsonKey()
  final AsyncValue<List<LifetimeItem>> lifetimeItemList;
  @override
  @JsonKey()
  final AsyncValue<List<String>> lifetimeItemStringList;

  @override
  String toString() {
    return 'LifetimeItemResponseState(selectedItem: $selectedItem, itemPos: $itemPos, lifetimeStringList: $lifetimeStringList, lifetimeItemList: $lifetimeItemList, lifetimeItemStringList: $lifetimeItemStringList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LifetimeItemResponseStateImpl &&
            (identical(other.selectedItem, selectedItem) ||
                other.selectedItem == selectedItem) &&
            (identical(other.itemPos, itemPos) || other.itemPos == itemPos) &&
            const DeepCollectionEquality()
                .equals(other._lifetimeStringList, _lifetimeStringList) &&
            (identical(other.lifetimeItemList, lifetimeItemList) ||
                other.lifetimeItemList == lifetimeItemList) &&
            (identical(other.lifetimeItemStringList, lifetimeItemStringList) ||
                other.lifetimeItemStringList == lifetimeItemStringList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedItem,
      itemPos,
      const DeepCollectionEquality().hash(_lifetimeStringList),
      lifetimeItemList,
      lifetimeItemStringList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LifetimeItemResponseStateImplCopyWith<_$LifetimeItemResponseStateImpl>
      get copyWith => __$$LifetimeItemResponseStateImplCopyWithImpl<
          _$LifetimeItemResponseStateImpl>(this, _$identity);
}

abstract class _LifetimeItemResponseState implements LifetimeItemResponseState {
  const factory _LifetimeItemResponseState(
          {final String selectedItem,
          final int itemPos,
          final List<String?> lifetimeStringList,
          final AsyncValue<List<LifetimeItem>> lifetimeItemList,
          final AsyncValue<List<String>> lifetimeItemStringList}) =
      _$LifetimeItemResponseStateImpl;

  @override

  ///
  String get selectedItem;
  @override
  int get itemPos;
  @override

  ///
  List<String?> get lifetimeStringList;
  @override //
  AsyncValue<List<LifetimeItem>> get lifetimeItemList;
  @override
  AsyncValue<List<String>> get lifetimeItemStringList;
  @override
  @JsonKey(ignore: true)
  _$$LifetimeItemResponseStateImplCopyWith<_$LifetimeItemResponseStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
