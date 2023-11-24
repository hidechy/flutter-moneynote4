// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/spend/spend_notifier.dart';
import '../../../utility/utility.dart';
import '../_money_dialog.dart';
import '../spend_summary_comparison_alert.dart';

class SpendSummaryPage extends ConsumerWidget {
  SpendSummaryPage({super.key, required this.date});

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

              Container(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    MoneyDialog(
                      context: context,
                      widget: SpendSummaryComparisonAlert(),
                    );
                  },
                  child: const Icon(Icons.info_outline),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: displaySpendSummary(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displaySpendSummary() {
    final oneWidth = _context.screenSize.width / 6.5;

    //--------------------------------------------------//
    final itemSumMap = <String, int>{};

    // final spendSummaryState = _ref.watch(spendSummaryProvider(date));
    //
    // spendSummaryState.list.forEach((element) {
    //   var sum = 0;
    //
    //   element.list.forEach((element2) {
    //     sum += element2.price.toString().toInt();
    //   });
    //
    //   itemSumMap[element.item] = sum;
    // });
    //
    //
    //

    final spendSummaryList = _ref.watch(spendSummaryProvider(date).select((value) => value.spendSummaryList));

    spendSummaryList.value?.forEach((element) {
      var sum = 0;

      element.list.forEach((element2) {
        sum += element2.price.toString().toInt();
      });

      itemSumMap[element.item] = sum;
    });

    //--------------------------------------------------//

    final list = <Widget>[];

    var total = 0;

    return spendSummaryList.when(
      data: (value) {
        for (var i = 0; i < value.length; i++) {
          final list2 = <Widget>[];

          value[i].list.forEach((element) {
            list2.add(
              Container(
                width: oneWidth,
                margin: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.3))),
                child: Stack(
                  children: [
                    Text(element.month, style: const TextStyle(color: Colors.grey)),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(element.price.toString().toCurrency()),
                    ),
                  ],
                ),
              ),
            );
          });

          total += itemSumMap[value[i].item].toString().toInt();

          if (itemSumMap[value[i].item].toString() == '0') {
            continue;
          }

          list.add(
            Container(
              width: _context.screenSize.width,
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _context.screenSize.width,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.indigo.withOpacity(0.8), Colors.transparent],
                        stops: const [0.7, 1],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(value[i].item, overflow: TextOverflow.ellipsis)),
                        Container(
                          width: 60,
                          alignment: Alignment.topRight,
                          child: Text(
                            itemSumMap[value[i].item].toString().toCurrency(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(children: list2),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.topRight,
                    child: Text(
                      total.toString().toCurrency(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*






    //forで仕方ない
    for (var i = 0; i < spendSummaryState.list.length; i++) {
      final list2 = <Widget>[];

      spendSummaryState.list[i].list.forEach((element) {
        list2.add(
          Container(
            width: oneWidth,
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Stack(
              children: [
                Text(
                  element.month,
                  style: const TextStyle(color: Colors.grey),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(element.price.toString().toCurrency()),
                ),
              ],
            ),
          ),
        );
      });

      total += itemSumMap[spendSummaryState.list[i].item].toString().toInt();

      if (itemSumMap[spendSummaryState.list[i].item].toString() == '0') {
        continue;
      }

      list.add(
        Container(
          width: _context.screenSize.width,
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: _context.screenSize.width,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo.withOpacity(0.8), Colors.transparent],
                    stops: const [0.7, 1],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        spendSummaryState.list[i].item,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: 60,
                      alignment: Alignment.topRight,
                      child: Text(
                        itemSumMap[spendSummaryState.list[i].item].toString().toCurrency(),
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(children: list2),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.topRight,
                child: Text(
                  total.toString().toCurrency(),
                  style: const TextStyle(color: Colors.grey),
                ),
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




    */
  }
}
