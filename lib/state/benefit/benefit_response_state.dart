import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/benefit.dart';

part 'benefit_response_state.freezed.dart';

@freezed
class BenefitResponseState with _$BenefitResponseState {
  const factory BenefitResponseState({
    @Default({}) Map<String, Benefit> benefitMap,

    //

    @Default(AsyncValue<List<Benefit>>.loading()) AsyncValue<List<Benefit>> benefitList,
  }) = _BenefitResponseState;
}
