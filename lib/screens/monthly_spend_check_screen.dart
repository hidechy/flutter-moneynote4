// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../models/credit_spend_monthly.dart';
import '../utility/utility.dart';
import '../viewmodel/credit_notifier.dart';
import '../viewmodel/spend_notifier.dart';

class MonthlySpendCheckScreen extends ConsumerWidget {
  MonthlySpendCheckScreen({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Map<String, List<CreditSpendMonthly>> creditSpendMap = {};

  List<Map<String, String>> listItem = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    getNext2MonthCreditSpend();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(width: context.screenSize.width),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date.yyyymm),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  color: Colors.white.withOpacity(0.4),
                ),
                Expanded(
                  child: displayMonthlySpendCheckList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  void getNext2MonthCreditSpend() {
    var list = <CreditSpendMonthly>[];
    var keepDate = '';

    //---------------------//
    final after1 = _utility.makeSpecialDate(
        date: date, usage: 'month', plusminus: 'plus', num: 1);

    final creditSpendMonthlyState1 =
        _ref.watch(creditSpendMonthlyProvider(after1!));

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

    final after2 = _utility.makeSpecialDate(
        date: date, usage: 'month', plusminus: 'plus', num: 2);

    final creditSpendMonthlyState2 =
        _ref.watch(creditSpendMonthlyProvider(after2!));

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
  Widget displayMonthlySpendCheckList() {
    listItem = [];

    final spendMonthDetailState = _ref.watch(spendMonthDetailProvider(date));

    spendMonthDetailState.list.forEach((element) {
      element.item.forEach((element2) {
        if (element2.price.toString().toInt() > 0) {
          listItem.add({
            'date': element.date.yyyymmdd,
            'item': element2.item,
            'price': element2.price.toString().toCurrency(),
            'type': 'daily',
          });
        }
      });

      if (creditSpendMap[element.date.yyyymmdd] != null) {
        creditSpendMap[element.date.yyyymmdd]?.forEach((element3) {
          listItem.add({
            'date': element3.date.yyyymmdd,
            'item': element3.item,
            'price': element3.price.toCurrency(),
            'type': 'credit',
          });
        });
      }
    });

    final list = <Widget>[];
    var keepDate = '';
    for (var i = 0; i < listItem.length; i++) {
      if (keepDate != listItem[i]['date']) {
        if (i != 0) {
          list.add(const SizedBox(height: 60));
        }
      }

      final color = (listItem[i]['type'] == 'credit')
          ? const Color(0xFFFB86CE)
          : Colors.white;

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
          ),
          child: DefaultTextStyle(
            style: TextStyle(color: color),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(listItem[i]['date']!),
                    Text(listItem[i]['price']!),
                  ],
                ),
                Text(listItem[i]['item']!),
              ],
            ),
          ),
        ),
      );

      keepDate = listItem[i]['date']!;
    }

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
