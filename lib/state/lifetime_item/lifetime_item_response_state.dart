import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/lifetime_item.dart';

part 'lifetime_item_response_state.freezed.dart';

@freezed
class LifetimeItemResponseState with _$LifetimeItemResponseState {
  const factory LifetimeItemResponseState({
    ///
    @Default('') String selectedItem,
    @Default(0) int itemPos,

    ///
    @Default([]) List<String?> lifetimeStringList,

    //
    @Default(AsyncValue<List<LifetimeItem>>.loading()) AsyncValue<List<LifetimeItem>> lifetimeItemList,
    @Default(AsyncValue<List<String>>.loading()) AsyncValue<List<String>> lifetimeItemStringList,
  }) = _LifetimeItemResponseState;
}
