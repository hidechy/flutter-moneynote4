import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/temple.dart';

part 'temple_response_state.freezed.dart';

@freezed
class TempleResponseState with _$TempleResponseState {
  const factory TempleResponseState({
    @Default({}) Map<String, Temple> templeMap,

    //
    @Default(AsyncValue<List<Temple>>.loading()) AsyncValue<List<Temple>> templeList,
  }) = _TempleResponseState;
}
