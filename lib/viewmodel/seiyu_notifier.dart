// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/seiyu_purchase.dart';
import '../utility/utility.dart';

/*
seiyuAllProvider        List<SeiyuPurchase>
seiyuPurchaseDateProvider       List<SeiyuPurchase>
*/

////////////////////////////////////////////////

final seiyuAllProvider = StateNotifierProvider.autoDispose
    .family<SeiyuAllNotifier, List<SeiyuPurchase>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SeiyuAllNotifier([], client, utility)..getSeiyuDateList(date: date);
});

class SeiyuAllNotifier extends StateNotifier<List<SeiyuPurchase>> {
  SeiyuAllNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSeiyuDateList({required DateTime date}) async {
    await client.post(
      path: APIPath.seiyuuPurchaseList,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SeiyuPurchase>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          // SeiyuPurchase(
          //   date: value['data'][i]['date'].toString(),
          //   pos: value['data'][i]['pos'].toString().toInt(),
          //   item: value['data'][i]['item'].toString(),
          //   tanka: value['data'][i]['tanka'].toString(),
          //   kosuu: value['data'][i]['kosuu'].toString(),
          //   price: value['data'][i]['price'].toString(),
          //   img: value['data'][i]['img'].toString(),
          // ),

          SeiyuPurchase.fromJson(value['data'][i] as Map<String, dynamic>),
        );
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final seiyuPurchaseDateProvider = StateNotifierProvider.autoDispose<
    SeiyuPurchaseDateNotifier, List<SeiyuPurchase>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SeiyuPurchaseDateNotifier([], client, utility);
});

class SeiyuPurchaseDateNotifier extends StateNotifier<List<SeiyuPurchase>> {
  SeiyuPurchaseDateNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSeiyuPurchaseList({required String date}) async {
    await client.post(
      path: APIPath.seiyuuPurchaseList,
      body: {'date': date},
    ).then((value) {
      final list = <SeiyuPurchase>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date == value['data'][i]['date'].toString()) {
          list.add(
            // SeiyuPurchase(
            //   date: value['data'][i]['date'].toString(),
            //   pos: value['data'][i]['pos'].toString().toInt(),
            //   item: value['data'][i]['item'].toString(),
            //   tanka: value['data'][i]['tanka'].toString(),
            //   kosuu: value['data'][i]['kosuu'].toString(),
            //   price: value['data'][i]['price'].toString(),
            //   img: value['data'][i]['img'].toString(),
            // ),

            SeiyuPurchase.fromJson(value['data'][i] as Map<String, dynamic>),
          );
        }
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
