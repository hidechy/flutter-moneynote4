// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/spend/spend_notifier.dart';
import '../../utility/utility.dart';

class SpendFullyearCompareAlert extends ConsumerWidget {
  SpendFullyearCompareAlert({
    super.key,
    required this.date,
    required this.spend,
    required this.thisYearDataLength,
  });

  final DateTime date;
  final int spend;
  final int thisYearDataLength;

  final Utility _utility = Utility();

  Map<int, int> fullyearCompareMap = {};

  int daydiff = 0;
  int thisYearAverage = 0;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    daydiff = DateTime(date.year + 1).difference(DateTime(date.year)).inDays;

    makeFullyearCompareMap();

    thisYearAverage = (spend / thisYearDataLength).round().toString().split('.')[0].toInt();

    fullyearCompareMap[date.year] = thisYearAverage * daydiff;

    final deviceInfoState = ref.read(deviceInfoProvider);

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(width: context.screenSize.width),

            //----------//
            if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
            //----------//

            Expanded(child: displayFullyearCompare()),

            _displayCircularGraph(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  ///
  void makeFullyearCompareMap() {
    fullyearCompareMap = {};

    for (var i = 2020; i < date.year; i++) {
      var yearSum = 0;

      final spendYearSummaryList =
          _ref.watch(spendYearSummaryProvider(DateTime(i)).select((value) => value.spendYearSummaryList));

      spendYearSummaryList.value?.forEach((element) {
        if (element.sum > 0) {
          yearSum += element.sum;
        }
      });

      //
      //
      // final spendYearSummaryState = _ref.watch(spendYearSummaryProvider(DateTime(i)));
      //
      // spendYearSummaryState.forEach((element) {
      //   if (element.sum > 0) {
      //     yearSum += element.sum;
      //   }
      // });
      //
      //
      //

      fullyearCompareMap[i] = yearSum;
    }
  }

  ///
  Widget displayFullyearCompare() {
    final bunboYear = _getBunboYear();

    final list = <Widget>[];

    fullyearCompareMap.entries.forEach(
      (element) {
        list.add(
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              color: (element.key == date.year) ? Colors.yellowAccent.withOpacity(0.1) : Colors.transparent,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(element.key.toString()),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(element.value.toString().toCurrency()),
                            if (element.key != date.year) ...[
                              Text(
                                (element.value > spend) ? (element.value - spend).toString().toCurrency() : 'over',
                                style: const TextStyle(color: Color(0xFFFBB6CE)),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(width: 10),
                        (element.key == bunboYear)
                            ? const Icon(Icons.star, color: Colors.yellowAccent, size: 10)
                            : const Icon(Icons.check_box_outline_blank, color: Colors.transparent, size: 10),
                      ],
                    ),
                  ],
                ),
                if (element.key == date.year)
                  Row(
                    children: [
                      const SizedBox(width: 40),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(DateTime.now().yyyymmdd)),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: Text(spend.toString().toCurrency()),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: Text('$thisYearDataLength / $daydiff'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Text(thisYearAverage.toString().toCurrency()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );

    return SingleChildScrollView(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: Column(children: list),
      ),
    );
  }

  ///
  int _getBunboYear() {
    final nums = <int>[];
    fullyearCompareMap.entries.forEach((element) {
      nums.add(element.value);
    });

    final maxValue = nums.reduce(max);

    var year = DateTime.now().year;

    fullyearCompareMap.entries.forEach((element) {
      if (element.value == maxValue) {
        year = element.key;
      }
    });

    return (year != DateTime.now().year) ? year : 0;
  }

  ///
  Widget _displayCircularGraph() {
    final bunboYear = _getBunboYear();
    final bunbo = (bunboYear > 0) ? fullyearCompareMap[bunboYear]! : 0;

    final bunshi = fullyearCompareMap[DateTime.now().year]!;

    if (bunbo != 0) {
      return SizedBox(
        height: 300,
        child: PieChart(
          PieChartData(
            startDegreeOffset: 270,
            sections: [
              PieChartSectionData(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.6)),
                color: Colors.yellowAccent.withOpacity(0.2),
                value: 100,
                title: '${DateTime.now().year} 消費金額比率\n${bunshi / bunbo}\n${bunshi.toString().toCurrency()}',
                radius: 140,
                titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              PieChartSectionData(
                color: Colors.grey.withOpacity(0.2),
                value: (bunshi / bunbo).roundToDouble(),
                title: (bunbo - bunshi).toString().toCurrency(),
                radius: 140,
                titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    return Container();
  }
}
