// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../utility/utility.dart';
import 'monthly_spend_check_state.dart';

////////////////////////////////////////////////
final monthlySpendCheckProvider = StateNotifierProvider.autoDispose
    .family<MonthlySpendCheckNotifier, MonthlySpendCheckState, DateTime>(
        (ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return MonthlySpendCheckNotifier(
    const MonthlySpendCheckState(selectItem: []),
    client,
    utility,
  )..getSpendCheckItem(date: date);
});

class MonthlySpendCheckNotifier extends StateNotifier<MonthlySpendCheckState> {
  MonthlySpendCheckNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getSpendCheckItem({required DateTime date}) async {
    await client.post(
      path: APIPath.getSpendCheckItem,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <String>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(value['data'][i] as String);
      }

      state = state.copyWith(selectItem: list);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }

  ///
  Future<void> setSelectItem({required String item}) async {
    final items = [...state.selectItem];
    if (items.contains(item)) {
      items.remove(item);
    } else {
      items.add(item);
    }
    state = state.copyWith(selectItem: items);
  }

  ///
  Future<void> inputCheckItem({required DateTime date}) async {
    final items = [...state.selectItem];

    final uploadData = <String, dynamic>{};
    uploadData['date'] = date.yyyymmdd;
    uploadData['items'] = items;

    await client
        .post(path: APIPath.inputSpendCheckItem, body: uploadData)
        .then((value) {})
        .catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
