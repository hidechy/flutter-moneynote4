// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/temple_latlng.dart';
import '../../utility/utility.dart';
import 'temple_latlng_response_state.dart';

////////////////////////////////////////////////

final templeLatLngProvider = StateNotifierProvider.autoDispose<TempleLatLngNotifier, TempleLatLngResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return TempleLatLngNotifier(const TempleLatLngResponseState(), client, utility)..getTempleLatLng();
});

class TempleLatLngNotifier extends StateNotifier<TempleLatLngResponseState> {
  TempleLatLngNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getTempleLatLng() async {
    await client.post(path: APIPath.getTempleLatLng).then((value) {
      final list = <TempleLatLng>[];

      final map = <String, TempleLatLng>{};

      for (var i = 0; i < value['list'].length.toString().toInt(); i++) {
        final val = TempleLatLng.fromJson(value['list'][i] as Map<String, dynamic>);

        list.add(val);

        map[val.temple] = val;
      }

      state = state.copyWith(templeLatLngList: AsyncValue.data(list), templeLatLngMap: map);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
