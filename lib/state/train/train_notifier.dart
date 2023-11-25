// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/train.dart';
import '../../utility/utility.dart';
import 'train_response_state.dart';

////////////////////////////////////////////////

final trainProvider = StateNotifierProvider.autoDispose<TrainNotifier, TrainResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return TrainNotifier(const TrainResponseState(), client, utility)..getTrain();
});

class TrainNotifier extends StateNotifier<TrainResponseState> {
  TrainNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getTrain() async {
    await client.post(path: APIPath.gettrainrecord).then((value) {
      final list = <Train>[];

      final map = <String, Train>{};

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final train = Train(
          date: DateTime(
            value['data'][i]['date'].toString().split('-')[0].toInt(),
            value['data'][i]['date'].toString().split('-')[1].toInt(),
            value['data'][i]['date'].toString().split('-')[2].toInt(),
          ),
          station: value['data'][i]['station'].toString(),
          price: value['data'][i]['price'].toString(),
          oufuku: value['data'][i]['oufuku'].toString(),
        );

        list.add(train);

        map[train.date.yyyymmdd] = train;
      }

      state = state.copyWith(trainList: AsyncValue.data(list), trainMap: map);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
