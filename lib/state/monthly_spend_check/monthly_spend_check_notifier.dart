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
    const MonthlySpendCheckState(),
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

      final list2 = <Map<String, dynamic>>[];

      var monthTotal = 0;
      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final exValueData = value['data'][i].toString().split(';');
        list.add(exValueData[0]);

        list2.add({
          'id': exValueData[1],
          'item': exValueData[0],
          'cate': exValueData[2],
        });

        final exValue = value['data'][i].toString().split('|');
        monthTotal += exValue[2].toInt();
      }

      state = state.copyWith(
        selectItems: list,
        monthTotal: monthTotal,
        checkItems: list2,
      );
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }

  ///
  Future<void> setSelectItem({required String item}) async {
    final items = [...state.selectItems];
    var monthTotal = state.monthTotal;

    final exItem = item.split('|');

    if (items.contains(item)) {
      items.remove(item);

      monthTotal -= exItem[2].toInt();
    } else {
      items.add(item);

      monthTotal += exItem[2].toInt();
    }

    state = state.copyWith(selectItems: items, monthTotal: monthTotal);
  }

  ///
  Future<void> setSelectCategory({required String category}) async {
    state = state.copyWith(selectedCategory: category);
  }

  ///
  Future<void> setErrorMsg({required String error}) async {
    state = state.copyWith(errorMsg: error);
  }

  ///
  Future<void> inputCheckItem({required DateTime date}) async {
    final items = [...state.selectItems];

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

  ///
  Future<void> updateKeihiCategory({required int id}) async {
    final exSelectedCategory = state.selectedCategory.toString().split('|');

    final uploadData = <String, dynamic>{};
    uploadData['category1'] = exSelectedCategory[0];
    uploadData['category2'] = exSelectedCategory[1];
    uploadData['id'] = id;

    await client
        .post(path: APIPath.updateKeihiCategory, body: uploadData)
        .then((value) {})
        .catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
