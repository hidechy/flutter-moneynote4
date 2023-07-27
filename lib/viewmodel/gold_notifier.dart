// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/state/gold/gold_response_state.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/gold.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////

final goldLastProvider =
    StateNotifierProvider.autoDispose.family<GoldLastNotifier, GoldResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return GoldLastNotifier(const GoldResponseState(), client, utility)..getLastGold(date: date);
});

class GoldLastNotifier extends StateNotifier<GoldResponseState> {
  GoldLastNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getLastGold({required DateTime date}) async {
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
          final val = Gold.fromJson(value['data'][i] as Map<String, dynamic>);

          if ('${val.year}-${val.month}-${val.day} 00:00:00'.toDateTime().isBefore(date)) {
            gold = val;
          }
        }
      }

      state = state.copyWith(lastGold: gold);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final goldListProvider = StateNotifierProvider.autoDispose<GoldListNotifier, GoldResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return GoldListNotifier(const GoldResponseState(), client, utility)..getGoldList();
});

class GoldListNotifier extends StateNotifier<GoldResponseState> {
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

      state = state.copyWith(goldList: list);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
