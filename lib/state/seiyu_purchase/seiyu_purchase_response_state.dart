// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/seiyu_item.dart';
import '../../models/seiyu_purchase.dart';

part 'seiyu_purchase_response_state.freezed.dart';

@freezed
class SeiyuPurchaseResponseState with _$SeiyuPurchaseResponseState {
  const factory SeiyuPurchaseResponseState({
    @Default(AsyncValue<List<SeiyuPurchase>>.loading()) AsyncValue<List<SeiyuPurchase>> seiyuPurchaseList,
    @Default(AsyncValue<List<SeiyuItem>>.loading()) AsyncValue<List<SeiyuItem>> seiyuItemList,
  }) = _SeiyuPurchaseResponseState;
}
