// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/bank_company_all.dart';
import '../../models/bank_company_change.dart';
import '../../models/bank_monthly_spend.dart';
import '../../models/bank_move.dart';

part 'bank_response_state.freezed.dart';

@freezed
class BankResponseState with _$BankResponseState {
  const factory BankResponseState({
    BankCompanyChange? bankCompanyChange,
    @Default(AsyncValue<List<BankCompanyAll>>.loading()) AsyncValue<List<BankCompanyAll>> bankCompanyList,
    @Default(AsyncValue<List<BankMove>>.loading()) AsyncValue<List<BankMove>> bankMoveList,
    @Default(AsyncValue<List<BankMonthlySpend>>.loading()) AsyncValue<List<BankMonthlySpend>> bankMonthlySpendList,
  }) = _BankResponseState;
}
