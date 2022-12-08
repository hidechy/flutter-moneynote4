// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/home_fix.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////

final homeFixProvider = StateNotifierProvider.autoDispose
    .family<HomeFixNotifier, List<HomeFix>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return HomeFixNotifier([], client, utility)..getHomeFix(date: date);
});

class HomeFixNotifier extends StateNotifier<List<HomeFix>> {
  HomeFixNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getHomeFix({required DateTime date}) async {
    await client.post(path: APIPath.homeFix).then((value) {
      final list = <HomeFix>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyy ==
            '${value['data'][i]['ym']}-01 00:00:00'.toDateTime().yyyy) {
          list.add(
            // HomeFix(
            //   ym: value['data'][i]['ym'].toString(),
            //   yachin: value['data'][i]['yachin'].toString(),
            //   wifi: value['data'][i]['wifi'].toString(),
            //   mobile: value['data'][i]['mobile'].toString(),
            //   gas: value['data'][i]['gas'].toString(),
            //   denki: value['data'][i]['denki'].toString(),
            //   suidou: value['data'][i]['suidou'].toString(),
            // ),

            HomeFix.fromJson(value['data'][i] as Map<String, dynamic>),
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
