// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_param_state.freezed.dart';

@freezed
class AppParamState with _$AppParamState {
  const factory AppParamState({
    @Default(0) int AmazonAlertSelectYear,
    @Default(0) int CreditCompanyAlertSelectYear,
    @Default(0) int CreditSummaryAlertSelectYear,
    @Default(0) int CreditYearlyDetailAlertSelectMonth,
    @Default(0) int DutyAlertSelectYear,
    @Default(0) int HomeFixAlertSelectYear,
    @Default(0) int SeiyuAlertSelectYear,
    @Default('') String SeiyuAlertSelectDate,
    @Default(0) int SpendSummaryAlertSelectYear,
    @Default(0) int SpendYearlyAlertSelectYear,
    @Default(0) int TrainAlertSelectYear,
    @Default(0) int UdemyAlertSelectYear,
    @Default('') String UdemyAlertSelectCategory,
    @Default(0) int BalanceSheetAlertSelectYear,
    @Default(0) int MonthlyUnitSpendAlertSelectYear,
    @Default(0) int SamedaySpendAlertDay,
    @Default(0) int WellsReserveAlertYear,
    @Default(0) int KeihiListAlertSelectYear,
    @Default('') String KeihiListAlertSelectOrder,
  }) = _AppParamState;
}
