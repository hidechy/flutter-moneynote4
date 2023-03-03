import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_param_state.dart';

////////////////////////////////////////////////
final appParamProvider =
    StateNotifierProvider.autoDispose<AppParamNotifier, AppParamState>((ref) {
  return AppParamNotifier(const AppParamState());
});

class AppParamNotifier extends StateNotifier<AppParamState> {
  AppParamNotifier(super.state);

  Future<void> setAmazonAlertSelectYear({required int year}) async =>
      state = state.copyWith(AmazonAlertSelectYear: year);

  Future<void> setCreditCompanyAlertSelectYear({required int year}) async =>
      state = state.copyWith(CreditCompanyAlertSelectYear: year);

  Future<void> setCreditSummaryAlertSelectYear({required int year}) async =>
      state = state.copyWith(CreditSummaryAlertSelectYear: year);

  Future<void> setCreditYearlyDetailAlertSelectMonth(
          {required int month}) async =>
      state = state.copyWith(CreditYearlyDetailAlertSelectMonth: month);

  Future<void> setDutyAlertSelectYear({required int year}) async =>
      state = state.copyWith(DutyAlertSelectYear: year);

  Future<void> setHomeFixAlertSelectYear({required int year}) async =>
      state = state.copyWith(HomeFixAlertSelectYear: year);

  Future<void> setSeiyuAlertSelectYear({required int year}) async =>
      state = state.copyWith(SeiyuAlertSelectYear: year);

  Future<void> setSeiyuAlertSelectDate({required String date}) async =>
      state = state.copyWith(SeiyuAlertSelectDate: date);

  Future<void> setSpendSummaryAlertSelectYear({required int year}) async =>
      state = state.copyWith(SpendSummaryAlertSelectYear: year);

  Future<void> setSpendYearlyAlertSelectYear({required int year}) async =>
      state = state.copyWith(SpendYearlyAlertSelectYear: year);

  Future<void> setTrainAlertSelectYear({required int year}) async =>
      state = state.copyWith(TrainAlertSelectYear: year);

  Future<void> setUdemyAlertSelectYear({required int year}) async =>
      state = state.copyWith(UdemyAlertSelectYear: year);

  Future<void> setUdemyAlertSelectCategory({required String category}) async =>
      state = state.copyWith(UdemyAlertSelectCategory: category);

  Future<void> setBalanceSheetAlertSelectYear({required int year}) async =>
      state = state.copyWith(BalanceSheetAlertSelectYear: year);

  Future<void> setMonthlyUnitSpendAlertSelectYear({required int year}) async =>
      state = state.copyWith(MonthlyUnitSpendAlertSelectYear: year);

  Future<void> setSamedaySpendAlertDay({required int day}) async =>
      state = state.copyWith(SamedaySpendAlertDay: day);

  Future<void> setWellsReserveAlertYear({required int year}) async =>
      state = state.copyWith(WellsReserveAlertYear: year);
}

////////////////////////////////////////////////
