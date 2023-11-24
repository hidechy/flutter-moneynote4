// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/amazon_purchase/amazon_notifier.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../utility/utility.dart';

class AmazonPage extends ConsumerWidget {
  AmazonPage({super.key, required this.date});

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

              Expanded(child: displayAmazonPurchase()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayAmazonPurchase() {
    final amazonPurchaseList = _ref.watch(amazonPurchaseProvider(date).select((value) => value.amazonPurchaseList));

    ///////////////////////////
    final mt = <String, List<int>>{};

    amazonPurchaseList.value?.forEach((element) {
      final month = DateTime.parse(element.date).mm;

      mt[month] = [];
    });

    amazonPurchaseList.value?.forEach((element) {
      final month = DateTime.parse(element.date).mm;

      mt[month]?.add(element.price.toInt());
    });

    // amazonPurchaseList
    //   ..when(
    //     data: (value) => value.forEach((element) {
    //       final month = DateTime.parse(element.date).mm;
    //
    //       mt[month] = [];
    //     }),
    //     error: (error, stackTrace) => Container(),
    //     loading: Container.new,
    //   )

/*
amazonPurchaseState.forEach((element) {
final month = DateTime.parse(element.date).mm;

mt[month] = [];
});
*/
    // ..when(
    //   data: (value) => value.forEach((element) {
    //     final month = DateTime.parse(element.date).mm;
    //
    //     mt[month]?.add(element.price.toInt());
    //   }),
    //   error: (error, stackTrace) => Container(),
    //   loading: Container.new,
    // );

/*
amazonPurchaseState.forEach((element) {
final month = DateTime.parse(element.date).mm;

mt[month]?.add(element.price.toInt());
});
*/

    final monthTotal = <String, int>{};

    var keepMonth = '';

    var ttl = 0;
    var yTtl = 0;
    mt.forEach((key, value) {
      if (key != keepMonth) {
        ttl = 0;
      }

      value.forEach((element) {
        ttl += element;

        yTtl += element;
      });

      monthTotal[key] = ttl;

      keepMonth = key;
    });

    ///////////////////////////

    return amazonPurchaseList.when(
      data: (value) {
        final list = <Widget>[];

        keepMonth = '';

        value.forEach((element) {
          final month = DateTime.parse(element.date).mm;

          if (month != keepMonth) {
            list.add(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Container(
                    width: _context.screenSize.width / 5,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: _utility.getLeadingBgColor(month: month),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(monthTotal[month].toString().toCurrency()),
                  ),
                ],
              ),
            );
          }

          list.add(
            Container(
              width: _context.screenSize.width,
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.8)),
                      color: _utility.getLeadingBgColor(month: month),
                    ),
                    child: Text(month),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(element.item),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Row(
                              children: [
                                Text(element.price.toCurrency()),
                                const SizedBox(width: 10),
                                const Text('/'),
                                const SizedBox(width: 10),
                                Text(element.date),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );

          keepMonth = month;
        });

        return SingleChildScrollView(
          child: Column(
            children: [
              Column(children: list),
              Divider(thickness: 3, color: Colors.white.withOpacity(0.2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Text(yTtl.toString().toCurrency(), style: const TextStyle(color: Colors.yellowAccent)),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*
    amazonPurchaseState.forEach((element) {
      final month = DateTime.parse(element.date).mm;

      if (month != keepMonth) {
        list.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Container(
                width: _context.screenSize.width / 5,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: _utility.getLeadingBgColor(month: month),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(monthTotal[month].toString().toCurrency()),
              ),
            ],
          ),
        );
      }

      list.add(
        Container(
          width: _context.screenSize.width,
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.8)),
                  color: _utility.getLeadingBgColor(month: month),
                ),
                child: Text(month),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(element.item),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Row(
                          children: [
                            Text(element.price.toCurrency()),
                            const SizedBox(width: 10),
                            const Text('/'),
                            const SizedBox(width: 10),
                            Text(element.date),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      keepMonth = month;
    });
    */

    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       Column(children: list),
    //       Divider(thickness: 3, color: Colors.white.withOpacity(0.2)),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Container(),
    //           Text(yTtl.toString().toCurrency(), style: const TextStyle(color: Colors.yellowAccent)),
    //         ],
    //       ),
    //       const SizedBox(height: 20),
    //     ],
    //   ),
    // );
  }
}
