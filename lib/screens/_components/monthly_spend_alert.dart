// ignore_for_file: must_be_immutable, sized_box_shrink_expand

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../models/credit_spend_monthly.dart';
import '../../models/holiday.dart';
import '../../models/youbi.dart';
import '../../viewmodel/credit_notifier.dart';
import '../../viewmodel/holiday_notifier.dart';
import '../../viewmodel/spend_notifier.dart';
import '../../viewmodel/youbi_notifier.dart';

class MonthlySpendAlert extends ConsumerWidget {
  MonthlySpendAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

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

    final youbiState = _ref.watch(youbiProvider(date));

    final holidayState = _ref.watch(holidayProvider);

    final list = <Widget>[];

    for (var i = 0; i < spendMonthDetailState.length; i++) {
      final list2 = <Widget>[];

      final youbi = getYoubi(
        date: spendMonthDetailState[i].date.yyyymmdd,
        state: youbiState,
      );

      final holiday = getHoliday(
        date: spendMonthDetailState[i].date.yyyymmdd,
        state: holidayState,
      );

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
                        )),
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

      list.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: getBoxColor(
                youbi: youbi,
                holiday: holiday,
              )),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${spendMonthDetailState[i].date.yyyymmdd}（${youbi.youbi}）',
                  ),
                  Text(spendMonthDetailState[i].spend.toString().toCurrency()),
                ],
              ),
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
  Youbi getYoubi({required String date, required List<Youbi> state}) {
    for (var i = 0; i < state.length; i++) {
      if (state[i].date == date) {
        return state[i];
      }
    }

    return Youbi(
      date: '',
      youbi: '',
      youbiNum: 0,
    );
  }

  ///
  Color getBoxColor({required Youbi youbi, required int holiday}) {
    var color = Colors.black.withOpacity(0.2);

    switch (youbi.youbiNum) {
      case 0:
        color = Colors.redAccent.withOpacity(0.2);
        break;
      case 6:
        color = Colors.blueAccent.withOpacity(0.2);
        break;
      default:
        color = Colors.black.withOpacity(0.2);
        break;
    }

    if (holiday == 1) {
      color = Colors.greenAccent.withOpacity(0.2);
    }

    return color;
  }

  ///
  int getHoliday({required String date, required Holiday state}) {
    var answer = 0;

    for (var i = 0; i < state.data.length; i++) {
      if (state.data[i].toString().split(' ')[0] == date) {
        answer = 1;
      }
    }

    return answer;
  }
}
