import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/lifetime.dart';

part 'lifetime_response_state.freezed.dart';

@freezed
class LifetimeResponseState with _$LifetimeResponseState {
  const factory LifetimeResponseState({
    Lifetime? lifetime,
    @Default([]) List<Lifetime> lifetimeList,
  }) = _LifetimeResponseState;
}
