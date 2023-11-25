// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../models/amazon_purchase.dart';
import '../../../models/credit_spend_monthly.dart';
import '../../../models/keihi.dart';
import '../../../models/money.dart';
import '../../../models/money_everyday.dart';
import '../../../models/spend_yearly.dart';
import '../../../models/train.dart';
import '../../../models/zero_use_date.dart';
import '../../../route/routes.dart';
import '../../../state/amazon_purchase/amazon_notifier.dart';
import '../../../state/app_param/app_param_notifier.dart';
import '../../../state/bank/bank_notifier.dart';
import '../../../state/benefit/benefit_notifier.dart';
import '../../../state/holiday/holiday_notifier.dart';
import '../../../state/keihi_list/keihi_list_notifier.dart';
import '../../../state/money/money_notifier.dart';
import '../../../state/spend/spend_notifier.dart';
import '../../../state/time_place/time_place_notifier.dart';
import '../../../state/train/train_notifier.dart';
import '../../../utility/function.dart';
import '../../../utility/utility.dart';
import '../_money_dialog.dart';
import '../monthly_calendar_alert.dart';
import '../monthly_spend_graph_alert.dart';
import '../spend_alert.dart';

class SpendListValue {
  SpendListValue({required this.item, required this.price, required this.color});

  String item;
  int price;
  Color color;
}

class CalendarValue {
  CalendarValue({
    required this.whitePrice,
    required this.pinkPrice,
    required this.bankMovePrice,
    required this.bankMoveFlag,
    required this.benefit,
  });

  int whitePrice;
  int pinkPrice;
  int bankMovePrice;
  int bankMoveFlag;
  int benefit;
}

class MonthlySpendPage extends ConsumerWidget {
  MonthlySpendPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Map<String, List<CreditSpendMonthly>> creditSpendMap = {};

  List<Widget> displayMonthlySpendList = [];

  List<String> timeplaceDateList = [];

  Map<String, Money> allMoneyMap = {};

  int monthTotalSpend = 0;
  int monthTotalSumCredit = 0;

  Map<String, List<Keihi>> keihiListMap = {};

  Map<String, List<AmazonPurchase>> amazonListMap = {};

  DateTime calendarMonthFirst = DateTime.now();

  List<String> youbiList = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  List<String> calendarDays = [];

  Map<String, CalendarValue> calendarValueMap = {};

  Map<String, Train> trainMap = {};

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    creditSpendMap = getNext2MonthCreditSpend(ref: ref, creDate: date);

    makeMonthlySpendData();

    final appParamState = ref.watch(appParamProvider);

    //======================
    final spendZeroUseDateState = _ref.watch(spendZeroUseDateProvider);

    final exDate = date.yyyymmdd.split('-');

    var starNum = 0;
    spendZeroUseDateState.data.forEach((element) {
      final exElementDate = element.yyyymmdd.split('-');
      if (exDate[0] == exElementDate[0] && exDate[1] == exElementDate[1]) {
        starNum++;
      }
    });

