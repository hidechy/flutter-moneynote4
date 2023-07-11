// ignore_for_file: must_be_immutable, cascade_invocations, join_return_with_assignment

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/credit_notifier.dart';
import '../../viewmodel/keihi_list_notifier.dart';

class CreditYearlyListAlert extends ConsumerWidget {
  CreditYearlyListAlert({super.key, required this.date});

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

              Text(date.yyyy),

              const SizedBox(height: 20),

              displayCreditYearlyList(),
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

    final yearlyAllCredit = <CreditSpendAllDisp>[];
    creditYearlyTotalState.forEach((element) {
      yearlyAllCredit.add(
        CreditSpendAllDisp(
          payMonth: element.payMonth,
          item: getListItem(item: element.item),
          baseItem: element.item,
          price: element.price,
          date: element.date,
          kind: element.kind,
          monthDiff: element.monthDiff,
          flag: element.flag,
        ),
      );
    });

    var sum = 0;

    yearlyAllCredit.sort((a, b) => '${a.item}|${a.date.yyyymmdd}'.compareTo('${b.item}|${b.date.yyyymmdd}'));

    //forで仕方ない
    for (var i = 0; i < yearlyAllCredit.length; i++) {
      final color = (yearlyAllCredit[i].price.toInt() >= 10000) ? Colors.yellowAccent : Colors.white;

      list.add(
        Container(
          width: _context.screenSize.width,
          decoration: BoxDecoration(
            color: (keihiList.contains('${yearlyAllCredit[i].baseItem}|${yearlyAllCredit[i].date.yyyymmdd}'))
                ? Colors.yellowAccent.withOpacity(0.1)
                : Colors.transparent,
          ),
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
                          color: (yearlyAllCredit[i].date.yyyymmdd.split('-')[0] != date.yyyy)
                              ? Colors.black.withOpacity(0.2)
                              : _utility.getLeadingBgColor(month: yearlyAllCredit[i].date.yyyymmdd.split('-')[1]),
                        ),
                        child: Column(
                          children: [Text(yearlyAllCredit[i].date.yyyy), Text(yearlyAllCredit[i].date.mmdd)],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        yearlyAllCredit[i].item,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: color),
                      ),
                    ),
                    Container(
                      width: 40,
                      alignment: Alignment.topRight,
                      child: Text(
                        yearlyAllCredit[i].price.toCurrency(),
                        style: TextStyle(color: color),
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

      sum += yearlyAllCredit[i].price.toInt();
    }

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: list,
              ),
            ),
          ),
          Container(
            height: 20,
            alignment: Alignment.topRight,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              sum.toString().toCurrency(),
              style: const TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
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

    ret = ret.alphanumericToHalfLength();

    return ret;
  }

  ///
  void makeKeihiListMap() {
    keihiList = [];

    final keihiListState = _ref.watch(keihiListProvider(date));

    keihiListState.forEach((element) {
      keihiList.add('${element.item}|${element.date.yyyymmdd}');
    });
  }
}

class CreditSpendAllDisp {
  CreditSpendAllDisp({
    required this.payMonth,
    required this.item,
    required this.baseItem,
    required this.price,
    required this.date,
    required this.kind,
    required this.monthDiff,
    required this.flag,
  });

  String payMonth;
  String item;
  String baseItem;
  String price;
  DateTime date;
  String kind;
  int monthDiff;
  int flag;
}
