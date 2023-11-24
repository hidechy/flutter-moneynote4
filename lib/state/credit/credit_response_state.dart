// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/credit_company.dart';
import '../../models/credit_spend_all.dart';
import '../../models/credit_spend_monthly.dart';
import '../../models/credit_spend_yearly_detail.dart';
import '../../models/credit_summary.dart';

part 'credit_response_state.freezed.dart';

@freezed
class CreditResponseState with _$CreditResponseState {
  const factory CreditResponseState({
    @Default('') String selectCredit,
    @Default(AsyncValue<List<CreditSummary>>.loading()) AsyncValue<List<CreditSummary>> creditSummaryList,
    @Default(AsyncValue<List<CreditSpendMonthly>>.loading())
    AsyncValue<List<CreditSpendMonthly>> creditSpendMonthlyList,
    @Default(AsyncValue<List<CreditCompany>>.loading()) AsyncValue<List<CreditCompany>> creditCompanyList,
    @Default(AsyncValue<List<CreditSpendAll>>.loading()) AsyncValue<List<CreditSpendAll>> creditSpendAllList,
    @Default(AsyncValue<List<CreditSpendYearlyDetail>>.loading())
    AsyncValue<List<CreditSpendYearlyDetail>> creditSpendYearlyDetailList,
  }) = _CreditResponseState;
}
