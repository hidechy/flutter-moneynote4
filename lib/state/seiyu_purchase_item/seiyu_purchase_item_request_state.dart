import 'package:freezed_annotation/freezed_annotation.dart';

part 'seiyu_purchase_item_request_state.freezed.dart';

@freezed
class SeiyuPurchaseItemRequestState with _$SeiyuPurchaseItemRequestState {
  const factory SeiyuPurchaseItemRequestState({
    required DateTime date,
    @Default('') String item,
  }) = _SeiyuPurchaseItemRequestState;
}
