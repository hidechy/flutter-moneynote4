// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/spend/spend_notifier.dart';
import '../../../utility/utility.dart';
import '../_money_dialog.dart';
import '../credit_yearly_detail_alert.dart';
import '../spend_yearly_item_alert.dart';
import '../three_years_spend_item_compare_alert.dart';
import '../three_years_spend_month_compare_alert.dart';

class SpendYearlyPage extends ConsumerWidget {
  SpendYearlyPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          MoneyDialog(
                            context: context,
                            widget: ThreeYearsSpendMonthCompareAlert(date: date),
                          );
                        },
                        child: Icon(
                          Icons.list,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          MoneyDialog(
                            context: context,
                            widget: ThreeYearsSpendItemCompareAlert(date: date),
                          );
                        },
                        child: Icon(
                          Icons.pages,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Expanded(
                child: displaySpendYearly(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displaySpendYearly() {
    final list = <Widget>[];

    var yearSum = 0;
    var yearPercent = 0.0;

    var zeikin = 0;
    final zei = ['所得税', '住民税', '年金', '国民年金基金', '国民健康保険'];

    _ref.watch(spendYearSummaryProvider(date).select((value) => value.spendYearSummaryList)).when(
          data: (value) {
            for (var i = 0; i < value.length; i++) {
              var percent = '';
              if (value[i].sum > 0) {
                percent = '${value[i].percent} %';

                yearPercent += double.parse(value[i].percent);
              }

              yearSum += value[i].sum;

              if (zei.contains(value[i].item)) {
                zeikin += value[i].sum;
              }

              list.add(
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            getTrailing(item: value[i].item),
                            Text(value[i].item),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(value[i].sum.toString().toCurrency()),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(percent),
                              const SizedBox(width: 20),
                              getLinkIcon(item: value[i].item),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

              if (value[i].item == zei[zei.length - 1]) {
                list.add(
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                      color: Colors.lightBlueAccent.withOpacity(0.2),
                    ),
                    alignment: Alignment.topRight,
                    child: Text(zeikin.toString().toCurrency()),
                  ),
                );
              }
            }
          },
          error: (error, stackTrace) => Container(),
          loading: Container.new,
        );

    /*


    final spendYearSummaryState = _ref.watch(spendYearSummaryProvider(date));

    for (var i = 0; i < spendYearSummaryState.length; i++) {
      var percent = '';
      if (spendYearSummaryState[i].sum > 0) {
        percent = '${spendYearSummaryState[i].percent} %';

        yearPercent += double.parse(spendYearSummaryState[i].percent);
      }

      yearSum += spendYearSummaryState[i].sum;

      if (zei.contains(spendYearSummaryState[i].item)) {
        zeikin += spendYearSummaryState[i].sum;
      }

      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    getTrailing(item: spendYearSummaryState[i].item),
                    Text(spendYearSummaryState[i].item),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        spendYearSummaryState[i].sum.toString().toCurrency(),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(percent),
                      const SizedBox(width: 20),
                      getLinkIcon(item: spendYearSummaryState[i].item),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      if (spendYearSummaryState[i].item == zei[zei.length - 1]) {
        list.add(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              color: Colors.lightBlueAccent.withOpacity(0.2),
            ),
            alignment: Alignment.topRight,
            child: Text(zeikin.toString().toCurrency()),
          ),
        );
      }
    }




    */

    list.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          color: Colors.yellowAccent.withOpacity(0.2),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Text(''),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(yearSum.toString().toCurrency()),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Text('${yearPercent.toInt()} %'),
              ),
            ),
          ],
        ),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }

  ///
  Widget getLinkIcon({required String item}) {
    switch (item) {
      case 'credit':
        return GestureDetector(
          onTap: () {
            MoneyDialog(
              context: _context,
              widget: CreditYearlyDetailAlert(date: date),
            );
          },
          child: Icon(
            Icons.credit_card,
            color: Colors.white.withOpacity(0.6),
          ),
        );
      default:
        return GestureDetector(
          onTap: () {
            MoneyDialog(
              context: _context,
              widget: SpendYearlyItemAlert(date: date, item: item),
            );
          },
          child: Icon(
            Icons.info_outline,
            color: Colors.white.withOpacity(0.6),
          ),
        );
    }
  }

  ///
  Widget getTrailing({required String item}) {
    switch (item) {
      case '所得税':
        return const Text('┏');

      case '住民税':
      case '年金':
      case '国民年金基金':
        return const Text('┃');

      case '国民健康保険':
        return const Text('┗');

      default:
        return Container();
    }
  }
}
