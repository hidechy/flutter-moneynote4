// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/spend_timeplace.dart';
import '../utility/utility.dart';

/*
timeplaceProvider       List<SpendTimeplace>
*/

////////////////////////////////////////////////

final timeplaceProvider = StateNotifierProvider.autoDispose
    .family<TimeplaceNotifier, List<SpendTimeplace>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return TimeplaceNotifier([], client, utility)..getTimeplace(date: date);
});

class TimeplaceNotifier extends StateNotifier<List<SpendTimeplace>> {
  TimeplaceNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getTimeplace({required DateTime date}) async {
    await client.post(
      path: APIPath.getmonthlytimeplace,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SpendTimeplace>[];

      for (var i = 0; i < int.parse(value['data'].length.toString()); i++) {
        if (value['data'][i]['date'] == date.yyyymmdd) {
          list.add(
            SpendTimeplace(
              date: DateTime.parse(value['data'][i]['date'].toString()),
              time: value['data'][i]['time'].toString(),
              place: value['data'][i]['place'].toString(),
              price: int.parse(value['data'][i]['price'].toString()),
            ),
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
