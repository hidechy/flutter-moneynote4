import 'package:freezed_annotation/freezed_annotation.dart';

part 'spend_item_input_state.freezed.dart';

@freezed
class SpendItemInputState with _$SpendItemInputState {
  const factory SpendItemInputState({
    required int itemPos,
    required List<String> spendItem,
    required List<String> spendPrice,
  }) = _SpendItemInputState;
}
