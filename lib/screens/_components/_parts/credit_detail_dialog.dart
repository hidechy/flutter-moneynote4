// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../models/amazon_purchase.dart';
import '../../../models/credit_spend_all.dart';
import '../../../state/amazon_purchase/amazon_notifier.dart';
import '../../../state/udemy/udemy_notifier.dart';

class CreditDetailDialog extends ConsumerWidget {
  CreditDetailDialog({super.key, required this.date, required this.creditDetail});

  final DateTime date;
  final CreditSpendAll creditDetail;

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        width: context.screenSize.width - 100,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(0.8),
          ),
          color: Colors.blueGrey.withOpacity(0.3),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(creditDetail.item),
              Divider(
                color: Colors.white.withOpacity(0.3),
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(creditDetail.date.yyyymmdd),
                      Text(creditDetail.kind),
                    ],
                  ),
                  Text(creditDetail.price.toCurrency()),
                ],
              ),
              Divider(
                color: Colors.white.withOpacity(0.3),
                thickness: 2,
              ),
              // displayAmazonData(
              //     item: creditDetail.item, date: creditDetail.date),
              displayUdemyData(item: creditDetail.item, date: creditDetail.date),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayAmazonData({required String item, required DateTime date}) {
    //------------------------------------//
    final reg = RegExp('ｱﾏｿﾞﾝ');
    final reg2 = RegExp('AMAZON');

    final match = reg.firstMatch(item);
    final match2 = reg2.firstMatch(item);

    if (match == null && match2 == null) {
      return Container();
    }
    //------------------------------------//

    final list = <Widget>[];

    final list2 = <DateTime>[date, DateTime(date.year - 1, date.month)];

    final amazonMap = <String, List<AmazonPurchase>>{};

    list2.forEach((element) {
      final amazonPurchaseList = _ref.watch(
        amazonPurchaseProvider(element).select((value) => value.amazonPurchaseList),
      );

      var list3 = <AmazonPurchase>[];
      var keepDate = '';

      amazonPurchaseList.value?.forEach((element2) {
        if (element2.date != keepDate) {
          list3 = [];
        }

        list3.add(element2);

        amazonMap[element2.date] = list3;

        keepDate = element2.date;
      });

      //
      //
      // amazonPurchaseList.when(
      //   data: (value) => value.forEach((element2) {
      //     if (element2.date != keepDate) {
      //       list3 = [];
      //     }
      //
      //     list3.add(element2);
      //
      //     amazonMap[element2.date] = list3;
      //
      //     keepDate = element2.date;
      //   }),
      //   error: (error, stackTrace) => Container(),
      //   loading: Container.new,
      // );
      //
      //

      // amazonPurchaseState.forEach((element2) {
      //   if (element2.date != keepDate) {
      //     list3 = [];
      //   }
      //
      //   list3.add(element2);
      //
      //   amazonMap[element2.date] = list3;
      //
      //   keepDate = element2.date;
      // });
    });

    final oneHeight = _context.screenSize.height / 10;

    amazonMap[date.yyyymmdd]?.forEach((element) {
      list.add(
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: oneHeight),
          child: Text(element.item),
        ),
      );
    });

    return Column(children: list);
  }

  ///
  Widget displayUdemyData({required String item, required DateTime date}) {
    //------------------------------------//
    final reg = RegExp('UDEMY');

    final match = reg.firstMatch(item);

    if (match == null) {
      return Container();
    }
    //------------------------------------//

    final udemyList = _ref.watch(udemyProvider.select((value) => value.udemyList));

    return udemyList.when(
      data: (value) {
        final list = <Widget>[];

        value.forEach((element) {
          if (date.yyyymmdd == element.date) {
            list.add(Text(element.title));
          }
        });

        return Column(children: list);
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    // final list = <Widget>[];
    //
    // final udemyState = _ref.watch(udemyProvider);
    //
    // udemyState.forEach((element) {
    //   if (date.yyyymmdd == element.date) {
    //     list.add(Text(element.title));
    //   }
    // });
    //
    // return Column(children: list);
  }
}
