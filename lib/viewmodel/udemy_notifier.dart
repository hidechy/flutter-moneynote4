// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/udemy.dart';
import '../utility/utility.dart';

/*
udemyProvider       List<Udemy>
*/

////////////////////////////////////////////////

final udemyProvider =
    StateNotifierProvider.autoDispose<UdemyNotifier, List<Udemy>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return UdemyNotifier([], client, utility)..getUdemy();
});

class UdemyNotifier extends StateNotifier<List<Udemy>> {
  UdemyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getUdemy() async {
    await client.post(path: APIPath.getUdemyData).then((value) {
      final list = <Udemy>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          Udemy.fromJson(value['data'][i] as Map<String, dynamic>),
        );
      }

      state = list;
    });
  }

  ///
  Future<void> getYearUdemy({required int year}) async {
    await client.post(path: APIPath.getUdemyData).then((value) {
      final list = <Udemy>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          Udemy.fromJson(value['data'][i] as Map<String, dynamic>),
        );
      }

      final list2 = <Udemy>[];

      for (var i = 0; i < list.length; i++) {
        if ('${list[i].date} 00:00:00'.toDateTime().yyyy.toInt() == year) {
          list2.add(list[i]);
        }
      }

      state = list2;
    });
  }

  ///
  Future<void> getYearCategoryUdemy(
      {required int year, required String category}) async {
    await client.post(path: APIPath.getUdemyData).then((value) {
      final list = <Udemy>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          Udemy.fromJson(value['data'][i] as Map<String, dynamic>),
        );
      }

      final list2 = <Udemy>[];

      for (var i = 0; i < list.length; i++) {
        if ('${list[i].date} 00:00:00'.toDateTime().yyyy.toInt() == year) {
          if (list[i].category == category) {
            list2.add(list[i]);
          }
        }
      }

      state = list2;
    });
  }
}

////////////////////////////////////////////////
