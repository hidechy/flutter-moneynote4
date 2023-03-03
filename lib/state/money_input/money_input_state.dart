import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_input_state.freezed.dart';

part 'money_input_state.g.dart';

@freezed
class MoneyInputState with _$MoneyInputState {
  const factory MoneyInputState({
    @Default('') String date,
    //
    @Default('') String yen10000,
    @Default('') String yen5000,
    @Default('') String yen2000,
    @Default('') String yen1000,
    @Default('') String yen500,
    @Default('') String yen100,
    @Default('') String yen50,
    @Default('') String yen10,
    @Default('') String yen5,
    @Default('') String yen1,
    //
    @Default('') String bankA,
    @Default('') String bankB,
    @Default('') String bankC,
    @Default('') String bankD,
    @Default('') String bankE,
    //
    @Default('') String payA,
    @Default('') String payB,
    @Default('') String payC,
    @Default('') String payD,
    @Default('') String payE,
  }) = _MoneyInputState;

  factory MoneyInputState.fromJson(Map<String, dynamic> json) =>
      _$MoneyInputStateFromJson(json);
}
