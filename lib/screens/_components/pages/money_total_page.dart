// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../utility/utility.dart';
import '../../../viewmodel/holiday_notifier.dart';
import '../../../viewmodel/money_notifier.dart';

class MoneyTotalPage extends ConsumerWidget {
  MoneyTotalPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  final autoScrollController = AutoScrollController();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final moneyEverydayState = _ref.watch(moneyEverydayProvider);

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
                children: [
                  GestureDetector(
                    onTap: () {
                      autoScrollController.scrollToIndex(moneyEverydayState.length);
                    },
                    child: const Icon(Icons.arrow_downward),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      autoScrollController.scrollToIndex(0);
                    },
                    child: const Icon(Icons.arrow_upward),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(child: displayMoneyTotal()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayMoneyTotal() {
    final holidayState = _ref.watch(holidayProvider);

    final list = <Widget>[];

    final moneyEverydayState = _ref.watch(moneyEverydayProvider);

    for (var i = 0; i < moneyEverydayState.length; i++) {
      if (date.year == moneyEverydayState[i].date.year) {
        list.add(AutoScrollTag(
          key: ValueKey(i),
          index: i,
          controller: autoScrollController,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              color: _utility.getYoubiColor(
                date: moneyEverydayState[i].date,
                youbiStr: moneyEverydayState[i].date.youbiStr,
                holiday: holidayState.data,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${moneyEverydayState[i].date.yyyymmdd} (${moneyEverydayState[i].date.youbiStr.substring(0, 3)})'),
                Text(moneyEverydayState[i].sum.toCurrency()),
              ],
            ),
          ),
        ));
      }
    }

    return SingleChildScrollView(controller: autoScrollController, child: Column(children: list));
  }
}
