import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import 'app_param_state.dart';

////////////////////////////////////////////////
final appParamProvider = StateNotifierProvider.autoDispose<AppParamNotifier, AppParamState>((ref) {
  final year = DateTime.now().yyyy;

  return AppParamNotifier(
    AppParamState(
      AmazonAlertSelectYear: year.toInt(),
      CreditCompanyAlertSelectYear: year.toInt(),
      CreditSummaryAlertSelectYear: year.toInt(),
      CreditYearlyDetailAlertSelectMonth: 1,
      DutyAlertSelectYear: year.toInt(),
      HomeFixAlertSelectYear: year.toInt(),
      SeiyuAlertSelectYear: year.toInt(),
      SpendSummaryAlertSelectYear: year.toInt(),
      SpendYearlyAlertSelectYear: year.toInt(),
      TrainAlertSelectYear: year.toInt(),
      UdemyAlertSelectYear: year.toInt(),
      BalanceSheetAlertSelectYear: year.toInt(),
      MonthlyUnitSpendAlertSelectYear: year.toInt(),
      SamedaySpendAlertDay: DateTime.now().dd.toInt(),
      WellsReserveAlertYear: year.toInt(),
      KeihiListAlertSelectYear: year.toInt(),
      TaxPaymentAlertSelectYear: year.toInt(),
      TaxPaymentItemAlertSelectYear: year.toInt(),
    ),
  );
});

class AppParamNotifier extends StateNotifier<AppParamState> {
  AppParamNotifier(super.state);

  Future<void> setErrorMessage({required String msg}) async => state = state.copyWith(errorMessage: msg);

  Future<void> setAmazonAlertSelectYear({required int year}) async =>
      state = state.copyWith(AmazonAlertSelectYear: year);

  Future<void> setCreditCompanyAlertSelectYear({required int year}) async =>
      state = state.copyWith(CreditCompanyAlertSelectYear: year);

  Future<void> setCreditSummaryAlertSelectYear({required int year}) async =>
      state = state.copyWith(CreditSummaryAlertSelectYear: year);

  Future<void> setCreditYearlyDetailAlertSelectMonth({required int month}) async =>
      state = state.copyWith(CreditYearlyDetailAlertSelectMonth: month);

  Future<void> setDutyAlertSelectYear({required int year}) async => state = state.copyWith(DutyAlertSelectYear: year);

  Future<void> setHomeFixAlertSelectYear({required int year}) async =>
      state = state.copyWith(HomeFixAlertSelectYear: year);

  Future<void> setSeiyuAlertSelectYear({required int year}) async => state = state.copyWith(SeiyuAlertSelectYear: year);

  Future<void> setSeiyuAlertSelectDate({required String date}) async =>
      state = state.copyWith(SeiyuAlertSelectDate: date);

  Future<void> setSpendSummaryAlertSelectYear({required int year}) async =>
      state = state.copyWith(SpendSummaryAlertSelectYear: year);

  Future<void> setSpendYearlyAlertSelectYear({required int year}) async =>
      state = state.copyWith(SpendYearlyAlertSelectYear: year);

  Future<void> setTrainAlertSelectYear({required int year}) async => state = state.copyWith(TrainAlertSelectYear: year);

  Future<void> setUdemyAlertSelectYear({required int year}) async => state = state.copyWith(UdemyAlertSelectYear: year);

  Future<void> setUdemyAlertSelectCategory({required String category}) async =>
      state = state.copyWith(UdemyAlertSelectCategory: category);

  Future<void> setBalanceSheetAlertSelectYear({required int year}) async =>
      state = state.copyWith(BalanceSheetAlertSelectYear: year);

  Future<void> setMonthlyUnitSpendAlertSelectYear({required int year}) async =>
      state = state.copyWith(MonthlyUnitSpendAlertSelectYear: year);

  Future<void> setSamedaySpendAlertDay({required int day}) async => state = state.copyWith(SamedaySpendAlertDay: day);

  Future<void> setWellsReserveAlertYear({required int year}) async =>
      state = state.copyWith(WellsReserveAlertYear: year);

  Future<void> setKeihiListAlertSelectYear({required int year}) async =>
      state = state.copyWith(KeihiListAlertSelectYear: year);

  Future<void> setKeihiListAlertSelectOrder({required String order}) async =>
      state = state.copyWith(KeihiListAlertSelectOrder: order);

  Future<void> setTaxPaymentAlertSelectYear({required int year}) async =>
      state = state.copyWith(TaxPaymentAlertSelectYear: year);

  Future<void> setTaxPaymentItemAlertSelectYear({required int year}) async =>
      state = state.copyWith(TaxPaymentItemAlertSelectYear: year);

  Future<void> setOpenMoneyArea({required bool value}) async => state = state.copyWith(openMoneyArea: value);

  Future<void> setCreditYearlyListSelectString({required String value}) async =>
      state = state.copyWith(CreditYearlyListSelectString: value);

  Future<void> setCreditYearlyListSelectedString({required String value}) async =>
      state = state.copyWith(CreditYearlyListSelectedString: value);

  Future<void> setSelectedYearlyCalendarDate({required DateTime date}) async =>
      state = state.copyWith(selectedYearlyCalendarDate: date);
}

////////////////////////////////////////////////
