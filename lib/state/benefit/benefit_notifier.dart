// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/benefit.dart';
import '../../utility/utility.dart';
import 'benefit_response_state.dart';

/*
benefitProvider       List<Benefit>
*/

////////////////////////////////////////////////

final benefitProvider = StateNotifierProvider.autoDispose<BenefitNotifier, BenefitResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BenefitNotifier(const BenefitResponseState(), client, utility)..getBenefit();
});

class BenefitNotifier extends StateNotifier<BenefitResponseState> {
  BenefitNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBenefit() async {
    await client.post(path: APIPath.benefit).then((value) {
      final list = <Benefit>[];

      final map = <String, Benefit>{};

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final benefit = Benefit(
          date: DateTime(
            value['data'][i]['date'].toString().split('-')[0].toInt(),
            value['data'][i]['date'].toString().split('-')[1].toInt(),
            value['data'][i]['date'].toString().split('-')[2].toInt(),
          ),
          ym: value['data'][i]['ym'].toString(),
          salary: value['data'][i]['salary'].toString(),
          company: value['data'][i]['company'].toString(),
        );

        list.add(benefit);

        map[benefit.date.yyyymmdd] = benefit;
      }

      state = state.copyWith(benefitList: AsyncValue.data(list), benefitMap: AsyncValue.data(map));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
