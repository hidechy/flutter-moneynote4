import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../viewmodel/spend_notifier.dart';

class SamedaySpendGraphAlert extends ConsumerWidget {
  SamedaySpendGraphAlert({super.key, required this.date});

  final DateTime date;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeComparisonMap();

    return Container();
  }

  ///
  void makeComparisonMap() {
    final list = <String>[];

    var flag = 1;
    if (date.year == 2020) {
      flag = (date.month < 6) ? 0 : 1;
    }

    switch (flag) {
      case 0:
        for (var i = 6; i >= 1; i--) {
          list.add(DateTime(date.yyyy.toInt(), i).yyyymm);
        }
        break;
      case 1:
        for (var i = 0; i < 6; i++) {
          list.add(DateTime(date.yyyy.toInt(), date.mm.toInt() - i).yyyymm);
        }
        break;
    }

    /*
    print(list);

    flutter: [2020-06, 2020-05, 2020-04, 2020-03, 2020-02, 2020-01]
    flutter: [2020-06, 2020-05, 2020-04, 2020-03, 2020-02, 2020-01]
    flutter: [2020-06, 2020-05, 2020-04, 2020-03, 2020-02, 2020-01]
    flutter: [2020-06, 2020-05, 2020-04, 2020-03, 2020-02, 2020-01]
    flutter: [2020-06, 2020-05, 2020-04, 2020-03, 2020-02, 2020-01]
    flutter: [2020-06, 2020-05, 2020-04, 2020-03, 2020-02, 2020-01]
    flutter: [2020-07, 2020-06, 2020-05, 2020-04, 2020-03, 2020-02]
    */

    var yearDates = [date, DateTime(date.year - 1)];

    print(yearDates);

    final spendMonthDetailState = _ref.watch(spendMonthDetailProvider(date));

    /*


      SpendYearly({
    required this.date,
    required this.spend,
//    required this.item,
  });


    */
  }
}
