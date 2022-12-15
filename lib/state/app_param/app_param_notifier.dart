import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_param_state.dart';

////////////////////////////////////////////////
final appParamProvider =
    StateNotifierProvider.autoDispose<AppParamNotifier, AppParamState>((ref) {
  return AppParamNotifier(
    const AppParamState(
      AmazonAlertSelectYear: 0,
      CreditCompanyAlertSelectYear: 0,
      CreditSummaryAlertSelectYear: 0,
      CreditYearlyDetailAlertSelectMonth: '',
      DutyAlertSelectYear: 0,
      HomeFixAlertSelectYear: 0,
      MoneyScoreGraphAlertGraphWidth: 0,
      MoneySpendGraphAlertGraphWidth: 0,
      SeiyuAlertSelectYear: 0,
      SeiyuAlertSelectDate: '',
      ShintakuAlertSelectShintaku: '',
      SpendSummaryAlertSelectYear: 0,
      SpendYearlyAlertSelectYear: 0,
      StockAlertSelectStock: '',
      TrainAlertSelectYear: 0,
    ),
  );
});

class AppParamNotifier extends StateNotifier<AppParamState> {
  AppParamNotifier(super.state);

  Future<void> setAmazonAlertSelectYear({required int year}) async =>
      state = state.copyWith(AmazonAlertSelectYear: year);

  Future<void> setCreditCompanyAlertSelectYear({required int year}) async =>
      state = state.copyWith(CreditCompanyAlertSelectYear: year);

  Future<void> setCreditSummaryAlertSelectYear({required int year}) async =>
      state = state.copyWith(CreditCompanyAlertSelectYear: year);
}

////////////////////////////////////////////////
