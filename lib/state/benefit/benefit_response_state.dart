import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/benefit.dart';

part 'benefit_response_state.freezed.dart';

@freezed
class BenefitResponseState with _$BenefitResponseState {
  const factory BenefitResponseState({
    @Default([]) List<Benefit> benefitList,
    @Default({}) Map<String, Benefit> benefitMap,
  }) = _BenefitResponseState;
}
