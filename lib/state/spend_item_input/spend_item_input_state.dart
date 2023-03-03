import 'package:freezed_annotation/freezed_annotation.dart';

part 'spend_item_input_state.freezed.dart';

@freezed
class SpendItemInputState with _$SpendItemInputState {
  const factory SpendItemInputState({
    @Default([]) List<String> spendItem,
    @Default([]) List<int> spendPrice,
    @Default(0) int itemPos,
    @Default('') String baseDiff,
    @Default(0) int diff,
    @Default([]) List<bool> minusCheck,
  }) = _SpendItemInputState;
}
