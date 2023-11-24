// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/amazon_purchase.dart';
import '../../utility/utility.dart';
import 'amazon_purchase_response_state.dart';

/*
amazonPurchaseProvider        AmazonPurchaseResponseState
*/

////////////////////////////////////////////////

final amazonPurchaseProvider = StateNotifierProvider.autoDispose
    .family<AmazonPurchaseNotifier, AmazonPurchaseResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return AmazonPurchaseNotifier(const AmazonPurchaseResponseState(), client, utility)
    ..getAmazonPurchaseList(date: date);
});

class AmazonPurchaseNotifier extends StateNotifier<AmazonPurchaseResponseState> {
  AmazonPurchaseNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getAmazonPurchaseList({required DateTime date}) async {
    await client.post(path: APIPath.amazonPurchase, body: {'date': date.yyyymmdd}).then((value) {
      final list = <AmazonPurchase>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyy ==
            DateTime(
              value['data'][i]['date'].toString().split('-')[0].toInt(),
              value['data'][i]['date'].toString().split('-')[1].toInt(),
              value['data'][i]['date'].toString().split('-')[2].toInt(),
            ).yyyy) {
          list.add(
            AmazonPurchase.fromJson(value['data'][i] as Map<String, dynamic>),
          );
        }
      }

      state = state.copyWith(amazonPurchaseList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
