// ignore_for_file: must_be_immutable, use_decorated_box

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/spend_month_summary.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/spend_notifier.dart';

class SpendHalfyearSummaryAlert extends ConsumerWidget {
  SpendHalfyearSummaryAlert({super.key, required this.date});

  final DateTime date;

  List<DateTime> ymList = [];

  Map<String, List<SpendMonthSummary>> dataMap = {};

  Map<String, int> sumMap = {};

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeHalfyearSpendData();

    final deviceInfoState = ref.read(deviceInfoProvider);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: context.screenSize.width * 4,
          height: context.screenSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone')
                _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              displaySpendHalfyearSummaryData(),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void makeHalfyearSpendData() {
    //---------------------------------------(1)
    ymList = [];

    var flag = 1;
    if (date.year == 2020) {
      flag = (date.month < 6) ? 0 : 1;
    }

    switch (flag) {
      case 0:
        for (var i = 6; i >= 1; i--) {
          ymList.add(DateTime(date.yyyy.toInt(), i));
        }
        break;
      case 1:
        for (var i = 0; i < 6; i++) {
          ymList.add(DateTime(date.yyyy.toInt(), date.mm.toInt() - i));
        }
        break;
    }
    //---------------------------------------(1)

    ymList.forEach((element) {
      final spendMonthSummaryState =
          _ref.watch(spendMonthSummaryProvider(element));

      dataMap[element.yyyymm] = spendMonthSummaryState;

      var sum = 0;
      spendMonthSummaryState.forEach((element2) {
        sum += element2.sum;
      });

      sumMap[element.yyyymm] = sum;
    });
  }

  ///
  Widget displaySpendHalfyearSummaryData() {
    final list = <Widget>[];

    dataMap.entries.forEach((element) {
      list.add(
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(element.key),
                      Text(sumMap[element.key].toString().toCurrency()),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: element.value.map((e) {
                    final textColor =
                        (e.sum >= 10000) ? Colors.yellowAccent : Colors.white;

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: textColor,
                          fontSize: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.item),
                            Text(e.sum.toString().toCurrency()),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    });

    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }
}
