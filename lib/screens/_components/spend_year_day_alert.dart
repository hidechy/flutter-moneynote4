// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';
import 'package:moneynote4/screens/_components/_money_dialog.dart';
import 'package:moneynote4/screens/_components/spend_alert.dart';

import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/holiday_notifier.dart';
import '../../viewmodel/money_notifier.dart';
import '../../viewmodel/spend_notifier.dart';

class SpendYearDayAlert extends ConsumerWidget {
  SpendYearDayAlert({super.key, required this.date, required this.spend});

  final DateTime date;
  final int spend;

  final Utility _utility = Utility();

  Map<String, int> everydayMoney = {};

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
                  Text(date.yyyymmdd),
                  Text(
                    spend.toString().toCurrency(),
                    style: const TextStyle(color: Color(0xFFFBB6CE)),
                  ),
                ],
              ),

              Divider(
                color: Colors.white.withOpacity(0.4),
                thickness: 2,
              ),

              Expanded(
                child: displaySpendYearDay(),
              ),
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

    final spendYearDayState = _ref.watch(spendYearDayProvider(date));

    spendYearDayState.forEach((element) {
      if (date.isBefore(element.date)) {
      } else {
        list.add(
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              color: _utility.getYoubiColor(
                date: element.date,
                youbiStr: element.date.youbiStr,
                holiday: holidayState.data,
              ),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${element.date.yyyymmdd}（${_utility.getYoubi(youbiStr: element.date.youbiStr)}）',
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: (everydayMoney[element.date.yyyymmdd] == null)
                          ? Container()
                          : Text(
                              everydayMoney[element.date.yyyymmdd].toString().toCurrency(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        element.spend.toString().toCurrency(),
                        style: TextStyle(
                          color: (element.spend > 10000) ? Colors.yellowAccent : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      MoneyDialog(
                        context: _context,
                        widget: SpendAlert(
                          date: element.date,
                          diff: element.spend.toString(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }

  ///
  void makeEverydayMoney() {
    everydayMoney = {};

    final moneyEverydayState = _ref.watch(moneyEverydayProvider);

    moneyEverydayState.forEach((element) {
      everydayMoney[element.date.yyyymmdd] = element.sum.toInt();
    });
  }
}
