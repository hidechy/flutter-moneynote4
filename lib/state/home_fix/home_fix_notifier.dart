// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/home_fix.dart';
import '../../utility/utility.dart';
import 'home_fix_response_state.dart';

/*
homeFixProvider       HomeFixResponseState
*/

////////////////////////////////////////////////

final homeFixProvider =
    StateNotifierProvider.autoDispose.family<HomeFixNotifier, HomeFixResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return HomeFixNotifier(const HomeFixResponseState(), client, utility)..getHomeFix(date: date);
});

class HomeFixNotifier extends StateNotifier<HomeFixResponseState> {
  HomeFixNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getHomeFix({required DateTime date}) async {
    await client.post(path: APIPath.homeFix).then((value) {
      final list = <HomeFix>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyy ==
            DateTime(
              value['data'][i]['ym'].toString().split('-')[0].toInt(),
              value['data'][i]['ym'].toString().split('-')[1].toInt(),
            ).yyyy) {
          list.add(
            HomeFix.fromJson(value['data'][i] as Map<String, dynamic>),
          );
        }
      }

      state = state.copyWith(homeFixList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
