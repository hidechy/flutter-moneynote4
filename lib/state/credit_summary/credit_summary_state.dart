import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/credit_summary.dart';

part 'credit_summary_state.freezed.dart';

@freezed
class CreditSummaryState with _$CreditSummaryState {
  const factory CreditSummaryState({
    @Default([]) List<CreditSummary> list,
    @Default(false) bool saving,
  }) = _CreditSummaryState;
}
