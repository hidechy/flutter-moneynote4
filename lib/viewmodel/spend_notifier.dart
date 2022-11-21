// ignore_for_file: avoid_dynamic_calls, literal_only_boolean_expressions

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/spend_yearly.dart';
import 'package:moneynote4/models/spend_yearly_item.dart';

import '../data/http/client.dart';
import '../models/spend_item_daily.dart';
import '../models/spend_month_summary.dart';

////////////////////////////////////////////////

final spendMonthSummaryProvider = StateNotifierProvider.autoDispose
    .family<SpendMonthSummaryNotifier, List<SpendMonthSummary>, String>(
        (ref, date) {
  final client = ref.read(httpClientProvider);

  return SpendMonthSummaryNotifier(
    [],
    client,
  )..getSpendMonthSummary(date: date);
});

class SpendMonthSummaryNotifier extends StateNotifier<List<SpendMonthSummary>> {
  SpendMonthSummaryNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getSpendMonthSummary({required String date}) async {
    await client.post(
      path: 'monthsummary',
      body: {'date': date},
    ).then((value) {
      final list = <SpendMonthSummary>[];

      for (var i = 0; i < int.parse(value['data'].length.toString()); i++) {
        list.add(
          SpendMonthSummary(
            item: value['data'][i]['item'].toString(),
            sum: int.parse(value['data'][i]['sum'].toString()),
            percent: int.parse(value['data'][i]['percent'].toString()),
          ),
        );
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final spendItemDailyProvider = StateNotifierProvider.autoDispose
    .family<SpendItemDailyNotifier, SpendItemDaily, String>((ref, date) {
  final client = ref.read(httpClientProvider);

  return SpendItemDailyNotifier(
    SpendItemDaily(
      date: DateTime.now(),
      item: [],
    ),
    client,
  )..getSpendItemDaily(date: date);
});

class SpendItemDailyNotifier extends StateNotifier<SpendItemDaily> {
  SpendItemDailyNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getSpendItemDaily({required String date}) async {
    await client.post(
      path: 'getmonthSpendItem',
      body: {'date': date},
    ).then((value) {
      var spendItemDaily = SpendItemDaily(
        date: DateTime.now(),
        item: [],
      );

      for (var i = 0; i < int.parse(value['data'].length.toString()); i++) {
        if (value['data'][i]['date'] == date) {
          final list = <String>[];
          for (var j = 0;
              j < int.parse(value['data'][i]['item'].length.toString());
              j++) {
            list.add(value['data'][i]['item'][j].toString());
          }

          spendItemDaily = SpendItemDaily(
            date: DateTime.parse(value['data'][i]['date'].toString()),
            item: list,
          );
        }
      }

      state = spendItemDaily;
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final spendMonthDetailProvider = StateNotifierProvider.autoDispose
    .family<SpendMonthDetailNotifier, List<SpendYearly>, String>((ref, date) {
  final client = ref.read(httpClientProvider);

  return SpendMonthDetailNotifier(
    [],
    client,
  )..getSpendMonthDetail(date: date);
});

class SpendMonthDetailNotifier extends StateNotifier<List<SpendYearly>> {
  SpendMonthDetailNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getSpendMonthDetail({required String date}) async {
    await client.post(
      path: 'getYearSpend',
      body: {'date': date},
    ).then((value) {
      final list = <SpendYearly>[];

      final exDate = date.split('-');

      for (var i = 0; i < int.parse(value['data'].length.toString()); i++) {
        final exOneDate = value['data'][i]['date'].toString().split('-');
        if ('${exDate[0]}-${exDate[1]}' == '${exOneDate[0]}-${exOneDate[1]}') {
          final list2 = <SpendYearlyItem>[];

          for (var j = 0;
              j < int.parse(value['data'][i]['item'].length.toString());
              j++) {
            list2.add(
              SpendYearlyItem(
                item: value['data'][i]['item'][j]['item'].toString(),
                price:
                    int.parse(value['data'][i]['item'][j]['price'].toString()),
                flag: int.parse(value['data'][i]['item'][j]['flag'].toString()),
              ),
            );
          }

          list.add(
            SpendYearly(
              date: DateTime.parse(value['data'][i]['date'].toString()),
              spend: int.parse(value['data'][i]['spend'].toString()),
              item: list2,
            ),
          );
        }
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////
