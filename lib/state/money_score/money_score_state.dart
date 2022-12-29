import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/money_score.dart';

part 'money_score_state.freezed.dart';

@freezed
class MoneyScoreState with _$MoneyScoreState {
  const factory MoneyScoreState({
    @Default([]) List<MoneyScore> list,
    @Default(false) bool saving,
  }) = _MoneyScoreState;
}