    //======================

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, position) {
              final pos = position - 1;

              if (position == 0) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  MoneyDialog(
                                    context: context,
                                    widget: MonthlySpendGraphAlert(date: date),
                                  );
                                },
                                child: const Icon(Icons.graphic_eq),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () => context.goNamed(RouteNames.monthlySpendCheck, extra: {'date': date}),
                                child: const Icon(Icons.check_box),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  var index = DateTime.now().month - date.month;

                                  if (DateTime.now().year > date.year) {
                                    index += 12;
                                  }

                                  MoneyDialog(
                                    context: context,
                                    widget: MonthlyCalendarAlert(date: date, index: index),
                                  );
                                },
                                child: const Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(monthTotalSpend.toString().toCurrency()),
                              Text(
                                monthTotalSumCredit.toString().toCurrency(),
                                style: const TextStyle(color: Color(0xFFFB86CE)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ExpansionTile(
                      initiallyExpanded: appParamState.openMoneyArea,
                      iconColor: Colors.white,
                      onExpansionChanged: (value) => ref.read(appParamProvider.notifier).setOpenMoneyArea(value: value),
                      title: Text(
                        appParamState.openMoneyArea == false ? 'OPEN' : 'CLOSE',
                        style: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              _getCalendar(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  Text('$starNum stars.', style: const TextStyle(color: Colors.yellowAccent)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }

              return displayMonthlySpendList[pos];
            },
            childCount: displayMonthlySpendList.length + 1,
          ),
        ),
      ],
    );
  }

  ///
  Widget _getCalendar() {
    calendarMonthFirst = DateTime(date.year, date.month);

    final monthEnd = DateTime(date.year, date.month + 1, 0);

    final diff = monthEnd.difference(calendarMonthFirst).inDays;
    final monthDaysNum = diff + 1;

    final youbi = calendarMonthFirst.youbiStr;
    final youbiNum = youbiList.indexWhere((element) => element == youbi);

    final weekNum = ((monthDaysNum + youbiNum) <= 35) ? 5 : 6;

    calendarDays = List.generate(weekNum * 7, (index) => '');

    for (var i = 0; i < (weekNum * 7); i++) {
      if (i >= youbiNum) {
        final gendate = calendarMonthFirst.add(Duration(days: i - youbiNum));

        if (calendarMonthFirst.month == gendate.month) {
          calendarDays[i] = gendate.day.toString();
        }
      }
    }

    final list = <Widget>[];
    for (var i = 0; i < weekNum; i++) {
      list.add(_getCalendarRow(week: i));
    }

    return DefaultTextStyle(style: const TextStyle(fontSize: 10), child: Column(children: list));
  }

  ///
  Widget _getCalendarRow({required int week}) {
    final spendZeroUseDateState = _ref.watch(spendZeroUseDateProvider);

    final holidayState = _ref.watch(holidayProvider);

    trainMap = _ref.watch(trainProvider.select((value) => value.trainMap));

    final list = <Widget>[];

    for (var i = week * 7; i < ((week + 1) * 7); i++) {
      final dispDate = (calendarDays[i] == '')
          ? ''
          : DateTime(calendarMonthFirst.year, calendarMonthFirst.month, calendarDays[i].toInt()).yyyymmdd;

      var whitePrice =
          (calendarValueMap[dispDate]?.whitePrice != null) ? calendarValueMap[dispDate]?.whitePrice.toString() : '';

      final pinkPrice =
          (calendarValueMap[dispDate]?.pinkPrice != null) ? calendarValueMap[dispDate]?.pinkPrice.toString() : '';

      final bankMovePrice = (calendarValueMap[dispDate]?.bankMovePrice != null)
          ? calendarValueMap[dispDate]?.bankMovePrice.toString()
          : '';

      final bankMoveFlag =
          (calendarValueMap[dispDate]?.bankMoveFlag != null) ? calendarValueMap[dispDate]?.bankMoveFlag.toString() : '';

      final benefit =
          (calendarValueMap[dispDate]?.benefit != null) ? calendarValueMap[dispDate]?.benefit.toString() : '';

      if (bankMovePrice != '' && whitePrice != '') {
        if (bankMoveFlag == '0') {
          whitePrice = (whitePrice!.toInt() - bankMovePrice!.toInt()).toString();
        } else if (bankMoveFlag == '1') {
          whitePrice = (whitePrice!.toInt() + bankMovePrice!.toInt()).toString();
        }
      }

      if (benefit != '' && whitePrice != '') {
        whitePrice = (whitePrice!.toInt() + benefit!.toInt()).toString();
      }

      list.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              MoneyDialog(
                context: _context,
                widget: SpendAlert(date: '$dispDate 00:00:00'.toDateTime(), diff: whitePrice!),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(1),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: (calendarDays[i] == '') ? Colors.transparent : Colors.white.withOpacity(0.4),
                ),
                color: (dispDate != '')
                    ? _utility.getYoubiColor(
                        date: '$dispDate 00:00:00'.toDateTime(),
                        youbiStr: '$dispDate 00:00:00'.toDateTime().youbiStr,
                        holiday: holidayState.data)
                    : Colors.transparent,
              ),
              child: (calendarDays[i] == '')
                  ? const Text('')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(calendarDays[i].padLeft(2, '0')),
                            if (getSpendZeroFlag(date: dispDate, spend: spendZeroUseDateState) == 1)
                              Icon(Icons.star, color: Colors.yellowAccent.withOpacity(0.6), size: 10),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text((whitePrice != '') ? whitePrice!.toCurrency() : ''),
                              Text(
                                (pinkPrice != '') ? pinkPrice!.toCurrency() : '',
                                style: const TextStyle(color: Color(0xFFFB86CE)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      );
    }

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  ///
  void makeMonthlySpendData() {
    displayMonthlySpendList = [];

    makeKeihiListMap();

    makeAmazonListMap();

    final holidayState = _ref.watch(holidayProvider);

    final benefitList = _ref.watch(benefitProvider.select((value) => value.benefitList));

    //
    //
    // final benefitState = _ref.watch(benefitProvider);
    //
    //
    //

    // final bankMoveState = _ref.watch(bankMoveProvider);
    //
    //
    //
    //

    final bankMoveList = _ref.watch(bankMoveProvider.select((value) => value.bankMoveList));

    final spendZeroUseDateState = _ref.watch(spendZeroUseDateProvider);

    //
    //
    //
    // final moneyEverydayState = _ref.watch(moneyEverydayProvider);
    //
    // final everydayStateMap = makeEverydayStateMap(state: moneyEverydayState);
    //
    //
    //
    //

    final everydayStateMap = makeEverydayStateMap();

    monthTotalSpend = 0;
    monthTotalSumCredit = 0;

    //forで仕方ない

    final spendYearlyList = _ref.watch(spendMonthDetailProvider(date).select((value) => value.spendYearlyList));

    spendYearlyList.when(
      data: (value) {
        for (var i = 0; i < value.length; i++) {
          final dateKeihiListMap = keihiListMap[value[i].date.yyyymmdd];

          //--------------------------------------------- list2
          final list2 = <Widget>[];
          final list2value = <SpendListValue>[];

          var daySum = 0;
          var daySumCredit = 0;

          value[i].item.forEach(
            (element) {
              list2value.add(
                SpendListValue(
                  item: element.item,
                  price: element.price.toString().toInt(),
                  color: (element.flag.toString() == '1') ? Colors.lightBlueAccent : Colors.white,
                ),
              );

              daySum += element.price.toString().toInt();
              daySumCredit += element.price.toString().toInt();
            },
          );

          if (creditSpendMap[value[i].date.yyyymmdd] != null) {
            creditSpendMap[value[i].date.yyyymmdd]!.forEach((element) {
              list2value.add(
                SpendListValue(item: element.item, price: element.price.toInt(), color: const Color(0xFFFB86CE)),
              );

              daySumCredit += element.price.toInt();
            });
          }

          benefitList.value?.forEach((element) {
            if (value[i].date.yyyymmdd == element.date.yyyymmdd) {
              list2value.add(
                SpendListValue(item: 'benefit', price: element.salary.toInt(), color: Colors.yellowAccent),
              );
            }
          });

          //
          //
          //
          // benefitState.benefitList.forEach(
          //   (element) {
          //     if (value[i].date.yyyymmdd == element.date.yyyymmdd) {
          //       list2value.add(
          //         SpendListValue(item: 'benefit', price: element.salary.toInt(), color: Colors.yellowAccent),
          //       );
          //     }
          //   },
          // );
          //
          //
          //
          //

          bankMoveList.value?.forEach(
            (element) {
              if (value[i].date.yyyymmdd == element.date.yyyymmdd) {
                list2value.add(
                  SpendListValue(
                    item: 'Bank Move - ${element.bank} // ${element.flag == 0 ? 'out' : 'in'}',
                    price: element.price,
                    color: Colors.greenAccent,
                  ),
                );
              }
            },
          );

          // bankMoveState.forEach(
          //   (element) {
          //     if (spendMonthDetailState.list[i].date.yyyymmdd == element.date.yyyymmdd) {
          //       list2value.add(
          //         SpendListValue(
          //           item: 'Bank Move - ${element.bank} // ${element.flag == 0 ? 'out' : 'in'}',
          //           price: element.price,
          //           color: Colors.greenAccent,
          //         ),
          //       );
          //     }
          //   },
          // );
          //
          //

          list2value.forEach((element) {
            final textStyle = getKeihiTextStyle(element: element, dateKeihiListMap: dateKeihiListMap);

            list2.add(
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white.withOpacity(0.3)),
                  ),
                ),
                child: DefaultTextStyle(
                  style: textStyle,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(element.item, overflow: TextOverflow.ellipsis, maxLines: 1),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text(element.price.toString().toCurrency()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });

          //--------------------------------------------- list2

          final youbi = _utility.getYoubi(youbiStr: value[i].date.youbiStr);

          final sum = everydayStateMap[value[i].date.yyyymmdd];

          var diff = 0;
          if (sum != null) {
            diff = getDiff(spend: sum.spend.toInt(), daySum: daySum);
          }

          final spendZeroFlag = getSpendZeroFlag(date: value[i].date.yyyymmdd, spend: spendZeroUseDateState);

          displayMonthlySpendList.add(
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.5)),
                color: _utility.getYoubiColor(
                  date: value[i].date,
                  youbiStr: value[i].date.youbiStr,
                  holiday: holidayState.data,
                ),
              ),
              child: Column(
                children: [
                  getMidashiDate(value, i, youbi, spendZeroFlag, sum, diff, daySum),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 30),
                      Expanded(
                        child: Column(
                          children: [
                            Column(children: list2),

                            /////

                            if (dateKeihiListMap != null)
                              DefaultTextStyle(
                                style: const TextStyle(fontSize: 10),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [const Text('＜経費＞'), Container()],
                                      ),
                                      Column(
                                        children: dateKeihiListMap.map((e) {
                                          daySumCredit -= e.price;

                                          return Row(
                                            children: [
                                              Expanded(
                                                child: Text(e.item, overflow: TextOverflow.ellipsis, maxLines: 1),
                                              ),
                                              const SizedBox(width: 20),
                                              Text(e.price.toString().toCurrency()),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            /////

                            if (amazonListMap[value[i].date.yyyymmdd] != null)
                              DefaultTextStyle(
                                style: const TextStyle(fontSize: 10),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                  decoration: BoxDecoration(color: Colors.purpleAccent.withOpacity(0.1)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [const Text('＜Amazon＞'), Container()],
                                      ),
                                      Column(
                                        children: amazonListMap[value[i].date.yyyymmdd]!.map((e) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                child: Text(e.item, overflow: TextOverflow.ellipsis, maxLines: 1),
                                              ),
                                              const SizedBox(width: 20),
                                              Text(e.price.toCurrency()),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            /////

                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                daySumCredit.toString().toCurrency(),
                                style: const TextStyle(fontSize: 12, color: Color(0xFFFB86CE)),
                              ),
                            ),
                            const SizedBox(height: 10),

                            /////
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );

          /////////////////////////////////////////////////////////////////////

          var bMPrice = 0;
          var bMFlag = 0;

          bankMoveList.value?.forEach(
            (element) {
              if (value[i].date.yyyymmdd == element.date.yyyymmdd) {
                bMPrice = element.price;
                bMFlag = element.flag;
              }
            },
          );

          // bankMoveState.forEach(
          //   (element) {
          //     if (spendMonthDetailState.list[i].date.yyyymmdd == element.date.yyyymmdd) {
          //       bMPrice = element.price;
          //       bMFlag = element.flag;
          //     }
          //   },
          // );
          //
          //
          //

          var benefit = 0;

          benefitList.value?.forEach((element) {
            if (value[i].date.yyyymmdd == element.date.yyyymmdd) {
              benefit = element.salary.toInt();
            }
          });

          //
          //
          //
          // benefitState.benefitList.forEach(
          //   (element) {
          //     if (value[i].date.yyyymmdd == element.date.yyyymmdd) {
          //       benefit = element.salary.toInt();
          //     }
          //   },
          // );
          //
          //
          //

          final whitePrice = (sum != null) ? sum.spend.toInt() : 0;

          calendarValueMap[value[i].date.yyyymmdd] = CalendarValue(
            whitePrice: whitePrice,
            pinkPrice: daySumCredit,
            bankMovePrice: bMPrice,
            bankMoveFlag: bMFlag,
            benefit: benefit,
          );

          /////////////////////////////////////////////////////////////////////

          monthTotalSpend += daySum;
          monthTotalSumCredit += daySumCredit;
        }
      },
      error: (error, stackTrace) => Container(),
      loading: Container.new,
    );

    /*



        final spendMonthDetailState = _ref.watch(spendMonthDetailProvider(date));


    for (var i = 0; i < spendMonthDetailState.list.length; i++) {
      final dateKeihiListMap = keihiListMap[spendMonthDetailState.list[i].date.yyyymmdd];

      //--------------------------------------------- list2
      final list2 = <Widget>[];
      final list2value = <SpendListValue>[];

      var daySum = 0;
      var daySumCredit = 0;

      spendMonthDetailState.list[i].item.forEach(
        (element) {
          list2value.add(
            SpendListValue(
              item: element.item,
              price: element.price.toString().toInt(),
              color: (element.flag.toString() == '1') ? Colors.lightBlueAccent : Colors.white,
            ),
          );

          daySum += element.price.toString().toInt();
          daySumCredit += element.price.toString().toInt();
        },
      );

      if (creditSpendMap[spendMonthDetailState.list[i].date.yyyymmdd] != null) {
        creditSpendMap[spendMonthDetailState.list[i].date.yyyymmdd]!.forEach((element) {
          list2value.add(
            SpendListValue(item: element.item, price: element.price.toInt(), color: const Color(0xFFFB86CE)),
          );

          daySumCredit += element.price.toInt();
        });
      }

      benefitState.benefitList.forEach(
        (element) {
          if (spendMonthDetailState.list[i].date.yyyymmdd == element.date.yyyymmdd) {
            list2value.add(
              SpendListValue(item: 'benefit', price: element.salary.toInt(), color: Colors.yellowAccent),
            );
          }
        },
      );

      bankMoveList.value?.forEach(
        (element) {
          if (spendMonthDetailState.list[i].date.yyyymmdd == element.date.yyyymmdd) {
            list2value.add(
              SpendListValue(
                item: 'Bank Move - ${element.bank} // ${element.flag == 0 ? 'out' : 'in'}',
                price: element.price,
                color: Colors.greenAccent,
              ),
            );
          }
        },
      );

      // bankMoveState.forEach(
      //   (element) {
      //     if (spendMonthDetailState.list[i].date.yyyymmdd == element.date.yyyymmdd) {
      //       list2value.add(
      //         SpendListValue(
      //           item: 'Bank Move - ${element.bank} // ${element.flag == 0 ? 'out' : 'in'}',
      //           price: element.price,
      //           color: Colors.greenAccent,
      //         ),
      //       );
      //     }
      //   },
      // );
      //
      //

      list2value.forEach((element) {
        final textStyle = getKeihiTextStyle(element: element, dateKeihiListMap: dateKeihiListMap);

        list2.add(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.3)),
              ),
            ),
            child: DefaultTextStyle(
              style: textStyle,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(element.item, overflow: TextOverflow.ellipsis, maxLines: 1),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(element.price.toString().toCurrency()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });

      //--------------------------------------------- list2

      final youbi = _utility.getYoubi(youbiStr: spendMonthDetailState.list[i].date.youbiStr);

      final sum = everydayStateMap[spendMonthDetailState.list[i].date.yyyymmdd];

      var diff = 0;
      if (sum != null) {
        diff = getDiff(spend: sum.spend.toInt(), daySum: daySum);
      }

      final spendZeroFlag =
          getSpendZeroFlag(date: spendMonthDetailState.list[i].date.yyyymmdd, spend: spendZeroUseDateState);

      displayMonthlySpendList.add(
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            color: _utility.getYoubiColor(
              date: spendMonthDetailState.list[i].date,
              youbiStr: spendMonthDetailState.list[i].date.youbiStr,
              holiday: holidayState.data,
            ),
          ),
          child: Column(
            children: [
              getMidashiDate(spendMonthDetailState, i, youbi, spendZeroFlag, sum, diff, daySum),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      children: [
                        Column(children: list2),

                        /////

                        if (dateKeihiListMap != null)
                          DefaultTextStyle(
                            style: const TextStyle(fontSize: 10),
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [const Text('＜経費＞'), Container()],
                                  ),
                                  Column(
                                    children: dateKeihiListMap.map((e) {
                                      daySumCredit -= e.price;

                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Text(e.item, overflow: TextOverflow.ellipsis, maxLines: 1),
                                          ),
                                          const SizedBox(width: 20),
                                          Text(e.price.toString().toCurrency()),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        /////

                        if (amazonListMap[spendMonthDetailState.list[i].date.yyyymmdd] != null)
                          DefaultTextStyle(
                            style: const TextStyle(fontSize: 10),
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                              decoration: BoxDecoration(color: Colors.purpleAccent.withOpacity(0.1)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [const Text('＜Amazon＞'), Container()],
                                  ),
                                  Column(
                                    children: amazonListMap[spendMonthDetailState.list[i].date.yyyymmdd]!.map((e) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Text(e.item, overflow: TextOverflow.ellipsis, maxLines: 1),
                                          ),
                                          const SizedBox(width: 20),
                                          Text(e.price.toCurrency()),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        /////

                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            daySumCredit.toString().toCurrency(),
                            style: const TextStyle(fontSize: 12, color: Color(0xFFFB86CE)),
                          ),
                        ),
                        const SizedBox(height: 10),

                        /////
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      /////////////////////////////////////////////////////////////////////

      var bMPrice = 0;
      var bMFlag = 0;

      bankMoveList.value?.forEach(
        (element) {
          if (spendMonthDetailState.list[i].date.yyyymmdd == element.date.yyyymmdd) {
            bMPrice = element.price;
            bMFlag = element.flag;
          }
        },
      );

      // bankMoveState.forEach(
      //   (element) {
      //     if (spendMonthDetailState.list[i].date.yyyymmdd == element.date.yyyymmdd) {
      //       bMPrice = element.price;
      //       bMFlag = element.flag;
      //     }
      //   },
      // );
      //
      //
      //

      var benefit = 0;
      benefitState.benefitList.forEach(
        (element) {
          if (spendMonthDetailState.list[i].date.yyyymmdd == element.date.yyyymmdd) {
            benefit = element.salary.toInt();
          }
        },
      );

      final whitePrice = (sum != null) ? sum.spend.toInt() : 0;

      calendarValueMap[spendMonthDetailState.list[i].date.yyyymmdd] = CalendarValue(
        whitePrice: whitePrice,
        pinkPrice: daySumCredit,
        bankMovePrice: bMPrice,
        bankMoveFlag: bMFlag,
        benefit: benefit,
      );

      /////////////////////////////////////////////////////////////////////

      monthTotalSpend += daySum;
      monthTotalSumCredit += daySumCredit;
    }





    */
  }

  ///
  TextStyle getKeihiTextStyle({required SpendListValue element, List<Keihi>? dateKeihiListMap}) {
    // ignore: prefer_is_empty
    if (dateKeihiListMap?.length == 0) {
      return TextStyle(color: element.color, fontSize: 12);
    }

    final itemList = <String>[];
    dateKeihiListMap?.forEach((element) => itemList.add(element.item));

    if (itemList.contains(element.item)) {
      return TextStyle(color: element.color, fontSize: 12, decoration: TextDecoration.lineThrough);
    }

    return TextStyle(color: element.color, fontSize: 12);
  }

  ///
  Map<String, MoneyEveryday> makeEverydayStateMap() {
    final moneyEverydayList = _ref.watch(moneyEverydayProvider.select((value) => value.moneyEverydayList));

    final map = <String, MoneyEveryday>{};

    moneyEverydayList.value?.forEach((element) => map[element.date.yyyymmdd] = element);

    return map;

    //
    //
    // final everydayStateMap = makeEverydayStateMap(state: moneyEverydayState);
    //

//    {required List<MoneyEveryday> state}

    //
    //
    // final map = <String, MoneyEveryday>{};
    //
    // for (var i = 0; i < state.length; i++) {
    //   map[state[i].date.yyyymmdd] = state[i];
    // }
    //
    // return map;
    //
    //
    //
  }

  ///
  int getDiff({required int spend, required int daySum}) {
    if (spend < 0) {
      return (spend * -1) + daySum;
    } else {
      return spend - daySum;
    }
  }

  ///
  int getSpendZeroFlag({required String date, required ZeroUseDate spend}) {
    for (var i = 0; i < spend.data.length; i++) {
      if (date == spend.data[i].yyyymmdd) {
        return 1;
      }
    }

    return 0;
  }

  ///
  Widget getMidashiDate(
    List<SpendYearly> value,
    int i,
    String youbi,
    int spendZeroFlag,
    MoneyEveryday? sum,
    int diff,
    int daySum,
  ) {
    trainMap = _ref.watch(trainProvider.select((value) => value.trainMap));

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('${value[i].date.yyyymmdd}（$youbi）'),
                if (spendZeroFlag == 1) Icon(Icons.star, color: Colors.yellowAccent.withOpacity(0.6)),
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (sum != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text((sum.sum == '') ? '0' : sum.sum.toCurrency()),
                          Text(sum.spend.toCurrency()),
                        ],
                      ),
                    if (diff != 0)
                      Container(
                        padding: const EdgeInsets.only(top: 3, bottom: 3, left: 20),
                        decoration: BoxDecoration(color: Colors.yellowAccent.withOpacity(0.3)),
                        child: Text(diff.toString().toCurrency()),
                      ),
                  ],
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    MoneyDialog(
                      context: _context,
                      widget: SpendAlert(date: value[i].date, diff: daySum.toString()),
                    );
                  },
                  child: Icon(
                    Icons.info_outline,
                    color: (timeplaceDateList.contains(value[i].date.yyyymmdd))
                        ? Colors.yellowAccent.withOpacity(0.8)
                        : Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
        displayHavingMoney(date: value[i].date.yyyymmdd),
      ],
    );
  }

  ///
  void getMonthlyTimeplaceDate() {
    // _ref.watch(timeplaceProvider(date)).forEach((element) {
    //   timeplaceDateList.add(element.date.yyyymmdd);
    // });

    final timePlaceList = _ref.watch(timeplaceProvider(date).select((value) => value.timePlaceList));

    timePlaceList.value?.forEach((element) => timeplaceDateList.add(element.date.yyyymmdd));
  }

  ///
  Widget displayHavingMoney({required String date}) {
    if (allMoneyMap[date] == null) {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: Column(
          children: [
            Row(
              children: [
                moneyDispParts(value: allMoneyMap[date]!.yen10000),
                moneyDispParts(value: allMoneyMap[date]!.yen5000),
                moneyDispParts(value: allMoneyMap[date]!.yen2000),
                moneyDispParts(value: allMoneyMap[date]!.yen1000),
                moneyDispParts(value: allMoneyMap[date]!.yen500),
                moneyDispParts(value: allMoneyMap[date]!.yen100),
                moneyDispParts(value: allMoneyMap[date]!.yen50),
                moneyDispParts(value: allMoneyMap[date]!.yen10),
                moneyDispParts(value: allMoneyMap[date]!.yen5),
                moneyDispParts(value: allMoneyMap[date]!.yen1),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                moneyDispParts(value: allMoneyMap[date]!.bankA),
                moneyDispParts(value: allMoneyMap[date]!.bankB),
                moneyDispParts(value: allMoneyMap[date]!.bankC),
                moneyDispParts(value: allMoneyMap[date]!.bankD),
                moneyDispParts(value: allMoneyMap[date]!.bankE),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                moneyDispParts(value: allMoneyMap[date]!.payA),
                moneyDispParts(value: allMoneyMap[date]!.payB),
                moneyDispParts(value: allMoneyMap[date]!.payC),
                moneyDispParts(value: allMoneyMap[date]!.payD),
                moneyDispParts(value: allMoneyMap[date]!.payE),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  Widget moneyDispParts({required String value}) =>
      Expanded(child: Container(alignment: Alignment.topRight, child: Text(value.toCurrency())));

  ///
  void makeKeihiListMap() {
    keihiListMap = {};

    var keepDate = '';

    // final keihiListState = _ref.watch(keihiListProvider(date));
    //
    // keihiListState.forEach((element) {
    //   if (date.yyyymm == element.date.yyyymm) {
    //     if (element.date.yyyymmdd != keepDate) {
    //       keihiListMap[element.date.yyyymmdd] = [];
    //     }
    //
    //     keihiListMap[element.date.yyyymmdd]?.add(element);
    //
    //     keepDate = element.date.yyyymmdd;
    //   }
    // });
    //
    //
    //

    final keihiList = _ref.watch(keihiListProvider(date).select((value) => value.keihiList));

    keihiList.value?.forEach((element) {
      if (date.yyyymm == element.date.yyyymm) {
        if (element.date.yyyymmdd != keepDate) {
          keihiListMap[element.date.yyyymmdd] = [];
        }

        keihiListMap[element.date.yyyymmdd]?.add(element);

        keepDate = element.date.yyyymmdd;
      }
    });
  }

  ///
  void makeAmazonListMap() {
    amazonListMap = {};

    final amazonPurchaseList = _ref.watch(amazonPurchaseProvider(date).select((value) => value.amazonPurchaseList));

    var keepDate = '';

    amazonPurchaseList.value?.forEach((element) {
      if (element.date != keepDate) {
        amazonListMap[element.date] = [];
      }

      amazonListMap[element.date]?.add(element);

      keepDate = element.date;
    });

    // amazonPurchaseList.when(
    //   data: (value) => value.forEach((element) {
    //     if (element.date != keepDate) {
    //       amazonListMap[element.date] = [];
    //     }
    //
    //     amazonListMap[element.date]?.add(element);
    //
    //     keepDate = element.date;
    //   }),
    //   error: (error, stackTrace) => Container(),
    //   loading: Container.new,
    // );

    // amazonPurchaseState.forEach((element) {
    //   if (element.date != keepDate) {
    //     amazonListMap[element.date] = [];
    //   }
    //
    //   amazonListMap[element.date]?.add(element);
    //
    //   keepDate = element.date;
    // });
  }
}
