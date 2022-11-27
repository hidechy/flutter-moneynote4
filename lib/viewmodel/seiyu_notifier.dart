// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../extensions/extensions.dart';
import '../models/seiyu_purchase.dart';

////////////////////////////////////////////////

final seiyuDateProvider = StateNotifierProvider.autoDispose
    .family<SeiyuDateNotifier, List<SeiyuPurchase>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  return SeiyuDateNotifier([], client)..getSeiyuDateList(date: date);
});

class SeiyuDateNotifier extends StateNotifier<List<SeiyuPurchase>> {
  SeiyuDateNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getSeiyuDateList({required DateTime date}) async {
    await client.post(
      path: 'seiyuuPurchaseList',
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SeiyuPurchase>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          SeiyuPurchase(
            date: value['data'][i]['date'].toString(),
            pos: value['data'][i]['pos'].toString().toInt(),
            item: value['data'][i]['item'].toString(),
            tanka: value['data'][i]['tanka'].toString(),
            kosuu: value['data'][i]['kosuu'].toString(),
            price: value['data'][i]['price'].toString(),
            img: value['data'][i]['img'].toString(),
          ),
        );
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final seiyuPurchaseProvider = StateNotifierProvider.autoDispose<
    SeiyuPurchaseNotifier, List<SeiyuPurchase>>((ref) {
  final client = ref.read(httpClientProvider);

  return SeiyuPurchaseNotifier([], client);
});

class SeiyuPurchaseNotifier extends StateNotifier<List<SeiyuPurchase>> {
  SeiyuPurchaseNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getSeiyuPurchaseList({required String date}) async {
    await client.post(
      path: 'seiyuuPurchaseList',
      body: {'date': date},
    ).then((value) {
      final list = <SeiyuPurchase>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date == value['data'][i]['date'].toString()) {
          list.add(
            SeiyuPurchase(
              date: value['data'][i]['date'].toString(),
              pos: value['data'][i]['pos'].toString().toInt(),
              item: value['data'][i]['item'].toString(),
              tanka: value['data'][i]['tanka'].toString(),
              kosuu: value['data'][i]['kosuu'].toString(),
              price: value['data'][i]['price'].toString(),
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
