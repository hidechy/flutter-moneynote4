// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../extensions/extensions.dart';
import '../models/amazon_purchase.dart';

////////////////////////////////////////////////

final amazonPurchaseProvider = StateNotifierProvider.autoDispose
    .family<AmazonPurchaseNotifier, List<AmazonPurchase>, DateTime>(
        (ref, date) {
  final client = ref.read(httpClientProvider);

  return AmazonPurchaseNotifier([], client)..getAmazonPurchaseList(date: date);
});

class AmazonPurchaseNotifier extends StateNotifier<List<AmazonPurchase>> {
  AmazonPurchaseNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getAmazonPurchaseList({required DateTime date}) async {
    await client.post(
      path: 'amazonPurchaseList',
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <AmazonPurchase>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyy ==
            '${value['data'][i]['date']} 00:00:00'.toDateTime().yyyy) {
          list.add(
            AmazonPurchase(
              date: value['data'][i]['date'].toString(),
              price: value['data'][i]['price'].toString(),
              orderNumber: value['data'][i]['orderNumber'].toString(),
              item: value['data'][i]['item'].toString(),
              img: value['data'][i]['img'].toString(),
            ),
          );
        }
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////
