import 'package:freezed_annotation/freezed_annotation.dart';

part 'monthly_spend_check_state.freezed.dart';

@freezed
class MonthlySpendCheckState with _$MonthlySpendCheckState {
  const factory MonthlySpendCheckState({
    @Default([]) List<String> selectItem,
  }) = _MonthlySpendCheckState;
}
