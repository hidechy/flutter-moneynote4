// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/udemy.dart';
import '../../utility/utility.dart';
import 'udemy_response_state.dart';

/*
udemyProvider       List<Udemy>
*/

////////////////////////////////////////////////

final udemyProvider = StateNotifierProvider.autoDispose<UdemyNotifier, UdemyResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return UdemyNotifier(const UdemyResponseState(), client, utility)..getUdemy();
});

class UdemyNotifier extends StateNotifier<UdemyResponseState> {
  UdemyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getUdemy() async {
    await client.post(path: APIPath.getUdemyData).then((value) {
      final list = <Udemy>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(Udemy.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = state.copyWith(udemyList: AsyncValue.data(list));
    });
  }

  // ///
  // Future<void> getYearUdemy({required int year}) async {
  //   await client.post(path: APIPath.getUdemyData).then((value) {
  //     final list = <Udemy>[];
  //
  //     for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
  //       list.add(Udemy.fromJson(value['data'][i] as Map<String, dynamic>));
  //     }
  //
  //     final list2 = <Udemy>[];
  //
  //     for (var i = 0; i < list.length; i++) {
  //       // var listYear = DateTime(list[i].date.split('-')[0].toInt(), list[i].date.split('-')[1].toInt(),
  //       //         list[i].date.split('-')[2].toInt())
  //       //     .year;
  //       //
  //       //
  //       //
  //
  //       var listYear = DateTime.parse('${list[i].date} 00:00:00').year;
  //
  //       if (listYear == year) {
  //         list2.add(list[i]);
  //       }
  //     }
  //
  //     state = state.copyWith(udemyList: AsyncValue.data(list));
  //   });
  // }

  // ///
  // Future<void> getYearCategoryUdemy({required int year, required String category}) async {
  //   await client.post(path: APIPath.getUdemyData).then((value) {
  //     final list = <Udemy>[];
  //
  //     for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
  //       list.add(Udemy.fromJson(value['data'][i] as Map<String, dynamic>));
  //     }
  //
  //     final list2 = <Udemy>[];
  //
  //     for (var i = 0; i < list.length; i++) {
  //       // var listYear = DateTime(list[i].date.split('-')[0].toInt(), list[i].date.split('-')[1].toInt(),
  //       //         list[i].date.split('-')[2].toInt())
  //       //     .year;
  //       //
  //       //
  //
  //       var listYear = DateTime.parse('${list[i].date} 00:00:00').year;
  //
  //       if (listYear == year) {
  //         if (list[i].category == category) {
  //           list2.add(list[i]);
  //         }
  //       }
  //     }
  //
  //     state = state.copyWith(udemyList: AsyncValue.data(list));
  //   });
  // }
}

////////////////////////////////////////////////
