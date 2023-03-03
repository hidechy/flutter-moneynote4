import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_input_state.freezed.dart';

@freezed
class BankInputState with _$BankInputState {
  const factory BankInputState({
    @Default('') String bankMoney,
    //
    @Default('') String selectBank,
    @Default('') String selectDate,
    //
    @Default(0) int selectInOutFlag,
    //
    @Default('') String outArrowBank,
    @Default('') String outArrowDate,
    @Default('') String inArrowBank,
    @Default('') String inArrowDate,
  }) = _BankInputState;
}
