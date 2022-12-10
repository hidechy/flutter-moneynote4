// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../viewmodel/spend_notifier.dart';

class SpendYearlyAlert extends ConsumerWidget {
  SpendYearlyAlert({super.key, required this.date});

  final DateTime date;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

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
                Row(children: yearWidgetList),
                const SizedBox(height: 20),
                displaySpendYearly(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  List<Widget> makeYearWidgetList() {
    final exYmd = date.yyyymmdd.split('-');

    final selectYearState = _ref.watch(selectYearProvider);

    final yearList = <Widget>[];
    for (var i = exYmd[0].toInt(); i >= 2020; i--) {
      yearList.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(selectYearProvider.notifier)
                .setSelectYear(selectYear: i.toString());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i.toString() == selectYearState)
                  ? Colors.yellowAccent.withOpacity(0.2)
                  : null,
            ),
            child: Text(i.toString()),
          ),
        ),
      );
    }

    return yearList;
  }

  ///
  Widget displaySpendYearly() {
    final selectYearState = _ref.watch(selectYearProvider);

    final spendYearSummaryState = _ref.watch(
      spendYearSummaryProvider(
        '$selectYearState-01-01 00:00:00'.toDateTime(),
      ),
    );

    final list = <Widget>[];

    var yearSum = 0;
    var yearPercent = 0;
    for (var i = 0; i < spendYearSummaryState.length; i++) {
      var percent = '';
      if (spendYearSummaryState[i].sum > 0) {
        percent = '${spendYearSummaryState[i].percent.toString()} %';
        yearPercent += spendYearSummaryState[i].percent;
      }

      yearSum += spendYearSummaryState[i].sum;

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
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  spendYearSummaryState[i].item,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    spendYearSummaryState[i].sum.toString().toCurrency(),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(percent),
                ),
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
          children: [
            const Expanded(
              flex: 2,
              child: Text(''),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Text(yearSum.toString().toCurrency()),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Text('$yearPercent %'),
              ),
            ),
          ],
        ),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }
}

////////////////////////////////////////////////

final selectYearProvider =
    StateNotifierProvider.autoDispose<SelectYearStateNotifier, String>((ref) {
  return SelectYearStateNotifier();
});

class SelectYearStateNotifier extends StateNotifier<String> {
  SelectYearStateNotifier() : super(DateTime.now().toString().split('-')[0]);

  ///
  Future<void> setSelectYear({required String selectYear}) async {
    state = selectYear;
  }
}

////////////////////////////////////////////////
