// ignore_for_file: avoid_dynamic_calls, literal_only_boolean_expressions

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/spend_item_daily.dart';
import '../../models/spend_month_summary.dart';
import '../../models/spend_sameday.dart';
import '../../models/spend_sameday_yearly.dart';
import '../../models/spend_summary.dart';
import '../../models/spend_year_summary.dart';
import '../../models/spend_yearly.dart';
import '../../models/spend_yearly_item.dart';
import '../../models/zero_use_date.dart';
import '../../utility/utility.dart';
import '../spend_yearly_item/spend_yearly_item_state.dart';
import 'spend_response_state.dart';

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
final spendMonthSummaryProvider =
    StateNotifierProvider.autoDispose.family<SpendMonthSummaryNotifier, SpendResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendMonthSummaryNotifier(const SpendResponseState(), client, utility)..getSpendMonthSummary(date: date);
});

class SpendMonthSummaryNotifier extends StateNotifier<SpendResponseState> {
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

      state = state.copyWith(spendMonthSummaryList: AsyncValue.data(list));
    });

    // .catchError((error, _) {
    //   utility.showError('予期せぬエラーが発生しました');
    // });
  }
}

////////////////////////////////////////////////
////////////////////////////////////////////////
final spendItemDailyProvider =
    StateNotifierProvider.autoDispose.family<SpendItemDailyNotifier, SpendResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendItemDailyNotifier(const SpendResponseState(), client, utility)..getSpendItemDaily(date: date);
});

class SpendItemDailyNotifier extends StateNotifier<SpendResponseState> {
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
        if (DateTime(
              value['data'][i]['date'].toString().split('-')[0].toInt(),
              value['data'][i]['date'].toString().split('-')[1].toInt(),
              value['data'][i]['date'].toString().split('-')[2].toInt(),
            ).yyyymmdd ==
            date.yyyymmdd) {
          final list = <String>[];
          for (var j = 0; j < value['data'][i]['item'].length.toString().toInt(); j++) {
            list.add(value['data'][i]['item'][j].toString());
          }

          spendItemDaily = SpendItemDaily(
            date: DateTime.parse(value['data'][i]['date'].toString()),
            item: list,
          );
        }
      }

      state = state.copyWith(spendItemDaily: AsyncValue.data(spendItemDaily));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final spendMonthDetailProvider =
    StateNotifierProvider.autoDispose.family<SpendMonthDetailNotifier, SpendResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendMonthDetailNotifier(const SpendResponseState(), client, utility)..getSpendMonthDetail(date: date);
});

