// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/spend_item_daily.dart';
import '../../models/spend_month_summary.dart';
import '../../models/spend_sameday.dart';
import '../../models/spend_sameday_yearly.dart';
import '../../models/spend_summary.dart';
import '../../models/spend_year_summary.dart';
import '../../models/spend_yearly.dart';

part 'spend_response_state.freezed.dart';

@freezed
class SpendResponseState with _$SpendResponseState {
  const factory SpendResponseState({
    @Default(AsyncValue<SpendItemDaily>.loading()) AsyncValue<SpendItemDaily> spendItemDaily,
    @Default(AsyncValue<List<SpendSummary>>.loading()) AsyncValue<List<SpendSummary>> spendSummaryList,
    @Default(AsyncValue<List<SpendMonthSummary>>.loading()) AsyncValue<List<SpendMonthSummary>> spendMonthSummaryList,
    @Default(AsyncValue<List<SpendYearly>>.loading()) AsyncValue<List<SpendYearly>> spendYearlyList,
    @Default(AsyncValue<List<SpendYearSummary>>.loading()) AsyncValue<List<SpendYearSummary>> spendYearSummaryList,
    @Default(AsyncValue<List<SpendSameday>>.loading()) AsyncValue<List<SpendSameday>> spendSamedayList,
    @Default(AsyncValue<List<SpendSamedayYearly>>.loading())
    AsyncValue<List<SpendSamedayYearly>> spendSamedayYearlyList,

    //
    @Default(AsyncValue<Map<String, int>>.loading()) AsyncValue<Map<String, int>> spendMonthUnitMap,
  }) = _SpendResponseState;
}
