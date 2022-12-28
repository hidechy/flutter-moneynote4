import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/spend_summary.dart';

part 'spend_summary_state.freezed.dart';

@freezed
class SpendSummaryState with _$SpendSummaryState {
  const factory SpendSummaryState({
    @Default([]) List<SpendSummary> list,
    @Default(false) bool saving,
  }) = _SpendSummaryState;
}
