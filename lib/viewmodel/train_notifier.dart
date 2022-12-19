// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/train.dart';
import '../utility/utility.dart';

/*
trainProvider       List<Train>
*/

////////////////////////////////////////////////

final trainProvider =
    StateNotifierProvider.autoDispose<TrainNotifier, List<Train>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return TrainNotifier([], client, utility)..getTrain();
});

class TrainNotifier extends StateNotifier<List<Train>> {
  TrainNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getTrain() async {
    await client.post(path: APIPath.gettrainrecord).then((value) {
      final list = <Train>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          Train(
            date: '${value['data'][i]['date']} 00:00:00'.toDateTime(),
            station: value['data'][i]['station'].toString(),
            price: value['data'][i]['price'].toString(),
            oufuku: value['data'][i]['oufuku'].toString(),
          ),
        );
      }

      state = list;
    });
  }

  ///
  Future<void> getYearTrain({required DateTime date}) async {
    await client.post(path: APIPath.gettrainrecord).then((value) {
      final list = <Train>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyy ==
            '${value['data'][i]['date']} 00:00:00'.toDateTime().yyyy) {
          list.add(
            Train(
              date: '${value['data'][i]['date']} 00:00:00'.toDateTime(),
              station: value['data'][i]['station'].toString(),
              price: value['data'][i]['price'].toString(),
              oufuku: value['data'][i]['oufuku'].toString(),
            ),
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
