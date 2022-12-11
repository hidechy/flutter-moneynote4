// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/udemy.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////

final udemyProvider = StateNotifierProvider.autoDispose
    .family<UdemyNotifier, List<Udemy>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return UdemyNotifier([], client, utility)..getUdemy();
});

class UdemyNotifier extends StateNotifier<List<Udemy>> {
  UdemyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getUdemy() async {
    await client.post(path: APIPath.getUdemyData).then((value) {
      final list = <Udemy>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          Udemy.fromJson(value['data'][i] as Map<String, dynamic>),
        );
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////
