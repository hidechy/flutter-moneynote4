import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/assets_data.dart';

import '../../models/gold.dart';

part 'gold_response_state.freezed.dart';

@freezed
class GoldResponseState with _$GoldResponseState {
  const factory GoldResponseState({
    Gold? lastGold,
    @Default({}) Map<String, AssetsData> goldMap,

    //

    @Default(AsyncValue<List<Gold>>.loading()) AsyncValue<List<Gold>> goldList,
  }) = _GoldResponseState;
}
