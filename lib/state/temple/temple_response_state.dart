import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/temple.dart';

part 'temple_response_state.freezed.dart';

@freezed
class TempleResponseState with _$TempleResponseState {
  const factory TempleResponseState({
    @Default([]) List<Temple> templeList,
    @Default({}) Map<String, Temple> templeMap,
  }) = _TempleResponseState;
}
