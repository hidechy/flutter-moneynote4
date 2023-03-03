import 'package:freezed_annotation/freezed_annotation.dart';

part 'monthly_spend_check_state.freezed.dart';

@freezed
class MonthlySpendCheckState with _$MonthlySpendCheckState {
  const factory MonthlySpendCheckState({
    @Default([]) List<String> selectItems,
    @Default([]) List<Map<String, dynamic>> checkItems,
    @Default(0) int monthTotal,
    @Default('') selectedCategory,
    @Default('') errorMsg,
  }) = _MonthlySpendCheckState;
}
