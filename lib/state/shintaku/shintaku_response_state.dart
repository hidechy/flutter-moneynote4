import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/assets_data.dart';
import '../../models/shintaku.dart';
import '../../models/shintaku_record.dart';

part 'shintaku_response_state.freezed.dart';

@freezed
class ShintakuResponseState with _$ShintakuResponseState {
  const factory ShintakuResponseState({
    Shintaku? lastShintaku,
    ShintakuRecord? lastShintakuRecord,
    @Default({}) Map<String, AssetsData> shintakuMap,
  }) = _ShintakuResponseState;
}
