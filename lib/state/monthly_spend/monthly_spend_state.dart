import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/spend_yearly.dart';

part 'monthly_spend_state.freezed.dart';

@freezed
class MonthlySpendState with _$MonthlySpendState {
  const factory MonthlySpendState({
    @Default([]) List<SpendYearly> list,
    @Default(false) bool saving,
  }) = _MonthlySpendState;
}
