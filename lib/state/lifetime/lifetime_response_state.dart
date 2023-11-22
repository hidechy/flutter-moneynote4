// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/lifetime.dart';

part 'lifetime_response_state.freezed.dart';

@freezed
class LifetimeResponseState with _$LifetimeResponseState {
  const factory LifetimeResponseState({
    Lifetime? lifetime,

    // 2023.11.22 AsyncValueを使用してみた
    @Default(AsyncValue<List<Lifetime>>.loading()) AsyncValue<List<Lifetime>> lifetimeList,
    @Default(AsyncValue<Map<String, Lifetime>>.loading()) AsyncValue<Map<String, Lifetime>> lifetimeMap,
  }) = _LifetimeResponseState;
}
