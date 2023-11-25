import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../utility/utility.dart';
import 'timeplace_input_state.dart';

////////////////////////////////////////////////
final timeplaceInputProvider =
    StateNotifierProvider.autoDispose.family<TimeplaceInputNotifier, TimeplaceInputState, String>((ref, baseDiff) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  final list = <String>[];
  final list2 = <int>[];
  final list3 = <bool>[];
  final list4 = <String>[];
  for (var i = 0; i < 10; i++) {
    list.add('');
    list2.add(0);
    list3.add(false);
    list4.add('');
  }

  return TimeplaceInputNotifier(
      TimeplaceInputState(
        baseDiff: baseDiff,
        time: list,
        place: list4,
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
  Future<void> setTime({required int pos, required String time}) async {
    final times = <String>[...state.time];

    times[pos] = time;

    state = state.copyWith(time: times);
  }

  ///
  Future<void> setPlace({required int pos, required String place}) async {
    final places = <String>[...state.place];

    places[pos] = place;

    state = state.copyWith(place: places);
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
  Future<void> inputTimeplace({required DateTime date}) async {
    final list = <Map<String, dynamic>>[];
    for (var i = 0; i < 10; i++) {
      if (state.time[i] != '' && state.place[i] != '') {
        final price = (state.minusCheck[i]) ? state.spendPrice[i] * -1 : state.spendPrice[i];

        list.add({
          'time': state.time[i],
          'place': state.place[i],
          'price': price,
        });
      }
    }

    final uploadData = <String, dynamic>{};
    uploadData['date'] = date.yyyymmdd;
    uploadData['timeplace'] = list;

    await client.post(path: APIPath.timeplaceInsert, body: uploadData).then((value) {}).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
