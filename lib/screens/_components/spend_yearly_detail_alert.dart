import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../viewmodel/credit_notifier.dart';

class SpendYearlyDetailAlert extends ConsumerWidget {
  SpendYearlyDetailAlert({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final monthWidgetList = makeMonthWidgetList();

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                Text(
                  date.yyyy,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: monthWidgetList),
                ),
                const SizedBox(height: 20),
                displaySpendYearlyDetail(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  List<Widget> makeMonthWidgetList() {
    final exYmd = date.yyyymmdd.split('-');

    final selectMonthState = _ref.watch(selectMonthProvider);

    final monthList = <Widget>[];
    for (var i = 1; i <= 12; i++) {
      monthList.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(selectMonthProvider.notifier)
                .setSelectMonth(selectMonth: i.toString());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i.toString() == selectMonthState)
                  ? Colors.yellowAccent.withOpacity(0.2)
                  : null,
            ),
            child: Text(i.toString().padLeft(2, '0')),
          ),
        ),
      );
    }

    return monthList;
  }

  ///
  Widget displaySpendYearlyDetail() {
    final selectMonthState = _ref.watch(selectMonthProvider);

    final list = <Widget>[];

    if (selectMonthState != '') {
      final creditSummaryDetailState = _ref.watch(creditSummaryDetailProvider(
          '${date.yyyy}-${selectMonthState.padLeft(2, '0')}-01 00:00:00'
              .toDateTime()));

      var sum = 0;
      for (var i = 0; i < creditSummaryDetailState.length; i++) {
        sum += creditSummaryDetailState[i].price;

        var priceColor = (creditSummaryDetailState[i].price >= 10000)
            ? Colors.yellowAccent
            : Colors.white;

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
                  creditSummaryDetailState[i].item,
                  style: TextStyle(color: priceColor),
                ),
                Text(
                  creditSummaryDetailState[i].price.toString().toCurrency(),
                  style: TextStyle(color: priceColor),
                ),
              ],
            ),
          ),
        );
      }

      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            color: Colors.yellowAccent.withOpacity(0.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(''),
              Text(sum.toString().toCurrency()),
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

////////////////////////////////////////////////

final selectMonthProvider =
    StateNotifierProvider.autoDispose<SelectMonthStateNotifier, String>((ref) {
  return SelectMonthStateNotifier();
});

class SelectMonthStateNotifier extends StateNotifier<String> {
  SelectMonthStateNotifier() : super('');

  ///
  Future<void> setSelectMonth({required String selectMonth}) async {
    state = selectMonth;
  }
}

////////////////////////////////////////////////
