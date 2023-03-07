// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/keihi.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////

final keihiListProvider = StateNotifierProvider.autoDispose
    .family<KeihiListNotifier, List<Keihi>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return KeihiListNotifier([], client, utility)..getKeihiList(date: date);
});

class KeihiListNotifier extends StateNotifier<List<Keihi>> {
  KeihiListNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getKeihiList({required DateTime date}) async {
    await client.post(
      path: APIPath.selectSpendCheckItem,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <Keihi>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(Keihi.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////

/*





import '../state/keihi_list/keihi_list_request_state.dart';

////////////////////////////////////////////////

final keihiListProvider =
    StateNotifierProvider.autoDispose<KeihiListNotifier, List<Keihi>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return KeihiListNotifier([], client, utility)
    ..getKeihiList(param: const KeihiListRequestState());
});

class KeihiListNotifier extends StateNotifier<List<Keihi>> {
  KeihiListNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getKeihiList({required KeihiListRequestState param}) async {
    final uploadData = <String, dynamic>{};
    uploadData['order'] = param.selectOrder;

    await client.post(path: APIPath.selectSpendCheckItem).then((value) {
      final list = <Keihi>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (param.selectDate != null) {
          if ('${value['data'][i]['date']} 00:00:00'.toDateTime().yyyy ==
              param.selectDate!.yyyy) {
            list.add(Keihi.fromJson(value['data'][i] as Map<String, dynamic>));
          }
        }
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////








*/
