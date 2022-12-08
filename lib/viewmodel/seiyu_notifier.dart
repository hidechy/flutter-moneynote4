// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/seiyu_purchase.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////

final seiyuDateProvider = StateNotifierProvider.autoDispose
    .family<SeiyuDateNotifier, List<SeiyuPurchase>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SeiyuDateNotifier([], client, utility)..getSeiyuDateList(date: date);
});

class SeiyuDateNotifier extends StateNotifier<List<SeiyuPurchase>> {
  SeiyuDateNotifier(super.state, this.client, this.utility);

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

final seiyuPurchaseProvider = StateNotifierProvider.autoDispose<
    SeiyuPurchaseNotifier, List<SeiyuPurchase>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SeiyuPurchaseNotifier([], client, utility);
});

class SeiyuPurchaseNotifier extends StateNotifier<List<SeiyuPurchase>> {
  SeiyuPurchaseNotifier(super.state, this.client, this.utility);

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
