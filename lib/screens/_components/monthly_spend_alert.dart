// ignore_for_file: must_be_immutable, sized_box_shrink_expand

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utility/utility.dart';
import '../../viewmodel/spend_notifier.dart';

class MonthlySpendAlert extends ConsumerWidget {
  MonthlySpendAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

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
            style: const TextStyle(fontSize: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
  Widget displayMonthlySpend() {
    final exDate = date.toString().split(' ');

    final spendMonthDetailState =
        _ref.watch(spendMonthDetailProvider(exDate[0]));

    final list = <Widget>[];

    for (var i = 0; i < spendMonthDetailState.length; i++) {
      final list2 = <Widget>[];

      for (var j = 0; j < spendMonthDetailState[i].item.length; j++) {
        final color = (spendMonthDetailState[i].item[j].flag.toString() == '1')
            ? Colors.lightBlueAccent
            : Colors.white;

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  spendMonthDetailState[i].item[j].item,
                  style: TextStyle(color: color),
                ),
                Text(
                  _utility.makeCurrencyDisplay(
                      spendMonthDetailState[i].item[j].price.toString()),
                  style: TextStyle(color: color),
                ),
              ],
            ),
          ),
        );
      }

      list.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(spendMonthDetailState[i].date.toString().split(' ')[0]),
                  Text(_utility.makeCurrencyDisplay(
                      spendMonthDetailState[i].spend.toString())),
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
      child: Column(
        children: list,
      ),
    );
  }
}
