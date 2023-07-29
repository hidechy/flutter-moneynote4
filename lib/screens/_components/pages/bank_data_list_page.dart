// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../utility/utility.dart';
import '../../../viewmodel/bank_notifier.dart';
import '../../../viewmodel/holiday_notifier.dart';

class BankDataListPage extends ConsumerWidget {
  BankDataListPage({super.key, required this.name});

  final String name;

  final Utility _utility = Utility();

  final autoScrollController = AutoScrollController();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final bankName = _utility.getBankName();

    final bankAllState = ref.watch(bankAllProvider(name));

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bankName[name].toString()),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      autoScrollController.scrollToIndex(bankAllState.length);
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
            ],
          ),
          Divider(
            color: Colors.yellowAccent.withOpacity(0.2),
            thickness: 5,
          ),
          Expanded(child: displayBank()),
        ],
      ),
    );
  }

  ///
  Widget displayBank() {
    final holidayState = _ref.watch(holidayProvider);

    final bankAllState = _ref.watch(bankAllProvider(name));

    final list = <Widget>[];

    //forで仕方ない
    for (var i = 0; i < bankAllState.length; i++) {
      final youbi = _utility.getYoubi(youbiStr: bankAllState[i].date.youbiStr);

      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            color: _utility.getYoubiColor(
              date: bankAllState[i].date,
              youbiStr: bankAllState[i].date.youbiStr,
              holiday: holidayState.data,
            ),
          ),
          child: AutoScrollTag(
            key: ValueKey(i),
            index: i,
            controller: autoScrollController,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${bankAllState[i].date.yyyymmdd}（$youbi）'),
                Row(
                  children: [
                    Text(bankAllState[i].price.toCurrency()),
                    const SizedBox(width: 20),
                    getBankMark(mark: bankAllState[i].mark),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      controller: autoScrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }

  ///
  Widget getBankMark({required String mark}) {
    switch (mark) {
      case 'up':
        return const Icon(
          Icons.arrow_upward,
          color: Colors.greenAccent,
        );
      case 'down':
        return const Icon(
          Icons.arrow_downward,
          color: Colors.redAccent,
        );
      default:
        return const Icon(
          Icons.crop_square,
          color: Colors.transparent,
        );
    }
  }
}
