// ignore_for_file: must_be_immutable, sized_box_shrink_expand

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/utility/utility.dart';

import '../../viewmodel/spend_viewmodel.dart';

class SpendAlert extends ConsumerWidget {
  SpendAlert({super.key, required this.date, required this.diff});

  final DateTime date;
  final String diff;

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final size = MediaQuery.of(context).size;

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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    date.toString().split(' ')[0],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _utility.makeCurrencyDisplay(diff),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.2,
                  child: displaySpendItem(),
                ),
                Divider(
                  color: Colors.yellowAccent.withOpacity(0.2),
                  thickness: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displaySpendItem() {
    final spendItemDailyState =
        _ref.watch(spendItemDailyProvider(date.toString().split(' ')[0]));

    final list = <Widget>[];

    for (var i = 0; i < spendItemDailyState.item.length; i++) {
      final exValue = spendItemDailyState.item[i].split('|');

      final color = getRowTextColor(kind: exValue[1]);

      list.add(
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
                exValue[0],
                style: TextStyle(color: color),
              ),
              Text(
                _utility.makeCurrencyDisplay(exValue[2]),
                style: TextStyle(color: color),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }

  ///
  Color getRowTextColor({required String kind}) {
    switch (kind) {
      case '(bank)':
        return Colors.lightBlueAccent;
      case '(income)':
        return Colors.yellowAccent;
      default:
        return Colors.white;
    }
  }
}
