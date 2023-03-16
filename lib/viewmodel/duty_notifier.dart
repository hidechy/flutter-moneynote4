// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/duty.dart';
import '../utility/utility.dart';

/*
dutyProvider        List<Duty>
*/

////////////////////////////////////////////////

final dutyProvider = StateNotifierProvider.autoDispose
    .family<DutyNotifier, List<Duty>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return DutyNotifier([], client, utility)..getDuty(date: date);
});

class DutyNotifier extends StateNotifier<List<Duty>> {
  DutyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getDuty({required DateTime date}) async {
    await client.post(
      path: APIPath.getDutyData,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <Duty>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyy ==
            DateTime(
              value['data'][i]['date'].toString().split('-')[0].toInt(),
              value['data'][i]['date'].toString().split('-')[1].toInt(),
              value['data'][i]['date'].toString().split('-')[2].toInt(),
            ).yyyy) {
          list.add(
            Duty.fromJson(value['data'][i] as Map<String, dynamic>),
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
