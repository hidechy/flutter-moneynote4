// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/credit/credit_notifier.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../utility/utility.dart';

class CreditSummaryPage extends ConsumerWidget {
  CreditSummaryPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    // final creditSummaryState = _ref.watch(creditSummaryProvider(date));
    //
    //
    //
    //

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
        child: Stack(
          children: [
            DefaultTextStyle(
              style: const TextStyle(fontSize: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(width: context.screenSize.width),

                  //----------//
                  if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
                  //----------//

                  Expanded(
                    child: displayCreditSummary(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  Widget displayCreditSummary() {
    final oneWidth = _context.screenSize.width / 6.5;

    final itemSumMap = <String, int>{};

    final creditSummaryList = _ref.watch(creditSummaryProvider(date).select((value) => value.creditSummaryList));

    creditSummaryList.value?.forEach((element) {
      var sum = 0;
      element.list.forEach((element2) => sum += element2.price.toString().toInt());
      itemSumMap[element.item] = sum;
    });

    //
    //
    //
    //
    // final creditSummaryState = _ref.watch(creditSummaryProvider(date));
    //
    // //--------------------------------------------------//
    // final itemSumMap = <String, int>{};
    // creditSummaryState.list.forEach((element) {
    //   var sum = 0;
    //   element.list.forEach((element2) {
    //     sum += element2.price.toString().toInt();
    //   });
    //
    //   itemSumMap[element.item] = sum;
    // });
    // //--------------------------------------------------//
    //
    //
    //
    //

    final list = <Widget>[];

    var total = 0;

    return creditSummaryList.when(
      data: (value) {
        value.forEach((element) {
          final list2 = <Widget>[];
          element.list.forEach((element2) {
            list2.add(
              Container(
                width: oneWidth,
                margin: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(border: Border.all(color: Colors.white.withOpacity(0.3))),
                child: Stack(
                  children: [
                    Text(element2.month, style: const TextStyle(color: Colors.grey)),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(element2.price.toString().toCurrency()),
                    ),
                  ],
                ),
              ),
            );
          });

          total += itemSumMap[element.item].toString().toInt();

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
                        stops: const [0, 7, 1],
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(element.item, overflow: TextOverflow.ellipsis)),
                        Container(
                          width: 60,
                          alignment: Alignment.topRight,
                          child: Text(itemSumMap[element.item].toString().toCurrency()),
                        ),
                      ],
                    ),
                  ),
                  Wrap(children: list2),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.topRight,
                    child: Text(total.toString().toCurrency(), style: const TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),
          );
        });

        return SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list),
        );
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*




    creditSummaryState.list.forEach((element) {
      final list2 = <Widget>[];
      element.list.forEach((element2) {
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
                  element2.month,
                  style: const TextStyle(color: Colors.grey),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    element2.price.toString().toCurrency(),
                  ),
                ),
              ],
            ),
          ),
        );
      });

      total += itemSumMap[element.item].toString().toInt();

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
                    stops: const [0, 7, 1],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        element.item,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: 60,
                      alignment: Alignment.topRight,
                      child: Text(
                        itemSumMap[element.item].toString().toCurrency(),
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
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );





    */
  }
}
