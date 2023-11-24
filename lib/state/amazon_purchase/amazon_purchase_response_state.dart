// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/amazon_purchase.dart';

part 'amazon_purchase_response_state.freezed.dart';

@freezed
class AmazonPurchaseResponseState with _$AmazonPurchaseResponseState {
  const factory AmazonPurchaseResponseState({
    @Default(AsyncValue<List<AmazonPurchase>>.loading()) AsyncValue<List<AmazonPurchase>> amazonPurchaseList,
  }) = _AmazonPurchaseResponseState;
}
