// ignore_for_file: avoid_dynamic_calls, literal_only_boolean_expressions

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/spend_item_daily.dart';
import '../models/spend_month_summary.dart';
import '../models/spend_sameday.dart';
import '../models/spend_summary.dart';
import '../models/spend_year_summary.dart';
import '../models/spend_yearly.dart';
import '../models/spend_yearly_item.dart';
import '../models/zero_use_date.dart';
import '../state/monthly_spend/monthly_spend_state.dart';
import '../state/spend_summary/spend_summary_state.dart';
import '../state/spend_yearly_item/spend_yearly_item_state.dart';
import '../utility/utility.dart';

/*
spendMonthSummaryProvider       List<SpendMonthSummary>
spendItemDailyProvider        SpendItemDaily
spendMonthDetailProvider        List<SpendYearly>
spendMonthUnitProvider        Map<String, int>
spendYearlyItemProvider       List<SpendYearlyItemState>
spendSummaryProvider        SpendSummaryState // saving
spendYearSummaryProvider        List<SpendYearSummary>
spendZeroUseDateProvider        ZeroUseDate
samedaySpendProvider        List<SpendSameday>
*/

////////////////////////////////////////////////
final spendMonthSummaryProvider = StateNotifierProvider.autoDispose
    .family<SpendMonthSummaryNotifier, List<SpendMonthSummary>, DateTime>(
        (ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendMonthSummaryNotifier([], client, utility)
    ..getSpendMonthSummary(date: date);
});

class SpendMonthSummaryNotifier extends StateNotifier<List<SpendMonthSummary>> {
  SpendMonthSummaryNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSpendMonthSummary({required DateTime date}) async {
    await client.post(
      path: APIPath.monthsummary,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SpendMonthSummary>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          SpendMonthSummary.fromJson(value['data'][i] as Map<String, dynamic>),
        );
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
////////////////////////////////////////////////
final spendItemDailyProvider = StateNotifierProvider.autoDispose
    .family<SpendItemDailyNotifier, SpendItemDaily, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendItemDailyNotifier(
    SpendItemDaily(
      date: DateTime.now(),
      item: [],
    ),
    client,
    utility,
  )..getSpendItemDaily(date: date);
});

class SpendItemDailyNotifier extends StateNotifier<SpendItemDaily> {
  SpendItemDailyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSpendItemDaily({required DateTime date}) async {
    await client.post(
      path: APIPath.getmonthSpendItem,
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
              j < value['data'][i]['item'].length.toString().toInt();
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
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final spendMonthDetailProvider = StateNotifierProvider.autoDispose
    .family<SpendMonthDetailNotifier, MonthlySpendState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendMonthDetailNotifier(const MonthlySpendState(), client, utility)
    ..getSpendMonthDetail(date: date);
});

class SpendMonthDetailNotifier extends StateNotifier<MonthlySpendState> {
  SpendMonthDetailNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSpendMonthDetail({required DateTime date}) async {
    await client.post(
      path: APIPath.getYearSpend,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      state = state.copyWith(saving: true);

      final list = <SpendYearly>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyymm ==
            '${value['data'][i]['date']} 00:00:00'.toDateTime().yyyymm) {
          final list2 = <SpendYearlyItem>[];

          for (var j = 0;
              j < value['data'][i]['item'].length.toString().toInt();
              j++) {
            list2.add(
              SpendYearlyItem(
                item: value['data'][i]['item'][j]['item'].toString(),
                price: value['data'][i]['item'][j]['price'].toString().toInt(),
                flag: value['data'][i]['item'][j]['flag'].toString().toInt(),
              ),
            );
          }

          list.add(
            SpendYearly(
              date: DateTime.parse(value['data'][i]['date'].toString()),
              spend: value['data'][i]['spend'].toString().toInt(),
              item: list2,
            ),
          );
        }
      }

      state = state.copyWith(saving: false);

      state = state.copyWith(list: list);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final spendMonthUnitProvider = StateNotifierProvider.autoDispose
    .family<SpendMonthUnitNotifier, Map<String, int>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendMonthUnitNotifier({}, client, utility)
    ..getSpendMonthUnit(date: date);
});

