import 'package:freezed_annotation/freezed_annotation.dart';

part 'tax_payment_item_state.freezed.dart';

@freezed
class TaxPaymentItemState with _$TaxPaymentItemState {
  const factory TaxPaymentItemState({
    @Default([]) List<String> paymentItems,
    @Default([]) List<int> paymentPrices,
  }) = _TaxPaymentItemState;
}
