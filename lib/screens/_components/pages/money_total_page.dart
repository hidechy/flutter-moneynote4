// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../extensions/extensions.dart';
import '../../../models/bank_move.dart';
import '../../../state/bank/bank_notifier.dart';
import '../../../state/benefit/benefit_notifier.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/holiday/holiday_notifier.dart';
import '../../../state/money/money_notifier.dart';
import '../../../utility/utility.dart';

class MoneyTotalPage extends ConsumerWidget {
  MoneyTotalPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  final autoScrollController = AutoScrollController();

  Map<String, BankMove> bankMoveList = {};

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    _makeBankMoveList();
    //
    // final moneyEverydayState = _ref.watch(moneyEverydayProvider);
    //
    //
    //
    //

    final moneyEverydayList = _ref.watch(moneyEverydayProvider.select((value) => value.moneyEverydayList));
    final moneyEverydayListLength = (moneyEverydayList.value != null) ? moneyEverydayList.value!.length : 0;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Container(width: context.screenSize.width),

            //----------//
            if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
            //----------//

            Row(
              children: [
                GestureDetector(
                  onTap: () => autoScrollController.scrollToIndex(moneyEverydayListLength),
                  child: const Icon(Icons.arrow_downward),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () => autoScrollController.scrollToIndex(0),
                  child: const Icon(Icons.arrow_upward),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(child: displayMoneyTotal()),
          ],
        ),
      ),
    );
  }

  ///
  void _makeBankMoveList() {
//    _ref.watch(bankMoveProvider).forEach((element) => bankMoveList[element.date.yyyymmdd] = element);

    final bmList = _ref.watch(bankMoveProvider.select((value) => value.bankMoveList));

    bmList.value?.forEach((element) => bankMoveList[element.date.yyyymmdd] = element);
  }

  ///
  Widget displayMoneyTotal() {
    final benefitMap = _ref.watch(benefitProvider.select((value) => value.benefitMap));

    final holidayState = _ref.watch(holidayProvider);

    final list = <Widget>[];

    final moneyEverydayList = _ref.watch(moneyEverydayProvider.select((value) => value.moneyEverydayList));

    return moneyEverydayList.when(
      data: (value) {
        var keepSum = 0;

        for (var i = 0; i < value.length; i++) {
          if (date.year == value[i].date.year) {
            list.add(AutoScrollTag(
              key: ValueKey(i),
              index: i,
              controller: autoScrollController,
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  color: _utility.getYoubiColor(
                    date: value[i].date,
                    youbiStr: value[i].date.youbiStr,
                    holiday: holidayState.data,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${value[i].date.yyyymmdd} (${value[i].date.youbiStr.substring(0, 3)})'),
                        Row(
                          children: [
                            Text(value[i].sum.toCurrency()),
                            const SizedBox(width: 20),
                            if (value[i].sum.toInt() > keepSum)
                              const Icon(Icons.arrow_upward, color: Colors.greenAccent),
                            if (value[i].sum.toInt() <= keepSum)
                              const Icon(Icons.crop_square, color: Colors.transparent),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Text(value[i].spend.toCurrency(), style: const TextStyle(color: Colors.grey)),
                      ],
                    ),

                    //

                    if (benefitMap.value != null && benefitMap.value![value[i].date.yyyymmdd] != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.yellowAccent.withOpacity(0.6),
                            ),
                            child: Row(
                              children: [
                                Text(benefitMap.value![value[i].date.yyyymmdd]!.company),
                                const SizedBox(width: 20),
                                Text(benefitMap.value![value[i].date.yyyymmdd]!.salary.toCurrency()),
                              ],
                            ),
                          ),
                        ],
                      ),

                    //

                    if (bankMoveList[value[i].date.yyyymmdd] != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          DefaultTextStyle(
                            style: TextStyle(fontSize: 10, color: Colors.greenAccent.withOpacity(0.6)),
                            child: Row(
                              children: [
                                Text(
                                  'Bank Move - ${bankMoveList[value[i].date.yyyymmdd]!.bank} // ${bankMoveList[value[i].date.yyyymmdd]!.flag == 0 ? 'out' : 'in'}',
                                ),
                                const SizedBox(width: 20),
                                Text(bankMoveList[value[i].date.yyyymmdd]!.price.toString().toCurrency()),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ));
          }

          keepSum = value[i].sum.toInt();
        }

        return SingleChildScrollView(
          controller: autoScrollController,
          child: DefaultTextStyle(style: const TextStyle(fontSize: 10), child: Column(children: list)),
        );
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*





    final benefitMap = _ref.watch(benefitProvider.select((value) => value.benefitMap));

    final holidayState = _ref.watch(holidayProvider);

    final list = <Widget>[];

    final moneyEverydayState = _ref.watch(moneyEverydayProvider);

    var keepSum = 0;
    for (var i = 0; i < moneyEverydayState.length; i++) {
      if (date.year == moneyEverydayState[i].date.year) {
        list.add(AutoScrollTag(
          key: ValueKey(i),
          index: i,
          controller: autoScrollController,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              color: _utility.getYoubiColor(
                date: moneyEverydayState[i].date,
                youbiStr: moneyEverydayState[i].date.youbiStr,
                holiday: holidayState.data,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '${moneyEverydayState[i].date.yyyymmdd} (${moneyEverydayState[i].date.youbiStr.substring(0, 3)})'),
                    Row(
                      children: [
                        Text(moneyEverydayState[i].sum.toCurrency()),
                        const SizedBox(width: 20),
                        if (moneyEverydayState[i].sum.toInt() > keepSum)
                          const Icon(Icons.arrow_upward, color: Colors.greenAccent),
                        if (moneyEverydayState[i].sum.toInt() <= keepSum)
                          const Icon(Icons.crop_square, color: Colors.transparent),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      moneyEverydayState[i].spend.toCurrency(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                //

                if (benefitMap[moneyEverydayState[i].date.yyyymmdd] != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.yellowAccent.withOpacity(0.6),
                        ),
                        child: Row(
                          children: [
                            Text(benefitMap[moneyEverydayState[i].date.yyyymmdd]!.company),
                            const SizedBox(width: 20),
                            Text(benefitMap[moneyEverydayState[i].date.yyyymmdd]!.salary.toCurrency()),
                          ],
                        ),
                      ),
                    ],
                  ),

                //

                if (bankMoveList[moneyEverydayState[i].date.yyyymmdd] != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.greenAccent.withOpacity(0.6),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Bank Move - ${bankMoveList[moneyEverydayState[i].date.yyyymmdd]!.bank} // ${bankMoveList[moneyEverydayState[i].date.yyyymmdd]!.flag == 0 ? 'out' : 'in'}',
                            ),
                            const SizedBox(width: 20),
                            Text(
                              bankMoveList[moneyEverydayState[i].date.yyyymmdd]!.price.toString().toCurrency(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ));
      }

      keepSum = moneyEverydayState[i].sum.toInt();
    }

    return SingleChildScrollView(
      controller: autoScrollController,
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: Column(children: list),
      ),
    );




    */
  }
}
