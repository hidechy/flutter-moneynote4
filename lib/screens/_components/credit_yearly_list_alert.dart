// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/credit_spend_all.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/credit_notifier.dart';

class CreditYearlyListAlert extends ConsumerWidget {
  CreditYearlyListAlert({super.key, required this.date});

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

              Text(date.yyyy),

              Expanded(
                child: displayCreditYearlyList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayCreditYearlyList() {
    final list = <Widget>[];

    final creditYearlyTotalState = _ref.watch(creditYearlyTotalProvider(date));

    final yearlyAllCredit = <CreditSpendAll>[];
    creditYearlyTotalState.forEach((element) {
      yearlyAllCredit.add(
        CreditSpendAll(
          payMonth: element.payMonth,
          item: getListItem(item: element.item),
          price: element.price,
          date: element.date,
          kind: element.kind,
          monthDiff: element.monthDiff,
          flag: element.flag,
        ),
      );
    });

    yearlyAllCredit
      ..sort((a, b) => '${a.date.yyyymmdd}|${a.item}'.compareTo('${b.date.yyyymmdd}|${b.item}'))
      ..forEach((element) {
        list.add(
          SizedBox(
            width: _context.screenSize.width,
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: 0.6,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white.withOpacity(0.8)),
                            color: _utility.getLeadingBgColor(month: element.date.yyyymmdd.split('-')[1]),
                          ),
                          child: Column(
                            children: [
                              Text(
                                element.date.yyyy,
                                style: const TextStyle(fontSize: 8),
                              ),
                              Text(
                                element.date.mmdd,
                                style: const TextStyle(fontSize: 8),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          element.item,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.topRight,
                        child: Text(
                          element.price.toCurrency(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        );
      });

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  String getListItem({required String item}) {
    var ret = item.replaceAll('ＪＣＢ国内利用　', '').replaceAll('ＪＣＢ海外利用　', '').replaceAll('JCB ', '');

    //-------------------------//
    var reg = RegExp('西友ネットスーパー');

    if (reg.firstMatch(item) != null) {
      final exItem = item.split('　 ');
      ret = exItem[0];
    }
    //-------------------------//

    //-------------------------//

    reg = RegExp('さくらインターネット');

    if (reg.firstMatch(item) != null) {
      final exItem = item.split('　');
      ret = exItem[0];
    }
    //-------------------------//

    //-------------------------//

    reg = RegExp('ドコモご利用料金');

    if (reg.firstMatch(item) != null) {
      final exItem = item.split('　');
      ret = exItem[0];
    }
    //-------------------------//

    return ret;
  }
}
