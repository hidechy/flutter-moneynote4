// ignore_for_file: must_be_immutable, cascade_invocations, join_return_with_assignment, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/credit_spend_all_disp.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/credit/credit_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/keihi_list/keihi_list_notifier.dart';
import '../../utility/utility.dart';

class CreditYearlyListAlert extends ConsumerWidget {
  CreditYearlyListAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  List<String> keihiList = [];

  TextEditingController searchText = TextEditingController();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    makeKeihiListMap();

    final appParamState = ref.watch(appParamProvider);

    searchText.text = appParamState.CreditYearlyListSelectString;

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

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchText,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(appParamProvider.notifier).setCreditYearlyListSelectString(value: '');

                      ref.read(appParamProvider.notifier).setCreditYearlyListSelectedString(value: searchText.text);
                    },
                    icon: Icon((appParamState.CreditYearlyListSelectedString != '') ? Icons.close : Icons.search),
                  ),
                ],
              ),

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

    final CreditYearlyListSelectedString = _ref.watch(
      appParamProvider.select((value) => value.CreditYearlyListSelectedString),
    );

    final yearlyAllCredit = <CreditSpendAllDisp>[];

    final creditSpendAllList = _ref.watch(creditYearlyTotalProvider(date).select((value) => value.creditSpendAllList));

    creditSpendAllList.value?.forEach((element) {
      yearlyAllCredit.add(
        CreditSpendAllDisp(
          payMonth: element.payMonth,
          item: _utility.getCreditListItem(item: element.item),
          baseItem: element.item,
          price: element.price,
          date: element.date,
          kind: element.kind,
          monthDiff: element.monthDiff,
          flag: element.flag,
        ),
      );
    });

    // final creditYearlyTotalState = _ref.watch(creditYearlyTotalProvider(date));
    //
    // creditYearlyTotalState.forEach((element) {
    //   yearlyAllCredit.add(
    //     CreditSpendAllDisp(
    //       payMonth: element.payMonth,
    //       item: _utility.getCreditListItem(item: element.item),
    //       baseItem: element.item,
    //       price: element.price,
    //       date: element.date,
    //       kind: element.kind,
    //       monthDiff: element.monthDiff,
    //       flag: element.flag,
    //     ),
    //   );
    // });
    //
    //
    //

    var sum = 0;
    var keihiSum = 0;

    yearlyAllCredit.sort((a, b) => '${a.item}|${a.date.yyyymmdd}'.compareTo('${b.item}|${b.date.yyyymmdd}'));

    //forで仕方ない
    for (var i = 0; i < yearlyAllCredit.length; i++) {
      //================// 絞り込み
      if (CreditYearlyListSelectedString != '') {
        final reg = RegExp(CreditYearlyListSelectedString);

        if (reg.firstMatch(yearlyAllCredit[i].item) == null) {
          continue;
        }
      }
      //================// 絞り込み

      final color = (yearlyAllCredit[i].price.toInt() >= 10000) ? Colors.yellowAccent : Colors.white;

      var bgColor = Colors.transparent;
      if (keihiList.contains('${yearlyAllCredit[i].baseItem}|${yearlyAllCredit[i].date.yyyymmdd}')) {
        bgColor = (yearlyAllCredit[i].date.year == DateTime.now().year - 1)
            ? Colors.orangeAccent.withOpacity(0.1)
            : Colors.yellowAccent.withOpacity(0.1);

        keihiSum += yearlyAllCredit[i].price.toInt();
      }

      list.add(
        Container(
          width: _context.screenSize.width,
          decoration: BoxDecoration(color: bgColor),
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _ref
                            .watch(appParamProvider.notifier)
                            .setCreditYearlyListSelectString(value: yearlyAllCredit[i].item);
                      },
                      child: Opacity(
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
                            children: [
                              Text(yearlyAllCredit[i].date.yyyy),
                              Text(
                                yearlyAllCredit[i].date.mmdd,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
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
          Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        sum.toString().toCurrency(),
                        style: const TextStyle(fontSize: 10),
                      ),
                      Text(
                        keihiSum.toString().toCurrency(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFFFBB6CE),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
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

      final kList = _ref.watch(keihiListProvider(DateTime(i)).select((value) => value.keihiList));

      kList.value?.forEach((element) => keihiList.add('${element.item}|${element.date.yyyymmdd}'));
    }
  }
}
