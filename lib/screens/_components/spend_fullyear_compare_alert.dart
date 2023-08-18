// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';

import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/spend_notifier.dart';

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

    thisYearAverage = (spend / thisYearDataLength).toString().split('.')[0].toInt();

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
          ],
        ),
      ),
    );
  }

  ///
  void makeFullyearCompareMap() {
    fullyearCompareMap = {};

    for (var i = 2020; i < date.year; i++) {
      final spendYearSummaryState = _ref.watch(spendYearSummaryProvider(DateTime(i)));

      var yearSum = 0;

      spendYearSummaryState.forEach((element) {
        if (element.sum > 0) {
          yearSum += element.sum;
        }
      });

      fullyearCompareMap[i] = yearSum;
    }
  }

  ///
  Widget displayFullyearCompare() {
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
                  children: [
                    Text(element.key.toString()),
                    Text(element.value.toString().toCurrency()),
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
}
