import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';

import 'app_param_state.dart';

////////////////////////////////////////////////
final appParamProvider =
    StateNotifierProvider.autoDispose<AppParamNotifier, AppParamState>((ref) {
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
      SeiyuAlertSelectDate: '',
      SpendSummaryAlertSelectYear: year.toInt(),
      SpendYearlyAlertSelectYear: year.toInt(),
      TrainAlertSelectYear: year.toInt(),
      UdemyAlertSelectYear: year.toInt(),
      UdemyAlertSelectCategory: '',
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
}

////////////////////////////////////////////////
