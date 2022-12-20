import 'package:freezed_annotation/freezed_annotation.dart';

part 'spend_yearly_item_state.freezed.dart';

@freezed
class SpendYearlyItemState with _$SpendYearlyItemState {
  const factory SpendYearlyItemState({
    required DateTime date,
    required String item,
    int? price,
  }) = _SpendYearlyItemState;
}
