// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/seiyu_item.dart';
import '../models/seiyu_purchase.dart';
import '../state/seiyu_purchase_item/seiyu_purchase_item_request_state.dart';
import '../utility/utility.dart';

/*
seiyuAllProvider        List<SeiyuPurchase>
seiyuPurchaseDateProvider       List<SeiyuPurchase>
seiyuPurchaseItemProvider       List<SeiyuItem>
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

////////////////////////////////////////////////

final seiyuPurchaseItemProvider = StateNotifierProvider.autoDispose.family<
    SeiyuPurchaseItemNotifier,
    List<SeiyuItem>,
    SeiyuPurchaseItemRequestState>((ref, param) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SeiyuPurchaseItemNotifier([], client, utility)
    ..getSeiyuPurchaseItemList(param: param);
});

class SeiyuPurchaseItemNotifier extends StateNotifier<List<SeiyuItem>> {
  SeiyuPurchaseItemNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSeiyuPurchaseItemList(
      {required SeiyuPurchaseItemRequestState param}) async {
    await client.post(
      path: APIPath.getSeiyuuPurchaseItemList,
      body: {'date': param.date.yyyymmdd},
    ).then((value) {
      final list = <SeiyuItem>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (param.item == value['data'][i]['item'].toString()) {
          list.add(
              SeiyuItem.fromJson(value['data'][i] as Map<String, dynamic>));
        }
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
