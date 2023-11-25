// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/holiday/holiday_notifier.dart';
import '../../state/money/money_notifier.dart';
import '../../state/spend/spend_notifier.dart';
import '../../utility/utility.dart';
import '_money_dialog.dart';
import 'spend_alert.dart';
import 'spend_fullyear_compare_alert.dart';
import 'spend_year_day_item_alert.dart';
import 'year_average_graph_alert.dart';

class SpendYearDayAlert extends ConsumerWidget {
  SpendYearDayAlert({super.key, required this.date, required this.spend, required this.yearSpendToToday});

  final DateTime date;
  final int spend;
  final Map<int, int> yearSpendToToday;

  final Utility _utility = Utility();

  Map<String, int> everydayMoney = {};

  List<int> ysttList = [];

  final autoScrollController = AutoScrollController();

  int thisYearDataLength = 0;

  int dataLength = 0;

  Map<int, int> yearDateAverageMap = {};
  Map<int, String> yearDateMap = {};

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final spendYearlyList = ref.watch(spendYearlyProvider(date).select((value) => value.spendYearlyList));
    final spendYearlyListLength = (spendYearlyList.value != null) ? spendYearlyList.value!.length : 0;

    //
    // final spendYearDayState = ref.watch(spendYearlyProvider(date));
    //
    //
    //
    //

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
                  Text(date.yyyymmdd),
                  Text(
                    spend.toString().toCurrency(),
                    style: const TextStyle(color: Color(0xFFFBB6CE)),
                  ),
                ],
              ),

              Divider(color: Colors.white.withOpacity(0.4), thickness: 2),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => autoScrollController.scrollToIndex(spendYearlyListLength),
                        child: const Icon(Icons.arrow_downward),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () => autoScrollController.scrollToIndex(0),
                        child: const Icon(Icons.arrow_upward),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (date.year == DateTime.now().year) ...[
                        GestureDetector(
                          onTap: () {
                            MoneyDialog(
                              context: context,
                              widget: SpendFullyearCompareAlert(
                                date: date,
                                spend: spend,
                                thisYearDataLength: dataLength,
                              ),
                            );
                          },
                          child: const Icon(Icons.pie_chart),
                        ),
                        const SizedBox(width: 20),
                      ],
                      GestureDetector(
                        onTap: () {
                          MoneyDialog(
                            context: context,
                            widget: YearAverageGraphAlert(
                              date: date,
                              yearDateAverageMap: yearDateAverageMap,
                              yearDateMap: yearDateMap,
                            ),
                          );
                        },
                        child: const Icon(Icons.graphic_eq),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () => MoneyDialog(context: context, widget: SpendYearDayItemAlert(date: date)),
                        child: const Icon(Icons.list),
                      ),
                    ],
                  ),
                ],
              ),

              Divider(color: Colors.white.withOpacity(0.4), thickness: 2),

              Expanded(child: displaySpendYearDay()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displaySpendYearDay() {
    makeEverydayMoney();

    final list = <Widget>[];

    final holidayState = _ref.watch(holidayProvider);

    //====================================//
    final totalMap = <String, int>{};
    var total = 0;
    var keepMonth = '';

    final spendYearlyList = _ref.watch(spendYearlyProvider(date).select((value) => value.spendYearlyList));

    spendYearlyList.value?.forEach((element) {
      if (keepMonth != element.date.yyyymm) {
        total = 0;
      }

      total += element.spend;

      totalMap[element.date.yyyymm] = total;

      keepMonth = element.date.yyyymm;
    });

    //
    //
    // final spendYearDayState = _ref.watch(spendYearlyProvider(date));
    //
    // spendYearDayState.forEach((element) {
    //   if (keepMonth != element.date.yyyymm) {
    //     total = 0;
    //   }
    //
    //   total += element.spend;
    //
    //   totalMap[element.date.yyyymm] = total;
    //
    //   keepMonth = element.date.yyyymm;
    // });
    //
    //

    //====================================//

    var yearTotal = 0;

    yearSpendToToday.remove(date.year);

    ysttList = [];

    return spendYearlyList.when(
      data: (value) {
        for (var i = 0; i < value.length; i++) {
          if (date.isBefore(value[i].date)) {
          } else {
            yearTotal += value[i].spend;

            final exDate = value[i].date.yyyymmdd.split('-');

            //============================================//
            yearSpendToToday.entries.forEach((element2) {
              if (element2.value < yearTotal) {
                if (!ysttList.contains(element2.key)) {
                  list.add(
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Bubble(
                            color: Colors.indigoAccent.withOpacity(0.4),
                            nip: BubbleNip.leftTop,
                            child: Text(
                              '${element2.value.toString().toCurrency()} (${element2.key})',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                ysttList.add(element2.key);
              }
            });
            //============================================//

            final textColor = (value[i].spend > 10000) ? Colors.yellowAccent : Colors.white;

            list.add(
              AutoScrollTag(
                key: ValueKey(i),
                index: i,
                controller: autoScrollController,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                    color: _utility.getYoubiColor(
                        date: value[i].date, youbiStr: value[i].date.youbiStr, holiday: holidayState.data),
                  ),
                  child: DefaultTextStyle(
                    style: const TextStyle(fontSize: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _utility.getLeadingBgColor(month: value[i].date.mm),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      value[i].date.month.toString().padLeft(2, '0'),
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${value[i].date.day.toString().padLeft(2, '0')}（${_utility.getYoubi(youbiStr: value[i].date.youbiStr)}）',
                                  ),
                                  if (exDate[2] == '01') ...[
                                    const SizedBox(width: 10),
                                    Tooltip(
                                      message: totalMap[value[i].date.yyyymm].toString().toCurrency(),
                                      textStyle: const TextStyle(color: Colors.white),
                                      decoration: BoxDecoration(
                                        color: Colors.yellowAccent.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      showDuration: const Duration(seconds: 2),
                                      child: Icon(Icons.comment, color: Colors.white.withOpacity(0.3)),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.topRight,
                                child: (everydayMoney[value[i].date.yyyymmdd] == null)
                                    ? Container()
                                    : Text(everydayMoney[value[i].date.yyyymmdd].toString().toCurrency()),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.topRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(value[i].spend.toString().toCurrency(), style: TextStyle(color: textColor)),
                                    const SizedBox(height: 3),
                                    Text(yearTotal.toString().toCurrency(), style: const TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                MoneyDialog(
                                  context: _context,
                                  widget: SpendAlert(date: value[i].date, diff: value[i].spend.toString()),
                                );
                              },
                              child: Icon(Icons.info_outline, color: Colors.white.withOpacity(0.6)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(
                              '${i + 1} - ${(yearTotal / (i + 1)).round().toString().split('.')[0].toCurrency()}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );

            dataLength = i + 1;

            yearDateAverageMap[dataLength] = (yearTotal / dataLength).round();

            yearDateMap[dataLength] = value[i].date.yyyymmdd;
          }
        }

        if (date.year == DateTime.now().year) {
          thisYearDataLength = list.length;
        }

        return SingleChildScrollView(controller: autoScrollController, child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*


    for (var i = 0; i < spendYearDayState.length; i++) {
      if (date.isBefore(spendYearDayState[i].date)) {
      } else {
        yearTotal += spendYearDayState[i].spend;

        final exDate = spendYearDayState[i].date.yyyymmdd.split('-');

        //============================================//
        yearSpendToToday.entries.forEach((element2) {
          if (element2.value < yearTotal) {
            if (!ysttList.contains(element2.key)) {
              list.add(
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Bubble(
                        color: Colors.indigoAccent.withOpacity(0.4),
                        nip: BubbleNip.leftTop,
                        child: Text(
                          '${element2.value.toString().toCurrency()} (${element2.key})',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            ysttList.add(element2.key);
          }
        });
        //============================================//

        final textColor = (spendYearDayState[i].spend > 10000) ? Colors.yellowAccent : Colors.white;

        list.add(
          AutoScrollTag(
            key: ValueKey(i),
            index: i,
            controller: autoScrollController,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                color: _utility.getYoubiColor(
                  date: spendYearDayState[i].date,
                  youbiStr: spendYearDayState[i].date.youbiStr,
                  holiday: holidayState.data,
                ),
              ),
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _utility.getLeadingBgColor(month: spendYearDayState[i].date.mm),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  spendYearDayState[i].date.month.toString().padLeft(2, '0'),
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${spendYearDayState[i].date.day.toString().padLeft(2, '0')}（${_utility.getYoubi(youbiStr: spendYearDayState[i].date.youbiStr)}）',
                              ),
                              if (exDate[2] == '01') ...[
                                const SizedBox(width: 10),
                                Tooltip(
                                  message: totalMap[spendYearDayState[i].date.yyyymm].toString().toCurrency(),
                                  textStyle: const TextStyle(color: Colors.white),
                                  decoration: BoxDecoration(
                                    color: Colors.yellowAccent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  showDuration: const Duration(seconds: 2),
                                  child: Icon(Icons.comment, color: Colors.white.withOpacity(0.3)),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: (everydayMoney[spendYearDayState[i].date.yyyymmdd] == null)
                                ? Container()
                                : Text(everydayMoney[spendYearDayState[i].date.yyyymmdd].toString().toCurrency()),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  spendYearDayState[i].spend.toString().toCurrency(),
                                  style: TextStyle(color: textColor),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  yearTotal.toString().toCurrency(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            MoneyDialog(
                              context: _context,
                              widget: SpendAlert(
                                date: spendYearDayState[i].date,
                                diff: spendYearDayState[i].spend.toString(),
                              ),
                            );
                          },
                          child: Icon(Icons.info_outline, color: Colors.white.withOpacity(0.6)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Text(
                          '${i + 1} - ${(yearTotal / (i + 1)).round().toString().split('.')[0].toCurrency()}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

        dataLength = i + 1;

        yearDateAverageMap[dataLength] = (yearTotal / dataLength).round();

        yearDateMap[dataLength] = spendYearDayState[i].date.yyyymmdd;
      }
    }

    if (date.year == DateTime.now().year) {
      thisYearDataLength = list.length;
    }

    return SingleChildScrollView(controller: autoScrollController, child: Column(children: list));



    */
  }

  ///
  void makeEverydayMoney() {
    everydayMoney = {};

    final moneyEverydayList = _ref.watch(moneyEverydayProvider.select((value) => value.moneyEverydayList));

    moneyEverydayList.value?.forEach((element) => everydayMoney[element.date.yyyymmdd] = element.sum.toInt());

    // final moneyEverydayState = _ref.watch(moneyEverydayProvider);
    //
    // moneyEverydayState.forEach((element) {
    //   everydayMoney[element.date.yyyymmdd] = element.sum.toInt();
    // });
    //
    //
    //
  }
}
