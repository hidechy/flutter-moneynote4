import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../utility/utility.dart';
import 'spend_item_input_state.dart';

////////////////////////////////////////////////
final spendItemInputProvider = StateNotifierProvider.autoDispose
    .family<SpendItemInputNotifier, SpendItemInputState, String>(
        (ref, baseDiff) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  final list = <String>[];
  final list2 = <int>[];
  final list3 = <bool>[];
  for (var i = 0; i < 10; i++) {
    list.add('');
    list2.add(0);
    list3.add(false);
  }

  return SpendItemInputNotifier(
      SpendItemInputState(
        baseDiff: baseDiff,
        spendItem: list,
        spendPrice: list2,
        minusCheck: list3,
      ),
      client,
      utility);
});

class SpendItemInputNotifier extends StateNotifier<SpendItemInputState> {
  SpendItemInputNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> setItemPos({required int pos}) async {
    state = state.copyWith(itemPos: pos);
  }

  ///
  Future<void> setSpendItem({required int pos, required String item}) async {
    final items = <String>[...state.spendItem];

    items[pos] = item;

    state = state.copyWith(spendItem: items);
  }

  ///
  Future<void> setSpendPrice({required int pos, required int price}) async {
    final prices = <int>[...state.spendPrice];
    prices[pos] = price;

    var sum = 0;
    for (var i = 0; i < prices.length; i++) {
      if (state.minusCheck[i]) {
        sum -= prices[i];
      } else {
        sum += prices[i];
      }
    }

    final baseDiff = state.baseDiff.toInt();
    final diff = baseDiff - sum;

    state = state.copyWith(spendPrice: prices, diff: diff);
  }

  ///
  Future<void> setMinusCheck({required int pos}) async {
    final minusChecks = <bool>[...state.minusCheck];
    final check = minusChecks[pos];
    minusChecks[pos] = !check;
    state = state.copyWith(minusCheck: minusChecks);
  }

  ///
  Future<void> inputSpendItem({required DateTime date}) async {
    final list = <Map<String, dynamic>>[];
    for (var i = 0; i < 10; i++) {
      if (state.spendItem[i] != '' && state.spendPrice[i] != 0) {
        final price = (state.minusCheck[i])
            ? state.spendPrice[i] * -1
            : state.spendPrice[i];

        list.add({'item': state.spendItem[i], 'price': price});
      } else if (state.spendItem[i] == '食費' && state.spendPrice[i] == 0) {
        list.add({'item': '食費', 'price': 0});
      }
    }

    final uploadData = <String, dynamic>{};
    uploadData['date'] = date.yyyymmdd;
    uploadData['spend'] = list;

    await client
        .post(path: APIPath.spendItemInsert, body: uploadData)
        .then((value) {})
        .catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}
////////////////////////////////////////////////
