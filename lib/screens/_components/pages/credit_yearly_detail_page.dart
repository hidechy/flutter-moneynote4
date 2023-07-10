// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../utility/utility.dart';
import '../../../viewmodel/credit_notifier.dart';
import '../_money_dialog.dart';
import '../credit_udemy_alert.dart';

class CreditYearlyDetailPage extends ConsumerWidget {
  CreditYearlyDetailPage({super.key, required this.date});

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

              Expanded(
                child: displaySpendYearlyDetail(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displaySpendYearlyDetail() {
    final list = <Widget>[];

    final creditSummaryDetailState = _ref.watch(
      creditSummaryDetailProvider(date),
    );

    var sum = 0;
    for (var i = 0; i < creditSummaryDetailState.length; i++) {
      sum += creditSummaryDetailState[i].price;

      final priceColor = (creditSummaryDetailState[i].price >= 10000) ? Colors.yellowAccent : Colors.white;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      creditSummaryDetailState[i].item,
                      style: TextStyle(color: priceColor),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        creditSummaryDetailState[i].price.toString().toCurrency(),
                        style: TextStyle(color: priceColor),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(width: 20),
              // getLinkIcon(
              //   item: creditSummaryDetailState[i].item,
              //   price: creditSummaryDetailState[i].price,
              // ),
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
            Container(),
            Row(
              children: [
                Text(sum.toString().toCurrency()),
                const SizedBox(width: 20),
                const Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.transparent,
                )
              ],
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
  Widget getLinkIcon({required String item, required int price}) {
    switch (item) {
      case 'UDEMY':
        return GestureDetector(
          onTap: () {
            MoneyDialog(
              context: _context,
              widget: CreditUdemyAlert(
                date: date,
                price: price,
              ),
            );
          },
          child: Icon(
            FontAwesomeIcons.u,
            color: Colors.white.withOpacity(0.4),
          ),
        );
      default:
        return const Icon(
          Icons.check_box_outline_blank,
          color: Colors.transparent,
        );
    }
  }
}
