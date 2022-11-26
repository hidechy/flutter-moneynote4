// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';

import '../data/http/client.dart';
import '../models/amazon_purchase.dart';

////////////////////////////////////////////////

final amazonPurchaseProvider = StateNotifierProvider.autoDispose
    .family<AmazonPurchaseNotifier, List<AmazonPurchase>, String>((ref, date) {
  final client = ref.read(httpClientProvider);

  return AmazonPurchaseNotifier([], client)..getAmazonPurchaseList(date: date);
});

class AmazonPurchaseNotifier extends StateNotifier<List<AmazonPurchase>> {
  AmazonPurchaseNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getAmazonPurchaseList({required String date}) async {
    await client.post(
      path: 'amazonPurchaseList',
      body: {'date': date},
    ).then((value) {
      final list = <AmazonPurchase>[];

      for (var i = 0; i < int.parse(value['data'].length.toString()); i++) {
        if ('$date 00:00:00'.toDateTime().yyyy ==
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
