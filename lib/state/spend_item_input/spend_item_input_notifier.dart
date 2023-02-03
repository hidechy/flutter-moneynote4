import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';

//
//
// import '../../data/http/path.dart';
//

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
  for (var i = 0; i < 10; i++) {
    list.add('');
    list2.add(0);
  }

  return SpendItemInputNotifier(
      SpendItemInputState(
        baseDiff: baseDiff,
        diff: 0,
        itemPos: 0,
        spendItem: list,
        spendPrice: list2,
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
    prices.forEach((element) {
      sum += element;
    });

    final baseDiff = state.baseDiff.toInt();
    final diff = baseDiff - sum;

    state = state.copyWith(
      spendPrice: prices,
      diff: diff,
    );
  }

  ///
  Future<void> inputSpendItem({required DateTime date}) async {
    final list = <Map<String, dynamic>>[];
    for (var i = 0; i < 10; i++) {
      if (state.spendItem[i] != '' && state.spendPrice[i] != 0) {
        list.add({'item': state.spendItem[i], 'price': state.spendPrice[i]});
      }
    }

    final uploadData = <String, dynamic>{};
    uploadData['date'] = date.yyyymmdd;
    uploadData['spend'] = list;

    print(uploadData);

    /*

    await client
        .post(path: APIPath.spendItemInput, body: uploadData)
        .then((value) {})
        .catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });

    */
  }
}
////////////////////////////////////////////////
