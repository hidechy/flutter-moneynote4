import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/money.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/holiday/holiday_notifier.dart';
import '../../state/money/money_notifier.dart';
import '../../utility/utility.dart';
import '_money_dialog.dart';

// ignore: must_be_immutable
class MoneyKindListAlert extends ConsumerWidget {
  MoneyKindListAlert({super.key, required this.date});

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
                  Text(date.yyyymm),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          final prevMonth =
                              DateTime(date.yyyymm.split('-')[0].toInt(), date.yyyymm.split('-')[1].toInt() - 1);

                          if (_context.mounted) {
                            Navigator.pop(_context);
                          }

                          if (_context.mounted) {
                            MoneyDialog(context: _context, widget: MoneyKindListAlert(date: prevMonth));
                          }
                        },
                        icon: const Icon(Icons.navigate_before),
                      ),
                      IconButton(
                        onPressed: () {
                          final nextMonth =
                              DateTime(date.yyyymm.split('-')[0].toInt(), date.yyyymm.split('-')[1].toInt() + 1);

                          if (_context.mounted) {
                            Navigator.pop(_context);
                          }

                          if (_context.mounted) {
                            MoneyDialog(context: _context, widget: MoneyKindListAlert(date: nextMonth));
                          }
                        },
                        icon: const Icon(Icons.navigate_next),
                      ),
                    ],
                  ),
                ],
              ),

              Expanded(child: _displayMoneyKindList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayMoneyKindList() {
    final holidayState = _ref.watch(holidayProvider);

    final moneyList = _ref.watch(moneyAllProvider.select((value) => value.moneyList));

    return moneyList.when(
      data: (value) {
        final list = <Widget>[];

        value.where((element) => element.date.yyyymm == date.yyyymm).forEach((element2) {
          list.add(DefaultTextStyle(
            style: const TextStyle(fontSize: 8),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    color: _utility.getYoubiColor(
                        date: element2.date, youbiStr: element2.date.youbiStr, holiday: holidayState.data),
                  ),
                  margin: const EdgeInsets.all(1),
                  padding: const EdgeInsets.all(1),
                  child: Text(element2.date.yyyymmdd),
                ),
                const SizedBox(width: 10),
                _displayCurrencyList(value: element2),
                const SizedBox(width: 10),
                _displayBankList(value: element2),
                const SizedBox(width: 10),
                _displayPayList(value: element2),
              ],
            ),
          ));
        });

        return SingleChildScrollView(scrollDirection: Axis.horizontal, child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  ///
  Widget _displayCurrencyList({required Money value}) {
    const width = 30;
    const color = Colors.transparent;

    return Row(
      children: [
        _displayCurrencyParts(value: value.yen10000, width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.yen5000, width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.yen2000, width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.yen1000, width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.yen500, width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.yen100, width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.yen50, width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.yen10, width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.yen5, width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.yen1, width: width.toDouble(), color: color),
      ],
    );
  }

  ///
  Widget _displayBankList({required Money value}) {
    const width = 50;
    final color = Colors.yellowAccent.withOpacity(0.1);

    return Row(
      children: [
        _displayCurrencyParts(value: value.bankA.toCurrency(), width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.bankB.toCurrency(), width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.bankC.toCurrency(), width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.bankD.toCurrency(), width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.bankE.toCurrency(), width: width.toDouble(), color: color),
      ],
    );
  }

  ///
  Widget _displayPayList({required Money value}) {
    const width = 50;
    final color = Colors.greenAccent.withOpacity(0.1);

    return Row(
      children: [
        _displayCurrencyParts(value: value.payA.toCurrency(), width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.payB.toCurrency(), width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.payC.toCurrency(), width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.payD.toCurrency(), width: width.toDouble(), color: color),
        _displayCurrencyParts(value: value.payE.toCurrency(), width: width.toDouble(), color: color),
      ],
    );
  }

  ///
  Widget _displayCurrencyParts({required String value, required double width, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        color: color,
      ),
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(1),
      width: width,
      alignment: Alignment.topRight,
      child: Text(value),
    );
  }
}
