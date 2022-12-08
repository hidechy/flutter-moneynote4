import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_input_state.freezed.dart';

@freezed
class MoneyInputState with _$MoneyInputState {
  const factory MoneyInputState({
    required String date,
    //
    required String yen10000,
    required String yen5000,
    required String yen2000,
    required String yen1000,
    required String yen500,
    required String yen100,
    required String yen50,
    required String yen10,
    required String yen5,
    required String yen1,
    //
    required String bankA,
    required String bankB,
    required String bankC,
    required String bankD,
    required String bankE,
    //
    required String payA,
    required String payB,
    required String payC,
    required String payD,
    required String payE,
  }) = _MoneyInputState;
}
