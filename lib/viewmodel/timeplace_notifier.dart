// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/spend_timeplace.dart';
import '../utility/utility.dart';

/*
timeplaceProvider       List<SpendTimeplace>
*/

////////////////////////////////////////////////

final onedayTimeplaceProvider = StateNotifierProvider.autoDispose
    .family<OnedayTimeplaceNotifier, List<SpendTimeplace>, DateTime>(
        (ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return OnedayTimeplaceNotifier(
    [],
    client,
    utility,
  )..getOnedayTimeplace(date: date);
});

class OnedayTimeplaceNotifier extends StateNotifier<List<SpendTimeplace>> {
  OnedayTimeplaceNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getOnedayTimeplace({required DateTime date}) async {
    await client.post(
      path: APIPath.getmonthlytimeplace,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SpendTimeplace>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (value['data'][i]['date'] == date.yyyymmdd) {
          list.add(
            SpendTimeplace(
              date: DateTime.parse(value['data'][i]['date'].toString()),
              time: value['data'][i]['time'].toString(),
              place: value['data'][i]['place'].toString(),
              price: value['data'][i]['price'].toString().toInt(),
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

////////////////////////////////////////////////

final monthlyTimeplaceProvider = StateNotifierProvider.autoDispose
    .family<MonthlyTimeplaceNotifier, List<SpendTimeplace>, DateTime>(
        (ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return MonthlyTimeplaceNotifier(
    [],
    client,
    utility,
  )..getMonthlyTimeplace(date: date);
});

class MonthlyTimeplaceNotifier extends StateNotifier<List<SpendTimeplace>> {
  MonthlyTimeplaceNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getMonthlyTimeplace({required DateTime date}) async {
    await client.post(
      path: APIPath.getmonthlytimeplace,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SpendTimeplace>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          SpendTimeplace(
            date: DateTime.parse(value['data'][i]['date'].toString()),
            time: value['data'][i]['time'].toString(),
            place: value['data'][i]['place'].toString(),
            price: value['data'][i]['price'].toString().toInt(),
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
