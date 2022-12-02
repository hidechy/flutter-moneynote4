// ignore_for_file: must_be_immutable, sized_box_shrink_expand

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/money_everyday.dart';
import 'package:moneynote4/screens/_components/_money_dialog.dart';
import 'package:moneynote4/screens/_components/monthly_graph_alert.dart';
import 'package:moneynote4/utility/utility.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../models/credit_spend_monthly.dart';
import '../../viewmodel/credit_notifier.dart';
import '../../viewmodel/holiday_notifier.dart';
import '../../viewmodel/money_notifier.dart';
import '../../viewmodel/spend_notifier.dart';

class MonthlySpendAlert extends ConsumerWidget {
  MonthlySpendAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

  final Utility _utility = Utility();

  Map<String, List<CreditSpendMonthly>> creditSpendMap = {};

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    getNext2MonthCreditSpend();

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(width: context.screenSize.width),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      GestureDetector(
                        onTap: () {
                          MoneyDialog(
                            context: context,
                            widget: MonthlyGraphAlert(date: date),
                          );
                        },
                        child: const Icon(Icons.graphic_eq),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                displayMonthlySpend(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  void getNext2MonthCreditSpend() {
    final exYmd = date.yyyymmdd.split('-');

    var list = <CreditSpendMonthly>[];
    var keepDate = '';

    //---------------------//
    final after1 = DateTime(exYmd[0].toInt(), exYmd[1].toInt() + 1);

    final creditSpendMonthlyState1 =
        _ref.watch(creditSpendMonthlyProvider(after1));

    list = <CreditSpendMonthly>[];
    keepDate = '';

    for (var i = 0; i < creditSpendMonthlyState1.length; i++) {
      if (keepDate != creditSpendMonthlyState1[i].date.yyyymmdd) {
        list = [];
      }

      if (date.yyyymm == creditSpendMonthlyState1[i].date.yyyymm) {
        list.add(creditSpendMonthlyState1[i]);
      }

      if (list.isNotEmpty) {
        creditSpendMap[creditSpendMonthlyState1[i].date.yyyymmdd] = list;
      }

      keepDate = creditSpendMonthlyState1[i].date.yyyymmdd;
    }
    //---------------------//

    //---------------------//
    final after2 = DateTime(exYmd[0].toInt(), exYmd[1].toInt() + 2);

    final creditSpendMonthlyState2 =
        _ref.watch(creditSpendMonthlyProvider(after2));

    list = <CreditSpendMonthly>[];
    keepDate = '';

    for (var i = 0; i < creditSpendMonthlyState2.length; i++) {
      if (keepDate != creditSpendMonthlyState2[i].date.yyyymmdd) {
        list = [];
      }

      if (date.yyyymm == creditSpendMonthlyState2[i].date.yyyymm) {
        list.add(creditSpendMonthlyState2[i]);
      }

      if (list.isNotEmpty) {
        creditSpendMap[creditSpendMonthlyState2[i].date.yyyymmdd] = list;
      }

      keepDate = creditSpendMonthlyState2[i].date.yyyymmdd;
    }
    //---------------------//
  }

  ///
  Widget displayMonthlySpend() {
    final spendMonthDetailState = _ref.watch(spendMonthDetailProvider(date));

    final holidayState = _ref.watch(holidayProvider);

    final moneyEverydayState = _ref.watch(moneyEverydayProvider);

    final list = <Widget>[];

    for (var i = 0; i < spendMonthDetailState.length; i++) {
      final list2 = <Widget>[];

      for (var j = 0; j < spendMonthDetailState[i].item.length; j++) {
        final color = (spendMonthDetailState[i].item[j].flag.toString() == '1')
            ? Colors.lightBlueAccent
            : Colors.white;

        list2.add(
          Container(
            width: _context.screenSize.width,
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            child: DefaultTextStyle(
              style: TextStyle(color: color),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(spendMonthDetailState[i].item[j].item),
                  Text(spendMonthDetailState[i]
                      .item[j]
                      .price
                      .toString()
                      .toCurrency()),
                ],
              ),
            ),
          ),
        );
      }

      if (creditSpendMap[spendMonthDetailState[i].date.yyyymmdd] != null) {
        final creditItemList =
            creditSpendMap[spendMonthDetailState[i].date.yyyymmdd];

        for (var j = 0; j < creditItemList!.length; j++) {
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
                style: const TextStyle(color: Color(0xFFFB86CE)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        creditItemList[j].item,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          creditItemList[j].price.toCurrency(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }

      final youbi =
          _utility.getYoubi(youbiStr: spendMonthDetailState[i].date.youbiStr);

      final sum = getSum(
        date: spendMonthDetailState[i].date.yyyymmdd,
        everydayState: moneyEverydayState,
      );

      list.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            color: _utility.getYoubiColor(
              date: spendMonthDetailState[i].date,
              youbiStr: spendMonthDetailState[i].date.youbiStr,
              holiday: holidayState.data,
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${spendMonthDetailState[i].date.yyyymmdd}（$youbi）',
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text((sum == '') ? '0' : sum.toCurrency()),
                      Text(spendMonthDetailState[i]
                          .spend
                          .toString()
                          .toCurrency()),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      children: list2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      key: PageStorageKey(uuid.v1()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: list,
        ),
      ),
    );
  }

  ///
  String getSum(
      {required String date, required List<MoneyEveryday> everydayState}) {
    for (var i = 0; i < everydayState.length; i++) {
      if (date == everydayState[i].date.yyyymmdd) {
        return everydayState[i].sum;
      }
    }

    return '';
  }
}
