// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/wells.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////

final wellsReserveProvider =
    StateNotifierProvider.autoDispose<WellsReserveNotifier, List<Wells>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return WellsReserveNotifier([], client, utility);
});

class WellsReserveNotifier extends StateNotifier<List<Wells>> {
  WellsReserveNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getWellsReserveNotifier({required DateTime date}) async {
    await client.post(path: APIPath.getWellsRecord).then((value) {
      final list = <Wells>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final exValue = value['data'][i].toString().split(':');

        if (exValue[0] == date.yyyy) {
          final exval = exValue[1].split('/');
          for (var j = 0; j < exval.length; j++) {
            final exv = exval[j].split('|');

            if (exv[1] == '') {
              continue;
            }

            list.add(
              Wells(
                num: exv[0],
                date: '${exValue[0]}-${exv[1]} 00:00:00'.toDateTime(),
                price: exv[2],
                total: exv[3],
              ),
            );
          }
        }
      }

      state = list;
    });
  }
}
////////////////////////////////////////////////
