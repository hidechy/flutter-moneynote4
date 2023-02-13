import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../extensions/extensions.dart';
import '../../utility/utility.dart';
import 'timeplace_input_state.dart';

////////////////////////////////////////////////
final timeplaceInputProvider = StateNotifierProvider.autoDispose
    .family<TimeplaceInputNotifier, TimeplaceInputState, String>(
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

  return TimeplaceInputNotifier(
      TimeplaceInputState(
        baseDiff: baseDiff,
        diff: 0,
        itemPos: 0,
        timeplace: list,
        spendPrice: list2,
        minusCheck: list3,
      ),
      client,
      utility);
});

class TimeplaceInputNotifier extends StateNotifier<TimeplaceInputState> {
  TimeplaceInputNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> setItemPos({required int pos}) async {
    state = state.copyWith(itemPos: pos);
  }

  ///
  Future<void> setTimeplace(
      {required int pos, required String timeplace}) async {
    final timeplaces = <String>[...state.timeplace];

    timeplaces[pos] = timeplace;

    state = state.copyWith(timeplace: timeplaces);
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
  Future<void> inputSpendItem({required DateTime date}) async {}
}

////////////////////////////////////////////////
