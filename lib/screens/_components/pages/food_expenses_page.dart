// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../models/spend_month_summary.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/seiyu_purchase/seiyu_purchase_notifier.dart';
import '../../../state/spend/spend_notifier.dart';
import '../../../utility/utility.dart';

class FoodExpensesPage extends ConsumerWidget {
  FoodExpensesPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Map<String, int> seiyuPriceMap = {};
  int seiyuTotalPrice = 0;

  List<SpendMonthSummary> spendMonthSummaryList = [];

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
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(width: context.screenSize.width),

                //----------//
                if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                displayFoodExpenses(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayFoodExpenses() {
    //
    //
    // final spendMonthSummaryState = _ref.watch(spendMonthSummaryProvider(date));
    //
    // makeFoodExpensesList(state: spendMonthSummaryState);
    //
    //

    makeFoodExpensesList();

    // final seiyuAllState = _ref.watch(seiyuAllProvider(date));
    // makeSeiyuTotal(state: seiyuAllState);
    //
    //
    //
    //

    makeSeiyuTotal();

    var ttl = 0;

    final list = <Widget>[];

    for (var i = 0; i < spendMonthSummaryList.length; i++) {
      list.add(
        Container(
          width: _context.screenSize.width,
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(spendMonthSummaryList[i].item),
              Text(spendMonthSummaryList[i].sum.toString().toCurrency()),
            ],
          ),
        ),
      );

      ttl += spendMonthSummaryList[i].sum;
    }

    final list2 = <Widget>[];
    seiyuPriceMap.forEach((key, value) {
      list2.add(
        Row(
          children: [
            SizedBox(
              width: _context.screenSize.width / 6,
              child: Text(
                DateTime(key.split('-')[0].toInt(), key.split('-')[1].toInt(), key.split('-')[2].toInt()).mmdd,
              ),
            ),
            Container(
              width: _context.screenSize.width / 6,
              alignment: Alignment.topRight,
              child: Text(value.toString().toCurrency()),
            ),
          ],
        ),
      );
    });

    list.add(
      Container(
        width: _context.screenSize.width,
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('西友'),
                Row(children: [const SizedBox(width: 10), Column(children: list2)]),
              ],
            ),
            Text(seiyuTotalPrice.toString().toCurrency()),
          ],
        ),
      ),
    );

    ttl += seiyuTotalPrice;

    list.add(
      Container(
        width: _context.screenSize.width,
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
          color: Colors.yellowAccent.withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const Text(''), Text(ttl.toString().toCurrency())],
        ),
      ),
    );

    return SingleChildScrollView(
      child: DefaultTextStyle(style: const TextStyle(fontSize: 12), child: Column(children: list)),
    );
  }

  ///
  void makeFoodExpensesList() {
//    {required List<SpendMonthSummary> state}

    spendMonthSummaryList = [];

    //
    //
    // final spendMonthSummaryState = _ref.watch(spendMonthSummaryProvider(date));
    //
    // makeFoodExpensesList(state: spendMonthSummaryState);
    //
    //

    final smSummaryList = _ref.watch(spendMonthSummaryProvider(date).select((value) => value.spendMonthSummaryList));

    smSummaryList.value?.forEach((element) {
      if (['食費', '牛乳代', '弁当代'].contains(element.item)) {
        spendMonthSummaryList.add(element);
      }
    });

    // for (var i = 0; i < state.length; i++) {
    //   if (['食費', '牛乳代', '弁当代'].contains(state[i].item)) {
    //     spendMonthSummaryList.add(state[i]);
    //   }
    // }
    //
    //
  }

  ///
  void makeSeiyuTotal() {
//    {required List<SeiyuPurchase> state}

    // final seiyuAllState = _ref.watch(seiyuAllProvider(date));
    // makeSeiyuTotal(state: seiyuAllState);
    //

    final seiyuPurchaseList = _ref.watch(seiyuAllProvider(date).select((value) => value.seiyuPurchaseList));

    seiyuTotalPrice = 0;

    final reg = RegExp('非食品');

    var keepDate = '';
    var ttl = 0;

    seiyuPurchaseList.when(
      data: (value) {
        for (var i = 0; i < value.length; i++) {
          if (date.yyyymm == DateTime.parse(value[i].date).yyyymm) {
            if (value[i].date != keepDate) {
              ttl = 0;
            }

            final match = reg.firstMatch(value[i].item);
            if (match != null) {
              continue;
            }

            seiyuTotalPrice += value[i].price.toInt();

            ttl += value[i].price.toInt();

            seiyuPriceMap[value[i].date] = ttl;

            keepDate = value[i].date;
          }
        }
      },
      error: (error, stackTrace) => Container(),
      loading: Container.new,
    );

    //
    //
    // for (var i = 0; i < state.length; i++) {
    //   if (date.yyyymm == DateTime.parse(state[i].date).yyyymm) {
    //     if (state[i].date != keepDate) {
    //       ttl = 0;
    //     }
    //
    //     final match = reg.firstMatch(state[i].item);
    //     if (match != null) {
    //       continue;
    //     }
    //
    //     seiyuTotalPrice += state[i].price.toInt();
    //
    //     ttl += state[i].price.toInt();
    //
    //     seiyuPriceMap[state[i].date] = ttl;
    //
    //     keepDate = state[i].date;
    //   }
    // }
    //
    //
    //
  }
}