class SpendMonthUnitNotifier extends StateNotifier<Map<String, int>> {
  SpendMonthUnitNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSpendMonthUnit({required DateTime date}) async {
    await client.post(
      path: APIPath.getYearSpend,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final year = date.yyyy;

      final map = <String, int>{};

      final map2 = <int, List<int>>{};

      for (var i = 1; i <= 12; i++) {
        map2[i] = [];
      }

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (year == '${value['data'][i]['date']} 00:00:00'.toDateTime().yyyy) {
          final month = '${value['data'][i]['date']} 00:00:00'.toDateTime().mm;
          map2[month.toInt()]?.add(
            value['data'][i]['spend'].toString().toInt(),
          );
        }
      }

      for (var i = 1; i <= 12; i++) {
        var sum = 0;
        map2[i]!.forEach((element) {
          sum += element;
          map['$year-${i.toString().padLeft(2, '0')}'] = sum;
        });
      }

      state = map;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final spendYearlyItemProvider = StateNotifierProvider.autoDispose.family<
    SpendYearlyItemNotifier,
    List<SpendYearlyItemState>,
    SpendYearlyItemState>((ref, param) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendYearlyItemNotifier([], client, utility)
    ..getSpendYearlyItem(param: param);
});

class SpendYearlyItemNotifier
    extends StateNotifier<List<SpendYearlyItemState>> {
  SpendYearlyItemNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSpendYearlyItem({required SpendYearlyItemState param}) async {
    await client.post(
      path: APIPath.getYearSpend,
      body: {'date': param.date.yyyymmdd},
    ).then((value) {
      final list = <SpendYearlyItemState>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final date = value['data'][i]['date'].toString();
        for (var j = 0;
            j < value['data'][i]['item'].length.toString().toInt();
            j++) {
          if (param.item == value['data'][i]['item'][j]['item'].toString()) {
            if (value['data'][i]['item'][j]['price'].toString().toInt() > 0) {
              list.add(
                SpendYearlyItemState(
                  date: '$date 00:00:00'.toDateTime(),
                  item: value['data'][i]['item'][j]['item'].toString(),
                  price:
                      value['data'][i]['item'][j]['price'].toString().toInt(),
                ),
              );
            }
          }
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
final spendSummaryProvider = StateNotifierProvider.autoDispose
    .family<SpendSummaryNotifier, SpendSummaryState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendSummaryNotifier(const SpendSummaryState(), client, utility)
    ..getSpendSummary(date: date);
});

class SpendSummaryNotifier extends StateNotifier<SpendSummaryState> {
  SpendSummaryNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSpendSummary({required DateTime date}) async {
    state = state.copyWith(saving: true);

    final year = date.yyyy;

    await client.post(
      path: APIPath.getYearSpendSummaySummary,
      body: {'year': year},
    ).then((value) {
      final list = <SpendSummary>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          SpendSummary.fromJson(value['data'][i] as Map<String, dynamic>),
        );
      }

      state = state.copyWith(saving: false);

      state = state.copyWith(list: list);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final spendYearSummaryProvider = StateNotifierProvider.autoDispose
    .family<SpendYearSummaryNotifier, List<SpendYearSummary>, DateTime>(
        (ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendYearSummaryNotifier([], client, utility)
    ..getSpendSummary(date: date);
});

class SpendYearSummaryNotifier extends StateNotifier<List<SpendYearSummary>> {
  SpendYearSummaryNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSpendSummary({required DateTime date}) async {
    await client.post(
      path: APIPath.yearsummary,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SpendYearSummary>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          SpendYearSummary.fromJson(value['data'][i] as Map<String, dynamic>),
        );
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final spendZeroUseDateProvider =
    StateNotifierProvider.autoDispose<SpendZeroUseDateNotifier, ZeroUseDate>(
        (ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendZeroUseDateNotifier(ZeroUseDate(data: []), client, utility)
    ..getSpendZeroUseDate();
});

class SpendZeroUseDateNotifier extends StateNotifier<ZeroUseDate> {
  SpendZeroUseDateNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSpendZeroUseDate() async {
    await client.post(path: APIPath.timeplacezerousedate).then((value) {
      final list = <DateTime>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(DateTime.parse(value['data'][i].toString()));
      }

      state = ZeroUseDate(data: list);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final samedaySpendProvider = StateNotifierProvider.autoDispose
    .family<SamedaySpendNotifier, List<SpendSameday>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SamedaySpendNotifier([], client, utility)..getSamedaySpend(date: date);
});

class SamedaySpendNotifier extends StateNotifier<List<SpendSameday>> {
  SamedaySpendNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSamedaySpend({required DateTime date}) async {
    await client.post(
      path: APIPath.getSamedaySpend,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SpendSameday>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          SpendSameday(
            ym: value['data'][i]['ym'].toString(),
            sum: value['data'][i]['sum'].toString().toInt(),
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
