// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/keihi.dart';
import '../../models/tax_payment_item.dart';

part 'keihi_list_response_state.freezed.dart';

@freezed
class KeihiListResponseState with _$KeihiListResponseState {
  const factory KeihiListResponseState({
    TaxPaymentItem? taxPaymentItem,
    @Default(AsyncValue<List<Keihi>>.loading()) AsyncValue<List<Keihi>> keihiList,
  }) = _KeihiListResponseState;
}
