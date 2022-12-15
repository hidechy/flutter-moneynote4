// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/spend_notifier.dart';
import '_money_dialog.dart';
import 'credit_yearly_detail_alert.dart';

class SpendYearlyAlert extends ConsumerWidget {
  SpendYearlyAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

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
                child: Text(
                  spendYearSummaryState[i].item,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        spendYearSummaryState[i].sum.toString().toCurrency(),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(percent),
                      const SizedBox(width: 20),
                      getLinkIcon(item: spendYearSummaryState[i].item),
                    ],
                  ),
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
              child: Text(''),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(yearSum.toString().toCurrency()),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('$yearPercent %'),
                    const SizedBox(width: 20),
                    getLinkIcon(item: ''),
                  ],
                ),
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

  ///
  Widget getLinkIcon({required String item}) {
    final selectYearState = _ref.watch(selectYearProvider);

    switch (item) {
      case 'credit':
        return GestureDetector(
          onTap: () {
            MoneyDialog(
              context: _context,
              widget: CreditYearlyDetailAlert(
                  date: '$selectYearState-01-01 00:00:00'.toDateTime()),
            );
          },
          child: const Icon(Icons.credit_card),
        );
      default:
        return Icon(
          Icons.check_box_outline_blank,
          color: Colors.black.withOpacity(0.1),
        );
    }
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
