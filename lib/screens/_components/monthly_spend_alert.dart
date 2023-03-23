// ignore_for_file: must_be_immutable, sized_box_shrink_expand, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../models/credit_spend_monthly.dart';
import '../../models/money_everyday.dart';
import '../../models/zero_use_date.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/monthly_spend/monthly_spend_state.dart';
import '../../utility/utility.dart';
import '../../viewmodel/bank_notifier.dart';
import '../../viewmodel/benefit_notifier.dart';
import '../../viewmodel/credit_notifier.dart';
import '../../viewmodel/holiday_notifier.dart';
import '../../viewmodel/money_notifier.dart';
import '../../viewmodel/spend_notifier.dart';
import '../../viewmodel/timeplace_notifier.dart';
import '../monthly_spend_check_screen.dart';
import '_money_dialog.dart';
import 'monthly_spend_graph_alert.dart';
import 'spend_alert.dart';

class MonthlySpendAlert extends ConsumerWidget {
  MonthlySpendAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

  final Utility _utility = Utility();

  List<String> timeplaceDateList = [];

  Map<String, List<CreditSpendMonthly>> creditSpendMap = {};

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    getMonthlyTimeplaceDate();

    getNext2MonthCreditSpend();

    final deviceInfoState = ref.read(deviceInfoProvider);

    final spendMonthDetailState = ref.watch(spendMonthDetailProvider(date));

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: spendMonthDetailState.saving,
              child: SingleChildScrollView(
                child: DefaultTextStyle(
                  style: const TextStyle(fontSize: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Container(width: context.screenSize.width),

                      //----------//
                      if (deviceInfoState.model == 'iPhone')
                        _utility.getFileNameDebug(name: runtimeType.toString()),
                      //----------//

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
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
                                    builder: (context) =>
                                        MonthlySpendCheckScreen(date: date),
                                  ),
                                );
                              },
                              child: const Icon(Icons.check_box),
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
            if (spendMonthDetailState.saving)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
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

    creditSpendMonthlyState1.forEach((element) {
      if (keepDate != element.date.yyyymmdd) {
        list = [];
      }

      if (date.yyyymm == element.date.yyyymm) {
        list.add(element);
      }

      if (list.isNotEmpty) {
        creditSpendMap[element.date.yyyymmdd] = list;
      }

      keepDate = element.date.yyyymmdd;
    });
    //---------------------//

    //---------------------//

    final after2 = _utility.makeSpecialDate(
        date: date, usage: 'month', plusminus: 'plus', num: 2);

    final creditSpendMonthlyState2 =
        _ref.watch(creditSpendMonthlyProvider(after2!));

    list = <CreditSpendMonthly>[];
    keepDate = '';

    creditSpendMonthlyState2.forEach((element) {
      if (keepDate != element.date.yyyymmdd) {
        list = [];
      }

      if (date.yyyymm == element.date.yyyymm) {
        list.add(element);
      }

      if (list.isNotEmpty) {
        creditSpendMap[element.date.yyyymmdd] = list;
      }

      keepDate = element.date.yyyymmdd;
    });
    //---------------------//
  }

  ///
  Widget displayMonthlySpend() {
    final spendMonthDetailState = _ref.watch(spendMonthDetailProvider(date));

    final holidayState = _ref.watch(holidayProvider);

    final benefitState = _ref.watch(benefitProvider);

    final bankMoveState = _ref.watch(bankMoveProvider);

    final spendZeroUseDateState = _ref.watch(spendZeroUseDateProvider);

    final moneyEverydayState = _ref.watch(moneyEverydayProvider);

    final everydayStateMap = makeEverydayStateMap(state: moneyEverydayState);

    final list = <Widget>[];

    //forで仕方ない
    for (var i = 0; i < spendMonthDetailState.list.length; i++) {
      //--------------------------------------------- list2
      final list2 = <Widget>[];

      var daySum = 0;

      spendMonthDetailState.list[i].item.forEach((element) {
        final color = (element.flag.toString() == '1')
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
              style: TextStyle(color: color, fontSize: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(element.item),
                  Text(element.price.toString().toCurrency()),
                ],
              ),
            ),
          ),
        );

        daySum += element.price.toString().toInt();
      });

      if (creditSpendMap[spendMonthDetailState.list[i].date.yyyymmdd] != null) {
        creditSpendMap[spendMonthDetailState.list[i].date.yyyymmdd]!
            .forEach((element) {
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
                style: const TextStyle(
                  color: Color(0xFFFB86CE),
                  fontSize: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        child: Text(element.price.toCurrency()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      }

      //////////////////////////////////////////////////////////////////

      benefitState.forEach((element) {
        if (spendMonthDetailState.list[i].date.yyyymmdd ==
            element.date.yyyymmdd) {
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
                style: const TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text(
                        'benefit',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(element.salary.toCurrency()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      });

      //////////////////////////////////////////////////////////////////

      //////////////////////////////////////////////////////////////////

      bankMoveState.forEach((element) {
        if (spendMonthDetailState.list[i].date.yyyymmdd ==
            element.date.yyyymmdd) {
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
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Bank Move - ${element.bank} // ${element.flag == 0 ? 'out' : 'in'}',
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
        }
      });

      //////////////////////////////////////////////////////////////////

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

      list.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
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
  Widget getMidashiDate(
      MonthlySpendState spendMonthDetailState,
      int i,
      String youbi,
      int spendZeroFlag,
      MoneyEveryday? sum,
      int diff,
      int daySum) {
    return Row(
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
                color: (timeplaceDateList
                        .contains(spendMonthDetailState.list[i].date.yyyymmdd))
                    ? Colors.yellowAccent.withOpacity(0.8)
                    : Colors.white.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    );
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
  Map<String, MoneyEveryday> makeEverydayStateMap(
      {required List<MoneyEveryday> state}) {
    final map = <String, MoneyEveryday>{};

    for (var i = 0; i < state.length; i++) {
      map[state[i].date.yyyymmdd] = state[i];
    }

    return map;
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
  void getMonthlyTimeplaceDate() {
    final monthlyTimeplaceState = _ref.watch(monthlyTimeplaceProvider(date));

    monthlyTimeplaceState.forEach((element) {
      timeplaceDateList.add(element.date.yyyymmdd);
    });
  }
}
