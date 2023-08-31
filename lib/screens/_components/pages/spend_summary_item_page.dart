// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../utility/utility.dart';
import '../../../viewmodel/spend_notifier.dart';
import '../_money_dialog.dart';
import '../credit_alert.dart';

class SpendSummaryItemPage extends ConsumerWidget {
  SpendSummaryItemPage({super.key, required this.date});

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

    //==================================//
    final spendMonthSummaryState = _ref.watch(spendMonthSummaryProvider(date));

    var sum = 0;
    spendMonthSummaryState.forEach((element) {
      sum += element.sum;
    });

    //==================================//

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
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
                Container(),
                Text(
                  sum.toString().toCurrency(),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: displaySpendSummaryItemData(),
            ),
          ],
        ),
      ),
    );
  }

  ///
  Widget displaySpendSummaryItemData() {
    final list = <Widget>[];

    final spendMonthSummaryState = _ref.watch(spendMonthSummaryProvider(date));

    /////////////////////////////////////

    final percentageList = <double>[];
    for (var i = 0; i < spendMonthSummaryState.length; i++) {
      final spend = spendMonthSummaryState[i];
      percentageList.add(spend.percent.toDouble());
    }

    percentageList.sort((a, b) => -1 * a.compareTo(b));

    var topPercentageList = <double>[];

    if (percentageList.isNotEmpty && percentageList.length > 5) {
      topPercentageList = percentageList.sublist(0, 5);
    }

    /////////////////////////////////////

    spendMonthSummaryState.forEach((element) {
      var textColor = (element.sum >= 10000) ? Colors.yellowAccent : Colors.white;

      textColor = getTextColor(item: element.item);

      list.add(
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          margin: const EdgeInsets.only(bottom: 3),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 12,
              color: textColor,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(element.item),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(element.sum.toString().toCurrency()),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      '${element.percent} %',
                      style: TextStyle(
                        color: (topPercentageList.contains(element.percent.toDouble())) ? Colors.redAccent : textColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                getLinkIcon(item: element.item),
              ],
            ),
          ),
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }

  ///
  Color getTextColor({required String item}) {
    final fixPaymentValue = _utility.getFixPaymentValue();

    switch (fixPaymentValue[item]) {
      case 1:
        return Colors.orangeAccent;
      case 2:
        return Colors.greenAccent;
      case 3:
        return Colors.lightBlueAccent;
    }

    return Colors.white;
  }

  ///
  Widget getLinkIcon({required String item}) {
    switch (item) {
      case 'credit':
        return GestureDetector(
          onTap: () {
            MoneyDialog(
              context: _context,
              widget: CreditAlert(date: date),
            );
          },
          child: const Icon(
            Icons.credit_card,
            size: 14,
          ),
        );
      default:
        return const Icon(
          Icons.check_box_outline_blank,
          color: Colors.transparent,
          size: 14,
        );
    }
  }
}
