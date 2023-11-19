import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/lifetime_item.dart';

part 'lifetime_item_response_state.freezed.dart';

@freezed
class LifetimeItemResponseState with _$LifetimeItemResponseState {
  const factory LifetimeItemResponseState({
    @Default([]) List<LifetimeItem> lifetimeItemList,
    @Default([]) List<String> lifetimeItemStringList,
    @Default('') String selectedItem,
    @Default(0) int itemPos,
    @Default([]) List<String> lifetimeStringList,
  }) = _LifetimeItemResponseState;
}
