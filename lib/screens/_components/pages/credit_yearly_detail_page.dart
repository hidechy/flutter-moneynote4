// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../models/credit_spend_yearly_detail_disp.dart';
import '../../../state/credit/credit_notifier.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/keihi_list/keihi_list_notifier.dart';
import '../../../state/seiyu_purchase/seiyu_purchase_notifier.dart';
import '../../../utility/utility.dart';
import '../_money_dialog.dart';
import '../credit_udemy_alert.dart';
import 'seiyu_tab_page.dart';

class CreditYearlyDetailPage extends ConsumerWidget {
  CreditYearlyDetailPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  List<String> keihiList = [];

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    makeKeihiListMap();

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
    ///////////////////////
    final reg = RegExp('西友ネットスーパー');

    final dateList = <String>[];

    final seiyuPurchaseList = _ref.watch(seiyuAllProvider(date).select((value) => value.seiyuPurchaseList));

    seiyuPurchaseList.value?.forEach((element) {
      if (!dateList.contains(element.date)) {
        dateList.add(element.date);
      }
    });

    // final seiyuAllState = _ref.watch(seiyuAllProvider(date));
    // final dateList = <String>[];
    // seiyuAllState.forEach((element) {
    //   if (!dateList.contains(element.date)) {
    //     dateList.add(element.date);
    //   }
    // });
    //
    //

    ///////////////////////

    final list = <Widget>[];

    final yearlyDetailCredit = <CreditSpendYearlyDetailDisp>[];

    final creditSpendMonthlyList =
        _ref.watch(creditSpendMonthlyProvider(date).select((value) => value.creditSpendMonthlyList));

    creditSpendMonthlyList.value?.forEach((element) {
      yearlyDetailCredit.add(
        CreditSpendYearlyDetailDisp(
          item: _utility.getCreditListItem(item: element.item),
          baseItem: element.item,
          date: element.date,
          price: element.price.toInt(),
        ),
      );
    });

    // final creditSpendMonthlyState = _ref.watch(creditSpendMonthlyProvider(date));
    //
    // creditSpendMonthlyState.forEach((element) {
    //   yearlyDetailCredit.add(
    //     CreditSpendYearlyDetailDisp(
    //       item: _utility.getCreditListItem(item: element.item),
    //       baseItem: element.item,
    //       date: element.date,
    //       price: element.price.toInt(),
    //     ),
    //   );
    // });
    //
    //
    //

    yearlyDetailCredit.sort((a, b) => '${a.date.yyyymmdd}|${a.item}'.compareTo('${b.date.yyyymmdd}|${b.item}'));

    var sum = 0;
    var keihiSum = 0;
    for (var i = 0; i < yearlyDetailCredit.length; i++) {
      sum += yearlyDetailCredit[i].price;

      final priceColor = (yearlyDetailCredit[i].price >= 10000) ? Colors.yellowAccent : Colors.white;

      var bgColor = Colors.transparent;
      if (keihiList.contains('${yearlyDetailCredit[i].baseItem}|${yearlyDetailCredit[i].date.yyyymmdd}')) {
        bgColor = (yearlyDetailCredit[i].date.year == DateTime.now().year - 1)
            ? Colors.orangeAccent.withOpacity(0.1)
            : Colors.yellowAccent.withOpacity(0.1);

        keihiSum += yearlyDetailCredit[i].price;
      }

      final dateDiff = date.difference(yearlyDetailCredit[i].date).inDays - 1;

      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            color: bgColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            yearlyDetailCredit[i].item,
                            style: TextStyle(color: priceColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    child: Text(yearlyDetailCredit[i].date.yyyymmdd),
                                  ),
                                  (reg.firstMatch(yearlyDetailCredit[i].item) != null)
                                      ? GestureDetector(
                                          onTap: () async {
                                            final index = dateList.indexWhere(
                                              (element) => element == yearlyDetailCredit[i].date.yyyymmdd,
                                            );

                                            await MoneyDialog(
                                              context: _context,
                                              widget: SeiyuTabPage(list: dateList, index: index),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.indigoAccent.withOpacity(0.2),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            child: const Text(
                                              'data display',
                                              style: TextStyle(
                                                color: Colors.lightBlueAccent,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              Text(
                                yearlyDetailCredit[i].price.toString().toCurrency(),
                                style: TextStyle(color: priceColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.black.withOpacity(0.2),
                      child: Text(
                        dateDiff.toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    list.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(sum.toString().toCurrency()),
                Text(
                  keihiSum.toString().toCurrency(),
                  style: const TextStyle(color: Color(0xFFFBB6CE)),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return SingleChildScrollView(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: Column(children: list),
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

  ///
  void makeKeihiListMap() {
    keihiList = [];

    for (var i = date.year - 1; i <= date.year; i++) {
      // final keihiListState = _ref.watch(keihiListProvider(DateTime(i)));
      //
      // keihiListState.forEach((element) {
      //   keihiList.add('${element.item}|${element.date.yyyymmdd}');
      // });
      //
      //
      //

      final kList = _ref.watch(keihiListProvider(DateTime(i)).select((value) => value.keihiList));

      kList.value?.forEach((element) => keihiList.add('${element.item}|${element.date.yyyymmdd}'));
    }
  }
}
