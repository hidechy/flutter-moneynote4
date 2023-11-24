// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/spend_timeplace.dart';
import '../../utility/utility.dart';
import 'time_place_response_state.dart';

/*
timeplaceProvider        TimePlaceResponseState
*/

////////////////////////////////////////////////

final timeplaceProvider =
    StateNotifierProvider.autoDispose.family<TimeplaceNotifier, TimePlaceResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return TimeplaceNotifier(const TimePlaceResponseState(), client, utility)..getMonthlyTimeplace(date: date);
});

class TimeplaceNotifier extends StateNotifier<TimePlaceResponseState> {
  TimeplaceNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getMonthlyTimeplace({required DateTime date}) async {
    await client.post(
      path: APIPath.getmonthlytimeplace,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SpendTimeplace>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          SpendTimeplace(
            date: DateTime.parse(value['data'][i]['date'].toString()),
            time: value['data'][i]['time'].toString(),
            place: value['data'][i]['place'].toString(),
            price: value['data'][i]['price'].toString().toInt(),
          ),
        );
      }

      state = state.copyWith(timePlaceList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
