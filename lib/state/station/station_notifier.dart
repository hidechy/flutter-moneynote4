// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/station.dart';
import '../../utility/utility.dart';
import 'station_response_state.dart';

////////////////////////////////////////////////

final stationProvider = StateNotifierProvider.autoDispose<StationNotifier, StationResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return StationNotifier(const StationResponseState(), client, utility)..getStation();
});

class StationNotifier extends StateNotifier<StationResponseState> {
  StationNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getStation() async {
    await client.post(path: APIPath.getAllStation).then((value) {
      final list = <Station>[];

      final map = <String, Station>{};

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final val = Station.fromJson(value['data'][i] as Map<String, dynamic>);

        list.add(val);

        map[val.id.toString()] = val;
      }

      state = state.copyWith(stationList: list, stationMap: map);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
