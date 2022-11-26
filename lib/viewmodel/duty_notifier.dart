import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../models/duty.dart';

import '../extensions/extensions.dart';

////////////////////////////////////////////////

final dutyProvider = StateNotifierProvider.autoDispose
    .family<DutyNotifier, List<Duty>, String>((ref, date) {
  final client = ref.read(httpClientProvider);

  return DutyNotifier([], client)..getDuty(date: date);
});

class DutyNotifier extends StateNotifier<List<Duty>> {
  DutyNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getDuty({required String date}) async {
    await client.post(
      path: 'getDutyData',
      body: {'date': date},
    ).then((value) {
      final list = <Duty>[];

      for (var i = 0; i < int.parse(value['data'].length.toString()); i++) {
        if ('$date 00:00:00'.toDateTime().yyyy ==
            '${value['data'][i]['date']} 00:00:00'.toDateTime().yyyy) {
          list.add(
            Duty(
              date: value['data'][i]['date'].toString(),
              duty: value['data'][i]['duty'].toString(),
              price: value['data'][i]['price'].toString().toInt(),
            ),
          );
        }
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////
