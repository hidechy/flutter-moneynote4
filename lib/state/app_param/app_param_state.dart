// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_param_state.freezed.dart';

@freezed
class AppParamState with _$AppParamState {
  const factory AppParamState({
    required int AmazonAlertSelectYear,
    required int CreditCompanyAlertSelectYear,
    required int CreditSummaryAlertSelectYear,
    required int DutyAlertSelectYear,
    required int HomeFixAlertSelectYear,
    required int SpendSummaryAlertSelectYear,
    required int SpendYearlyAlertSelectYear,
    required int TrainAlertSelectYear,
  }) = _AppParamState;
}
