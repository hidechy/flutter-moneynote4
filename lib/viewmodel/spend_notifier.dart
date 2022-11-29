// ignore_for_file: avoid_dynamic_calls, literal_only_boolean_expressions

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../extensions/extensions.dart';
import '../models/spend_item_daily.dart';
import '../models/spend_month_summary.dart';
import '../models/spend_summary.dart';
import '../models/spend_summary_record.dart';
import '../models/spend_yearly.dart';
import '../models/spend_yearly_item.dart';

////////////////////////////////////////////////

final spendMonthSummaryProvider = StateNotifierProvider.autoDispose
    .family<SpendMonthSummaryNotifier, List<SpendMonthSummary>, DateTime>(
        (ref, date) {
  final client = ref.read(httpClientProvider);

  return SpendMonthSummaryNotifier([], client)
    ..getSpendMonthSummary(date: date);
});

class SpendMonthSummaryNotifier extends StateNotifier<List<SpendMonthSummary>> {
  SpendMonthSummaryNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getSpendMonthSummary({required DateTime date}) async {
    await client.post(
      path: 'monthsummary',
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SpendMonthSummary>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
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
    .family<SpendItemDailyNotifier, SpendItemDaily, DateTime>((ref, date) {
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

  Future<void> getSpendItemDaily({required DateTime date}) async {
    await client.post(
      path: 'getmonthSpendItem',
      body: {'date': date.yyyymmdd},
    ).then((value) {
      var spendItemDaily = SpendItemDaily(
        date: DateTime.now(),
        item: [],
      );

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if ('${value['data'][i]['date']} 00:00:00'.toDateTime().yyyymmdd ==
            date.yyyymmdd) {
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
    .family<SpendMonthDetailNotifier, List<SpendYearly>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  return SpendMonthDetailNotifier([], client)..getSpendMonthDetail(date: date);
});

class SpendMonthDetailNotifier extends StateNotifier<List<SpendYearly>> {
  SpendMonthDetailNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getSpendMonthDetail({required DateTime date}) async {
    await client.post(
      path: 'getYearSpend',
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SpendYearly>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyymm ==
            '${value['data'][i]['date']} 00:00:00'.toDateTime().yyyymm) {
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

////////////////////////////////////////////////

final spendSummaryProvider = StateNotifierProvider.autoDispose
    .family<SpendSummaryNotifier, List<SpendSummary>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  return SpendSummaryNotifier([], client)..getSpendSummary(date: date);
});

class SpendSummaryNotifier extends StateNotifier<List<SpendSummary>> {
  SpendSummaryNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getSpendSummary({required DateTime date}) async {
    final year = date.yyyy;

    await client.post(
      path: 'getYearSpendSummaySummary',
      body: {'year': year},
    ).then((value) {
      final list = <SpendSummary>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final list2 = <SpendSummaryRecord>[];
        for (var j = 0;
            j < value['data'][i]['list'].length.toString().toInt();
            j++) {
          list2.add(
            SpendSummaryRecord(
              month: value['data'][i]['list'][j]['month'].toString(),
              price: value['data'][i]['list'][j]['price'].toString().toInt(),
            ),
          );
        }

        list.add(
          SpendSummary(
            item: value['data'][i]['item'].toString(),
            list: list2,
          ),
        );
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////
