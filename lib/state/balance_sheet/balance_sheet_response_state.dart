// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/balancesheet.dart';

part 'balance_sheet_response_state.freezed.dart';

@freezed
class BalanceSheetResponseState with _$BalanceSheetResponseState {
  const factory BalanceSheetResponseState({
    @Default(AsyncValue<List<Balancesheet>>.loading()) AsyncValue<List<Balancesheet>> balanceSheetList,
  }) = _BalanceSheetResponseState;
}