class SpendMonthDetailNotifier extends StateNotifier<SpendResponseState> {
  SpendMonthDetailNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSpendMonthDetail({required DateTime date}) async {
    await client.post(path: APIPath.getYearSpend, body: {'date': date.yyyymmdd}).then((value) {
      final list = <SpendYearly>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyymm ==
            DateTime(
              value['data'][i]['date'].toString().split('-')[0].toInt(),
              value['data'][i]['date'].toString().split('-')[1].toInt(),
              value['data'][i]['date'].toString().split('-')[2].toInt(),
            ).yyyymm) {
          final list2 = <SpendYearlyItem>[];

          for (var j = 0; j < value['data'][i]['item'].length.toString().toInt(); j++) {
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

      state = state.copyWith(spendYearlyList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final spendYearlyProvider =
    StateNotifierProvider.autoDispose.family<SpendYearlyNotifier, SpendResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendYearlyNotifier(const SpendResponseState(), client, utility)..getSpendYearDayData(date: date);
});

class SpendYearlyNotifier extends StateNotifier<SpendResponseState> {
  SpendYearlyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSpendYearDayData({required DateTime date}) async {
    await client.post(
      path: APIPath.getYearSpend,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SpendYearly>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyy ==
            DateTime(
              value['data'][i]['date'].toString().split('-')[0].toInt(),
              value['data'][i]['date'].toString().split('-')[1].toInt(),
              value['data'][i]['date'].toString().split('-')[2].toInt(),
            ).yyyy) {
          final list2 = <SpendYearlyItem>[];

          for (var j = 0; j < value['data'][i]['item'].length.toString().toInt(); j++) {
            list2.add(SpendYearlyItem.fromJson(value['data'][i]['item'][j] as Map<String, dynamic>));
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

      state = state.copyWith(spendYearlyList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final spendMonthUnitProvider =
    StateNotifierProvider.autoDispose.family<SpendMonthUnitNotifier, SpendResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendMonthUnitNotifier(const SpendResponseState(), client, utility)..getSpendMonthUnit(date: date);
});

class SpendMonthUnitNotifier extends StateNotifier<SpendResponseState> {
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
        if (year ==
            DateTime(
              value['data'][i]['date'].toString().split('-')[0].toInt(),
              value['data'][i]['date'].toString().split('-')[1].toInt(),
              value['data'][i]['date'].toString().split('-')[2].toInt(),
            ).yyyy) {
          final month = DateTime(
            value['data'][i]['date'].toString().split('-')[0].toInt(),
            value['data'][i]['date'].toString().split('-')[1].toInt(),
            value['data'][i]['date'].toString().split('-')[2].toInt(),
          ).mm;

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

      state = state.copyWith(spendMonthUnitMap: AsyncValue.data(map));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final spendYearlyItemProvider = StateNotifierProvider.autoDispose
    .family<SpendYearlyItemNotifier, List<SpendYearlyItemState>, SpendYearlyItemState>((ref, param) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendYearlyItemNotifier([], client, utility)..getSpendYearlyItem(param: param);
});

class SpendYearlyItemNotifier extends StateNotifier<List<SpendYearlyItemState>> {
  SpendYearlyItemNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSpendYearlyItem({required SpendYearlyItemState param}) async {
    await client.post(
      path: APIPath.getYearSpend,
      body: {'date': param.date!.yyyymmdd},
    ).then((value) {
      final list = <SpendYearlyItemState>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final date = value['data'][i]['date'].toString();
        for (var j = 0; j < value['data'][i]['item'].length.toString().toInt(); j++) {
          if (param.item == value['data'][i]['item'][j]['item'].toString()) {
            if (value['data'][i]['item'][j]['price'].toString().toInt() > 0) {
              list.add(
                SpendYearlyItemState(
                  date: DateTime(
                    date.split('-')[0].toInt(),
                    date.split('-')[1].toInt(),
                    date.split('-')[2].toInt(),
                  ),
                  item: value['data'][i]['item'][j]['item'].toString(),
                  price: value['data'][i]['item'][j]['price'].toString().toInt(),
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
final spendSummaryProvider =
    StateNotifierProvider.autoDispose.family<SpendSummaryNotifier, SpendResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendSummaryNotifier(const SpendResponseState(), client, utility)..getSpendSummary(date: date);
});

class SpendSummaryNotifier extends StateNotifier<SpendResponseState> {
  SpendSummaryNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSpendSummary({required DateTime date}) async {
    await client.post(path: APIPath.getYearSpendSummaySummary, body: {'year': date.yyyy}).then((value) {
      final list = <SpendSummary>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(SpendSummary.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = state.copyWith(spendSummaryList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final spendYearSummaryProvider =
    StateNotifierProvider.autoDispose.family<SpendYearSummaryNotifier, SpendResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendYearSummaryNotifier(const SpendResponseState(), client, utility)..getSpendSummary(date: date);
});

class SpendYearSummaryNotifier extends StateNotifier<SpendResponseState> {
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

      state = state.copyWith(spendYearSummaryList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final spendZeroUseDateProvider = StateNotifierProvider.autoDispose<SpendZeroUseDateNotifier, ZeroUseDate>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendZeroUseDateNotifier(ZeroUseDate(data: []), client, utility)..getSpendZeroUseDate();
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
final spendSamedayProvider =
    StateNotifierProvider.autoDispose.family<SpendSamedayNotifier, SpendResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendSamedayNotifier(const SpendResponseState(), client, utility)..getSamedaySpend(date: date);
});

class SpendSamedayNotifier extends StateNotifier<SpendResponseState> {
  SpendSamedayNotifier(super.state, this.client, this.utility);

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

      state = state.copyWith(spendSamedayList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final spendSamedayYearlyProvider =
    StateNotifierProvider.autoDispose.family<SpendSamedayYearlyNotifier, SpendResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return SpendSamedayYearlyNotifier(const SpendResponseState(), client, utility)..getSamedaySpendYearly(date: date);
});

class SpendSamedayYearlyNotifier extends StateNotifier<SpendResponseState> {
  SpendSamedayYearlyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getSamedaySpendYearly({required DateTime date}) async {
    await client.post(
      path: APIPath.getSameYearMonthDay,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <SpendSamedayYearly>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          SpendSamedayYearly.fromJson(value['data'][i] as Map<String, dynamic>),
        );
      }

      state = state.copyWith(spendSamedayYearlyList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
