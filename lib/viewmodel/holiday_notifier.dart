// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';

import '../data/http/client.dart';
import '../models/holiday.dart';

////////////////////////////////////////////////

final holidayProvider =
    StateNotifierProvider.autoDispose<HolidayNotifier, Holiday>((ref) {
  final client = ref.read(httpClientProvider);

  return HolidayNotifier(
    Holiday(data: []),
    client,
  )..getHoliday();
});

class HolidayNotifier extends StateNotifier<Holiday> {
  HolidayNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getHoliday() async {
    await client.post(path: 'getholiday').then((value) {
      final list = <DateTime>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(DateTime.parse(value['data'][i].toString()));
      }

      state = Holiday(data: list);
    });
  }
}

////////////////////////////////////////////////
