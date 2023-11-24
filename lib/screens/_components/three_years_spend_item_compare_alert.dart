// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/spend/spend_notifier.dart';
import '../../utility/utility.dart';

class ThreeYearsSpendItemCompareAlert extends ConsumerWidget {
  ThreeYearsSpendItemCompareAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  int daydiff = 0;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final firstDate = DateTime(DateTime.now().year);

    daydiff = DateTime.now().difference(firstDate).inDays;

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
  Widget _displayCompare() {
    final list = <Widget>[];

    for (var i = date.year; i > date.year - 3; i--) {
      var sum = 0;

      final spendYearSummaryList =
          _ref.watch(spendYearSummaryProvider(DateTime(i)).select((value) => value.spendYearSummaryList));

      spendYearSummaryList.value?.forEach((element) {
        sum += element.sum;
      });

      //
      //
      // final spendYearSummaryState = _ref.watch(spendYearSummaryProvider(DateTime(i)));
      //
      // spendYearSummaryState.forEach((element) {
      //   sum += element.sum;
      // });
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
                      Text(
                        (i == DateTime.now().year)
                            ? ''
                            : ((sum / 365) * daydiff).round().toString().split('.')[0].toCurrency(),
                        style: TextStyle(color: (i == DateTime.now().year) ? Colors.white : Colors.orangeAccent),
                      ),
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

    final map = <String, int>{};

    final spendYearSummaryList =
        _ref.watch(spendYearSummaryProvider(DateTime(year)).select((value) => value.spendYearSummaryList));

    spendYearSummaryList.value?.forEach((element) {
      map[element.item] = element.sum;
    });

    //
    //
    // final spendYearSummaryState = _ref.watch(spendYearSummaryProvider(DateTime(year)));
    //
    // spendYearSummaryState.forEach((element) {
    //   map[element.item] = element.sum;
    // });
    //
    //

    final fixPaymentValue = _utility.getFixPaymentValue();

    var i = 0;
    fixPaymentValue.entries.forEach(
      (element) {
        list.add(
          Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_utility.getLeadingBgColor(month: i.toString()), Colors.transparent],
                    stops: const [0.7, 1],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(element.key),
                    Container(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    (map[element.key] != null) ? map[element.key].toString().toCurrency() : '0',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(
                    (map[element.key] != null)
                        ? (year == DateTime.now().year)
                            ? ''
                            : ((map[element.key].toString().toInt() / 365) * daydiff)
                                .toString()
                                .split('.')[0]
                                .toCurrency()
                        : (year == DateTime.now().year)
                            ? ''
                            : '0',
                    style: TextStyle(
                      color: (year == DateTime.now().year) ? Colors.white : Colors.orangeAccent,
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
            ],
          ),
        );

        i++;
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
