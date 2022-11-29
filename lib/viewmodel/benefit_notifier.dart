// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../extensions/extensions.dart';
import '../models/benefit.dart';

////////////////////////////////////////////////

final benefitProvider =
    StateNotifierProvider.autoDispose<BenefitNotifier, List<Benefit>>((ref) {
  final client = ref.read(httpClientProvider);

  return BenefitNotifier([], client)..getBenefit();
});

class BenefitNotifier extends StateNotifier<List<Benefit>> {
  BenefitNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getBenefit() async {
    await client.post(path: 'benefit').then((value) {
      final list = <Benefit>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          Benefit(
            date: '${value['data'][i]['date']} 00:00:00'.toDateTime(),
            ym: value['data'][i]['ym'].toString(),
            salary: value['data'][i]['salary'].toString(),
            company: value['data'][i]['company'].toString(),
          ),
        );
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////
