// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/benefit.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////

final benefitProvider =
    StateNotifierProvider.autoDispose<BenefitNotifier, List<Benefit>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BenefitNotifier([], client, utility)..getBenefit();
});

class BenefitNotifier extends StateNotifier<List<Benefit>> {
  BenefitNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBenefit() async {
    await client.post(path: APIPath.benefit).then((value) {
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
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
