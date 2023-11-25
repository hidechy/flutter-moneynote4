import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/benefit.dart';

part 'benefit_response_state.freezed.dart';

@freezed
class BenefitResponseState with _$BenefitResponseState {
  const factory BenefitResponseState({
    @Default(AsyncValue<List<Benefit>>.loading()) AsyncValue<List<Benefit>> benefitList,
    @Default(AsyncValue<Map<String, Benefit>>.loading()) AsyncValue<Map<String, Benefit>> benefitMap,
  }) = _BenefitResponseState;
}
