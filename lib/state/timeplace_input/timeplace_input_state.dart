import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeplace_input_state.freezed.dart';

@freezed
class TimeplaceInputState with _$TimeplaceInputState {
  const factory TimeplaceInputState({
    @Default([]) List<String> time,
    @Default([]) List<String> place,
    @Default([]) List<int> spendPrice,
    @Default(0) int itemPos,
    @Default('') String baseDiff,
    @Default(0) int diff,
    @Default([]) List<bool> minusCheck,
  }) = _TimeplaceInputState;
}
