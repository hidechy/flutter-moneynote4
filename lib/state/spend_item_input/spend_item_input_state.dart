import 'package:freezed_annotation/freezed_annotation.dart';

part 'spend_item_input_state.freezed.dart';

@freezed
class SpendItemInputState with _$SpendItemInputState {
  const factory SpendItemInputState({
    required List<String> spendItem,
    required List<int> spendPrice,
    required int itemPos,
    required String baseDiff,
    required int diff,
    required List<bool> minusCheck,
  }) = _SpendItemInputState;
}
