import 'package:freezed_annotation/freezed_annotation.dart';

part 'seiyu_purchase_request_state.freezed.dart';

@freezed
class SeiyuPurchaseRequestState with _$SeiyuPurchaseRequestState {
  const factory SeiyuPurchaseRequestState({
    DateTime? date,
    @Default('') String item,
  }) = _SeiyuPurchaseRequestState;
}
