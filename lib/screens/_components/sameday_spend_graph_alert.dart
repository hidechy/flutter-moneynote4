// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../viewmodel/spend_notifier.dart';

class SamedaySpendGraphAlert extends ConsumerWidget {
  SamedaySpendGraphAlert({super.key, required this.date});

  final DateTime date;

  LineChartData data = LineChartData();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    setChartData();

    return Container();
  }

  ///
  void setChartData() {
    //---------------------------------------(1)
    final list = <DateTime>[];

    var flag = 1;
    if (date.year == 2020) {
      flag = (date.month < 6) ? 0 : 1;
    }

    switch (flag) {
      case 0:
        for (var i = 6; i >= 1; i--) {
          list.add(DateTime(date.yyyy.toInt(), i));
        }
        break;
      case 1:
        for (var i = 0; i < 6; i++) {
          list.add(DateTime(date.yyyy.toInt(), date.mm.toInt() - i));
        }
        break;
    }
    //---------------------------------------(1)

    //---------------------------------------(2)
    final graphData = <String, List<Map<String, dynamic>>>{};

    list.forEach((element) {
      final spendMonthDetailState =
          _ref.watch(spendMonthDetailProvider(element));

      final list2 = <Map<String, int>>[];

      var sum = 0;

      spendMonthDetailState.list.forEach((element2) {
        sum += element2.spend;

        list2.add({'day': element2.date.day, 'sum': sum});
      });

      graphData[element.yyyymm] = list2;
    });

    print(graphData);
    //---------------------------------------(2)
  }
}
