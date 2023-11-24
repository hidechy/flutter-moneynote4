// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/spend/spend_notifier.dart';
import '../../utility/utility.dart';
import '_money_dialog.dart';
import 'pages/monthly_spend_page.dart';

class ThreeYearsSpendMonthCompareAlert extends ConsumerWidget {
  ThreeYearsSpendMonthCompareAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Map<String, int> yearMonthCompareMap = {};

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    _makeYearMonthCompareMap();

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
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Expanded(
                child: _displayCompare(),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void _makeYearMonthCompareMap() {
    for (var i = DateTime.now().year - 2; i <= DateTime.now().year; i++) {
      final map = <String, List<int>>{};

      final spendYearlyList = _ref.watch(spendYearlyProvider(DateTime(i)).select((value) => value.spendYearlyList));

      spendYearlyList.value?.forEach((element) {
        map[element.date.yyyymm] = [];
      });

      spendYearlyList.value?.forEach((element) {
        map[element.date.yyyymm]?.add(element.spend);
      });

      //
      //
      // final spendYearDayState = _ref.watch(spendYearlyProvider(DateTime(i)));
      //
      // spendYearDayState
      //   ..forEach((element) {
      //     map[element.date.yyyymm] = [];
      //   })
      //   ..forEach((element) {
      //     map[element.date.yyyymm]?.add(element.spend);
      //   });
      //
      //
      //

      map.entries.forEach((element) {
        var sum = 0;
        element.value.forEach((element2) {
          sum += element2;
        });

        yearMonthCompareMap[element.key] = sum;
      });
    }
  }

  ///
  Widget _displayCompare() {
    final list = <Widget>[];

    for (var i = date.year; i > date.year - 3; i--) {
      var sum = 0;

      final spendYearlyList = _ref.watch(spendYearlyProvider(DateTime(i)).select((value) => value.spendYearlyList));

      spendYearlyList.value?.forEach((element) {
        sum += element.spend;
      });

      //
      //
      // final spendYearDayState = _ref.watch(spendYearlyProvider(DateTime(i)));
      //
      // spendYearDayState.forEach((element) {
      //   sum += element.spend;
      // });
      //
      //
      //

      list.add(
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.yellowAccent.withOpacity(0.1)),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(i.toString()),
                      const SizedBox(height: 10),
                      Text(sum.toString().toCurrency()),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
                Expanded(child: _getColumn(year: i)),
              ],
            ),
          ),
        ),
      );
    }

    return Row(children: list);
  }

  ///
  Widget _getColumn({required int year}) {
    final list = <Widget>[];

    final map = <String, List<int>>{};

    final spendYearlyList = _ref.watch(spendYearlyProvider(DateTime(year)).select((value) => value.spendYearlyList));

    spendYearlyList.value?.forEach((element) {
      map[element.date.yyyymm] = [];
    });

    spendYearlyList.value?.forEach((element) {
      map[element.date.yyyymm]?.add(element.spend);
    });

    //
    //
    // final spendYearDayState = _ref.watch(spendYearlyProvider(DateTime(year)));
    //
    // spendYearDayState
    //   ..forEach((element) {
    //     map[element.date.yyyymm] = [];
    //   })
    //   ..forEach((element) {
    //     map[element.date.yyyymm]?.add(element.spend);
    //   });
    //
    //

    final map2 = <String, int>{};
    map.entries.forEach((element) {
      var sum = 0;
      element.value.forEach((element2) {
        sum += element2;
      });

      map2[element.key] = sum;
    });

    map2.entries.forEach((element) {
      final exElementKey = element.key.split('-');
      final compareYm = DateTime(year - 1, exElementKey[1].toInt()).yyyymm;

      list
        ..add(
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _utility.getLeadingBgColor(month: DateTime(year, element.key.split('-')[1].toInt()).mm),
                  Colors.transparent
                ],
                stops: const [0.7, 1],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(element.key),
                GestureDetector(
                  onTap: () {
                    MoneyDialog(
                        context: _context,
                        widget: MonthlySpendPage(
                          date: DateTime(element.key.split('-')[0].toInt(), element.key.split('-')[1].toInt()),
                        ));
                  },
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        )
        ..add(const SizedBox(height: 10))
        ..add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (year == DateTime.now().year - 2)
                  ? Container()
                  : _displayYearMonthCompareMark(
                      diff: (element.value - yearMonthCompareMap[compareYm].toString().toInt()),
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    element.value.toString().toCurrency(),
                    style: TextStyle(
                      color: (DateTime.now().yyyymm == element.key)
                          ? Colors.yellowAccent
                          : (element.value > 500000)
                              ? Colors.orangeAccent
                              : Colors.white,
                    ),
                  ),
                  Text(
                    (year == DateTime.now().year - 2)
                        ? ''
                        : (element.value - yearMonthCompareMap[compareYm].toString().toInt()).toString(),
                    style: const TextStyle(color: Colors.yellowAccent),
                  ),
                ],
              ),
            ],
          ),
        )
        ..add(const SizedBox(height: 10));
    });

    return SingleChildScrollView(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: Column(children: list),
      ),
    );
  }

  ///
  Widget _displayYearMonthCompareMark({required int diff}) {
    if (diff < 0) {
      return const Icon(Icons.arrow_downward, color: Colors.greenAccent);
    } else {
      return const Icon(Icons.arrow_upward, color: Colors.redAccent);
    }
  }
}
