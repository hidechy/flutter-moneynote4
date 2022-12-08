// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../extensions/extensions.dart';
import '../models/duty.dart';

////////////////////////////////////////////////

final dutyProvider = StateNotifierProvider.autoDispose
    .family<DutyNotifier, List<Duty>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  return DutyNotifier([], client)..getDuty(date: date);
});

class DutyNotifier extends StateNotifier<List<Duty>> {
  DutyNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getDuty({required DateTime date}) async {
    await client.post(
      path: 'getDutyData',
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <Duty>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyy ==
            '${value['data'][i]['date']} 00:00:00'.toDateTime().yyyy) {
          list.add(
            // Duty(
            //   date: value['data'][i]['date'].toString(),
            //   duty: value['data'][i]['duty'].toString(),
            //   price: value['data'][i]['price'].toString().toInt(),
            // ),

            Duty.fromJson(value['data'][i] as Map<String, dynamic>),
          );
        }
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////
