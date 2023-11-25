// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/assets_data.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/gold.dart';
import '../../utility/utility.dart';
import 'gold_response_state.dart';

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
      var gold = Gold(year: '', month: '', day: '', goldTanka: '', goldPrice: '');

      final goldMap = <String, AssetsData>{};

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final val = Gold.fromJson(value['data'][i] as Map<String, dynamic>);
        final goldDate = '${val.year}-${val.month}-${val.day} 00:00:00'.toDateTime();

        var goldDiff = 0;
        var goldPercent = 0;
        if (val.goldValue != '-') {
          if (goldDate.isBefore(date)) {
            gold = val;
          }

          goldDiff = val.goldValue.toString().toInt() - val.payPrice.toString().toInt();

          goldPercent = (val.goldValue.toString().toInt() > 0 && val.payPrice.toInt() > 0)
              ? ((val.goldValue.toString().toInt() / val.payPrice.toInt()) * 100)
                  .round()
                  .toString()
                  .split('.')[0]
                  .toInt()
              : 0;
        }

        goldMap['${val.year}-${val.month}-${val.day}'] = AssetsData(
          cost: (val.payPrice == '-') ? 0 : val.payPrice.toInt(),
          price: (val.goldValue == '-') ? 0 : val.goldValue.toString().toInt(),
          diff: goldDiff,
          percent: goldPercent,
        );
      }

      state = state.copyWith(lastGold: gold, goldMap: AsyncValue.data(goldMap));
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
        list.add(Gold.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = state.copyWith(goldList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
