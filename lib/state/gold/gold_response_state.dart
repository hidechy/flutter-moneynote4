import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moneynote4/models/assets_data.dart';

import '../../models/gold.dart';

part 'gold_response_state.freezed.dart';

@freezed
class GoldResponseState with _$GoldResponseState {
  const factory GoldResponseState({
    Gold? lastGold,
    @Default([]) List<Gold> goldList,
    @Default({}) Map<String, AssetsData> goldMap,
  }) = _GoldResponseState;
}
