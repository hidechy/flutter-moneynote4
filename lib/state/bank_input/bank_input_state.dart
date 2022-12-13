import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_input_state.freezed.dart';

@freezed
class BankInputState with _$BankInputState {
  const factory BankInputState({
    required String bankMoney,
    //
    required String selectBank,
    required String selectDate,
    //
    required int selectInOutFlag,
    //
    required String outArrowBank,
    required String outArrowDate,
    required String inArrowBank,
    required String inArrowDate,
  }) = _BankInputState;
}
