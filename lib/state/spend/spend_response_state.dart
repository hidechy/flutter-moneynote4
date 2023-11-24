// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/spend_month_summary.dart';
import '../../models/spend_summary.dart';
import '../../models/spend_yearly.dart';

part 'spend_response_state.freezed.dart';

@freezed
class SpendResponseState with _$SpendResponseState {
  const factory SpendResponseState({
    @Default(AsyncValue<List<SpendSummary>>.loading()) AsyncValue<List<SpendSummary>> spendSummaryList,
    @Default(AsyncValue<List<SpendMonthSummary>>.loading()) AsyncValue<List<SpendMonthSummary>> spendMonthSummaryList,

    //List<SpendYearly>

    @Default(AsyncValue<List<SpendYearly>>.loading()) AsyncValue<List<SpendYearly>> spendYearlyList,
  }) = _SpendResponseState;
}
