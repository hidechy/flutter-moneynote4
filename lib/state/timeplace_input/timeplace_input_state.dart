import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeplace_input_state.freezed.dart';

@freezed
class TimeplaceInputState with _$TimeplaceInputState {
  const factory TimeplaceInputState({
    required List<String> time,
    required List<String> place,
    required List<int> spendPrice,
    required int itemPos,
    required String baseDiff,
    required int diff,
    required List<bool> minusCheck,
  }) = _TimeplaceInputState;
}
