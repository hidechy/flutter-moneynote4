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
      DutyAlertSelectYear: year.toInt(),
      HomeFixAlertSelectYear: year.toInt(),
      SpendSummaryAlertSelectYear: year.toInt(),
      SpendYearlyAlertSelectYear: year.toInt(),
      TrainAlertSelectYear: year.toInt(),
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

  Future<void> setDutyAlertSelectYear({required int year}) async =>
      state = state.copyWith(DutyAlertSelectYear: year);

  Future<void> setHomeFixAlertSelectYear({required int year}) async =>
      state = state.copyWith(HomeFixAlertSelectYear: year);

  Future<void> setSpendSummaryAlertSelectYear({required int year}) async =>
      state = state.copyWith(SpendSummaryAlertSelectYear: year);

  Future<void> setSpendYearlyAlertSelectYear({required int year}) async =>
      state = state.copyWith(SpendYearlyAlertSelectYear: year);

  Future<void> setTrainAlertSelectYear({required int year}) async =>
      state = state.copyWith(TrainAlertSelectYear: year);
}

////////////////////////////////////////////////
