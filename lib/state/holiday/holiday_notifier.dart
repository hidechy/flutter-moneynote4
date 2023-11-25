// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/holiday.dart';
import '../../utility/utility.dart';

/*
holidayProvider       Holiday
*/

////////////////////////////////////////////////

final holidayProvider = StateNotifierProvider.autoDispose<HolidayNotifier, Holiday>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return HolidayNotifier(Holiday(data: []), client, utility)..getHoliday();
});

class HolidayNotifier extends StateNotifier<Holiday> {
  HolidayNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getHoliday() async {
    await client.post(path: APIPath.getholiday).then((value) {
      final list = <DateTime>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(DateTime.parse(value['data'][i].toString()));
      }

      state = Holiday(data: list);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
