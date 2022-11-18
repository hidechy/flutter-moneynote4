// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/gold.dart';

import '../data/http/client.dart';

////////////////////////////////////////////////

final goldProvider =
    StateNotifierProvider.autoDispose<GoldNotifier, Gold>((ref) {
  final client = ref.read(httpClientProvider);

  return GoldNotifier(
    Gold(
      year: '',
      month: '',
      day: '',
      goldTanka: '',
      goldPrice: '',
    ),
    client,
  )..getGold();
});

class GoldNotifier extends StateNotifier<Gold> {
  GoldNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getGold() async {
    await client.post(path: 'getgolddata').then((value) {
      var gold = Gold(
        year: '',
        month: '',
        day: '',
        goldTanka: '',
        goldPrice: '',
      );

      for (var i = 0; i < int.parse(value['data'].length.toString()); i++) {
        if (value['data'][i]['gold_price'] != '-') {
          gold = Gold(
            year: value['data'][i]['year'].toString(),
            month: value['data'][i]['month'].toString(),
            day: value['data'][i]['day'].toString(),
            goldTanka: value['data'][i]['gold_tanka'].toString(),
            upDown: value['data'][i]['up_down'].toString(),
            diff: value['data'][i]['diff'].toString(),
            gramNum: value['data'][i]['gram_num'].toString(),
            totalGram: value['data'][i]['total_gram'].toString(),
            goldValue: value['data'][i]['gold_value'].toString(),
            goldPrice: value['data'][i]['gold_price'].toString(),
            payPrice: value['data'][i]['pay_price'].toString(),
          );
        }
      }

      state = gold;
    });
  }
}

////////////////////////////////////////////////
