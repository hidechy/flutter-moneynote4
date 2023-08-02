// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../models/amazon_purchase.dart';
import '../../../models/credit_spend_monthly.dart';
import '../../../models/keihi.dart';
import '../../../models/money.dart';
import '../../../models/money_everyday.dart';
import '../../../models/zero_use_date.dart';
import '../../../state/benefit/benefit_notifier.dart';
import '../../../state/monthly_spend/monthly_spend_state.dart';
import '../../../utility/function.dart';
import '../../../utility/utility.dart';
import '../../../viewmodel/amazon_notifier.dart';
import '../../../viewmodel/bank_notifier.dart';
import '../../../viewmodel/holiday_notifier.dart';
import '../../../viewmodel/keihi_list_notifier.dart';
import '../../../viewmodel/money_notifier.dart';
import '../../../viewmodel/spend_notifier.dart';
import '../../../viewmodel/time_place_notifier.dart';
import '../../monthly_spend_check_screen.dart';
import '../_money_dialog.dart';
import '../monthly_spend_graph_alert.dart';
import '../spend_alert.dart';

class SpendListValue {
  SpendListValue({required this.item, required this.price, required this.color});

  String item;
  int price;
  Color color;
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

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    creditSpendMap = getNext2MonthCreditSpend(ref: ref, creDate: date, utility: _utility);

    makeMonthlySpendData();

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, position) {
              final pos = position - 1;

              if (position == 0) {
                return Container(
                  padding: const EdgeInsets.all(20),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MonthlySpendCheckScreen(date: date),
                                ),
                              );
                            },
                            child: const Icon(Icons.check_box),
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
  void makeMonthlySpendData() {
    displayMonthlySpendList = [];

    makeKeihiListMap();

    makeAmazonListMap();

    final spendMonthDetailState = _ref.watch(spendMonthDetailProvider(date));

    final holidayState = _ref.watch(holidayProvider);

    final benefitState = _ref.watch(benefitProvider);

    final bankMoveState = _ref.watch(bankMoveProvider);

    final spendZeroUseDateState = _ref.watch(spendZeroUseDateProvider);

    final moneyEverydayState = _ref.watch(moneyEverydayProvider);

    final everydayStateMap = makeEverydayStateMap(state: moneyEverydayState);

    monthTotalSpend = 0;
    monthTotalSumCredit = 0;

    //forで仕方ない
    for (var i = 0; i < spendMonthDetailState.list.length; i++) {
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

      bankMoveState.forEach(
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

      list2value.forEach((element) {
        list2.add(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            child: DefaultTextStyle(
              style: TextStyle(color: element.color, fontSize: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      element.item,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
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

      final youbi = _utility.getYoubi(
        youbiStr: spendMonthDetailState.list[i].date.youbiStr,
      );

      final sum = everydayStateMap[spendMonthDetailState.list[i].date.yyyymmdd];

      var diff = 0;
      if (sum != null) {
        diff = getDiff(spend: sum.spend.toInt(), daySum: daySum);
      }

      final spendZeroFlag = getSpendZeroFlag(
        date: spendMonthDetailState.list[i].date.yyyymmdd,
        spend: spendZeroUseDateState,
      );

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
              getMidashiDate(
                spendMonthDetailState,
                i,
                youbi,
                spendZeroFlag,
                sum,
                diff,
                daySum,
              ),
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

                        if (keihiListMap[spendMonthDetailState.list[i].date.yyyymmdd] != null)
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
                                    children: keihiListMap[spendMonthDetailState.list[i].date.yyyymmdd]!.map((e) {
                                      daySumCredit -= e.price;

                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              e.item,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
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
                                            child: Text(
                                              e.item,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
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

      monthTotalSpend += daySum;
      monthTotalSumCredit += daySumCredit;
    }
  }

  ///
  Map<String, MoneyEveryday> makeEverydayStateMap({required List<MoneyEveryday> state}) {
    final map = <String, MoneyEveryday>{};

    for (var i = 0; i < state.length; i++) {
      map[state[i].date.yyyymmdd] = state[i];
    }

    return map;
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
    MonthlySpendState spendMonthDetailState,
    int i,
    String youbi,
    int spendZeroFlag,
    MoneyEveryday? sum,
    int diff,
    int daySum,
  ) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '${spendMonthDetailState.list[i].date.yyyymmdd}（$youbi）',
                ),
                if (spendZeroFlag == 1)
                  Icon(
                    Icons.star,
                    color: Colors.yellowAccent.withOpacity(0.6),
                  ),
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
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent.withOpacity(0.3),
                        ),
                        child: Text(diff.toString().toCurrency()),
                      ),
                  ],
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    MoneyDialog(
                      context: _context,
                      widget: SpendAlert(
                        date: spendMonthDetailState.list[i].date,
                        diff: daySum.toString(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.info_outline,
                    color: (timeplaceDateList.contains(spendMonthDetailState.list[i].date.yyyymmdd))
                        ? Colors.yellowAccent.withOpacity(0.8)
                        : Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
        displayHavingMoney(date: spendMonthDetailState.list[i].date.yyyymmdd),
      ],
    );
  }

  ///
  void getMonthlyTimeplaceDate() {
    final monthlyTimeplaceState = _ref.watch(monthlyTimeplaceProvider(date));

    monthlyTimeplaceState.forEach((element) {
      timeplaceDateList.add(element.date.yyyymmdd);
    });
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
  Widget moneyDispParts({required String value}) {
    return Expanded(
      child: Container(
        alignment: Alignment.topRight,
        child: Text(value.toCurrency()),
      ),
    );
  }

  ///
  void makeKeihiListMap() {
    keihiListMap = {};

    final keihiListState = _ref.watch(keihiListProvider(date));

    var keepDate = '';
    keihiListState.forEach((element) {
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

    final amazonPurchaseState = _ref.watch(amazonPurchaseProvider(date));

    var keepDate = '';

    amazonPurchaseState.forEach((element) {
      if (element.date != keepDate) {
        amazonListMap[element.date] = [];
      }

      amazonListMap[element.date]?.add(element);

      keepDate = element.date;
    });
  }
}
