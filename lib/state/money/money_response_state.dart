// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/money.dart';
import '../../models/money_everyday.dart';
import '../../models/money_score.dart';

part 'money_response_state.freezed.dart';

@freezed
class MoneyResponseState with _$MoneyResponseState {
  const factory MoneyResponseState({
    Money? money,
    @Default(AsyncValue<List<Money>>.loading()) AsyncValue<List<Money>> moneyList,
    @Default(AsyncValue<List<MoneyEveryday>>.loading()) AsyncValue<List<MoneyEveryday>> moneyEverydayList,
    @Default(AsyncValue<List<MoneyScore>>.loading()) AsyncValue<List<MoneyScore>> moneyScoreList,
  }) = _MoneyResponseState;
}
