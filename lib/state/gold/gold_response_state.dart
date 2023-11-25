import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/assets_data.dart';
import '../../models/gold.dart';

part 'gold_response_state.freezed.dart';

@freezed
class GoldResponseState with _$GoldResponseState {
  const factory GoldResponseState({
    Gold? lastGold,
    @Default(AsyncValue<List<Gold>>.loading()) AsyncValue<List<Gold>> goldList,
    @Default(AsyncValue<Map<String, AssetsData>>.loading()) AsyncValue<Map<String, AssetsData>> goldMap,
  }) = _GoldResponseState;
}
