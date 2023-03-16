// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/balancesheet.dart';
import '../utility/utility.dart';

/*
balanceSheetProvider        List<Balancesheet>
*/

////////////////////////////////////////////////

final balanceSheetProvider = StateNotifierProvider.autoDispose
    .family<BalanceSheetNotifier, List<Balancesheet>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BalanceSheetNotifier([], client, utility)
    ..getBalanceSheetList(date: date);
});

class BalanceSheetNotifier extends StateNotifier<List<Balancesheet>> {
  BalanceSheetNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBalanceSheetList({required DateTime date}) async {
    await client.post(path: APIPath.balanceSheetRecord).then((value) {
      final list = <Balancesheet>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyy ==
            DateTime(
              value['data'][i]['ym'].toString().split('-')[0].toInt(),
              value['data'][i]['ym'].toString().split('-')[1].toInt(),
            ).yyyy) {
          list.add(
            Balancesheet.fromJson(value['data'][i] as Map<String, dynamic>),
          );
        }
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
