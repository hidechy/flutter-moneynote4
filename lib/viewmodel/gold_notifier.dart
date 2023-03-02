// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/gold.dart';
import '../utility/utility.dart';

/*
goldLastProvider        Gold
goldListProvider        List<Gold>
*/

////////////////////////////////////////////////

final goldLastProvider =
    StateNotifierProvider.autoDispose<GoldLastNotifier, Gold>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return GoldLastNotifier(
    Gold(
      year: '',
      month: '',
      day: '',
      goldTanka: '',
      goldPrice: '',
    ),
    client,
    utility,
  )..getLastGold();
});

class GoldLastNotifier extends StateNotifier<Gold> {
  GoldLastNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getLastGold() async {
    await client.post(path: APIPath.getgolddata).then((value) {
      var gold = Gold(
        year: '',
        month: '',
        day: '',
        goldTanka: '',
        goldPrice: '',
      );

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (value['data'][i]['gold_price'] != '-') {
          gold = Gold.fromJson(value['data'][i] as Map<String, dynamic>);
        }
      }

      state = gold;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final goldListProvider =
    StateNotifierProvider.autoDispose<GoldListNotifier, List<Gold>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return GoldListNotifier([], client, utility)..getGoldList();
});

class GoldListNotifier extends StateNotifier<List<Gold>> {
  GoldListNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getGoldList() async {
    await client.post(path: APIPath.getgolddata).then((value) {
      final list = <Gold>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          Gold.fromJson(value['data'][i] as Map<String, dynamic>),
        );
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
