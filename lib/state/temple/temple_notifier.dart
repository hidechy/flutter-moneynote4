// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/temple.dart';
import '../../utility/utility.dart';
import 'temple_response_state.dart';

////////////////////////////////////////////////

final templeProvider = StateNotifierProvider.autoDispose<TempleNotifier, TempleResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return TempleNotifier(const TempleResponseState(), client, utility)..getTemple();
});

class TempleNotifier extends StateNotifier<TempleResponseState> {
  TempleNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getTemple() async {
    await client.post(path: APIPath.getAllTemple).then((value) {
      final list = <Temple>[];

      final map = <String, Temple>{};

      for (var i = 0; i < int.parse(value['list'].length.toString()); i++) {
        final val = Temple.fromJson(value['list'][i] as Map<String, dynamic>);

        list.add(val);

        map[val.date.yyyymmdd] = val;
      }

      state = state.copyWith(templeList: AsyncValue.data(list), templeMap: map);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
