// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/time_location.dart';
import '../../utility/utility.dart';
import 'time_location_response_state.dart';

////////////////////////////////////////////////

final timeLocationProvider =
    StateNotifierProvider.autoDispose.family<TimeLocationNotifier, TimeLocationResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return TimeLocationNotifier(const TimeLocationResponseState(), client, utility)..getTimeLocation(date: date);
});

class TimeLocationNotifier extends StateNotifier<TimeLocationResponseState> {
  TimeLocationNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getTimeLocation({required DateTime date}) async {
    await client.post(path: APIPath.getTimeLocation, body: {'date': date.yyyymmdd}).then((value) {
      final list = <TimeLocation>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(TimeLocation.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = state.copyWith(timeLocationList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}
////////////////////////////////////////////////
