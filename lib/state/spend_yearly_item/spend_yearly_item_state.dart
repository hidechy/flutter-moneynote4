import 'package:freezed_annotation/freezed_annotation.dart';

part 'spend_yearly_item_state.freezed.dart';

@freezed
class SpendYearlyItemState with _$SpendYearlyItemState {
  const factory SpendYearlyItemState({
    DateTime? date,
    @Default('') String item,
    int? price,
  }) = _SpendYearlyItemState;
}
