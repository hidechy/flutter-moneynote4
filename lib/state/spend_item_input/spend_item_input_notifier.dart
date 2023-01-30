import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../utility/utility.dart';
import 'spend_item_input_state.dart';

////////////////////////////////////////////////
final spendItemInputProvider = StateNotifierProvider.autoDispose<
    SpendItemInputNotifier, SpendItemInputState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  final list = <String>[];
  for (var i = 0; i < 10; i++) {
    list.add('');
  }

  return SpendItemInputNotifier(
      SpendItemInputState(
        itemPos: 0,
        spendItem: list,
        spendPrice: list,
      ),
      client,
      utility);
});

class SpendItemInputNotifier extends StateNotifier<SpendItemInputState> {
  SpendItemInputNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> setItemPos({required int pos}) async {
    state = state.copyWith(itemPos: pos);
  }

  Future<void> setSpendItem({required int pos, required String item}) async {
    final items = <String>[...state.spendItem];

    items[pos] = item;

    print(items);

    state = state.copyWith(spendItem: items);
  }

  Future<void> setSpendPrice({required int pos, required String price}) async {
    final prices = <String>[...state.spendPrice];
    prices[pos] = price;

    print(prices);

    state = state.copyWith(spendPrice: prices);
  }

  Future<void> inputSpendItem() async {}
}
////////////////////////////////////////////////
