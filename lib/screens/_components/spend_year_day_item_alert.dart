// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../extensions/extensions.dart';
import '../../models/zero_use_date.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/spend/spend_notifier.dart';
import '../../utility/utility.dart';

class SpendYearDayItemAlert extends ConsumerWidget {
  SpendYearDayItemAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  final autoScrollController = AutoScrollController();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    var maxNum = 0;

    final spendYearlyList = _ref.watch(spendYearlyProvider(date).select((value) => value.spendYearlyList));

    spendYearlyList.value?.forEach((element) {
      for (var j = 0; j < element.item.length; j++) {
        maxNum++;
      }
    });

    //
    //
    // final spendYearDayState = _ref.watch(spendYearlyProvider(date));
    //
    // for (var i = 0; i < spendYearDayState.length; i++) {
    //   for (var j = 0; j < spendYearDayState[i].item.length; j++) {
    //     maxNum++;
    //   }
    // }
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date.yyyy),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          autoScrollController.scrollToIndex(maxNum);
                        },
                        child: const Icon(Icons.arrow_downward),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          autoScrollController.scrollToIndex(0);
                        },
                        child: const Icon(Icons.arrow_upward),
                      ),
                    ],
                  ),
                ],
              ),

              Divider(
                color: Colors.white.withOpacity(0.4),
                thickness: 2,
              ),

              _displayDataSelectChips(),

              Divider(
                color: Colors.white.withOpacity(0.4),
                thickness: 2,
              ),

              Expanded(
                child: displaySpendYearDayItem(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayDataSelectChips() {
    final spendYearDayItemSelectTextState = _ref.watch(spendYearDayItemSelectTextProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _ref.read(spendYearDayItemSelectTextProvider.notifier).setSpendYearDayItemSelectText(text: ''),
          child: Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (spendYearDayItemSelectTextState == '')
                  ? Colors.yellowAccent.withOpacity(0.2)
                  : Colors.indigo.withOpacity(0.2),
            ),
            child: const Text('ALL', style: TextStyle(fontSize: 8)),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Wrap(
            children: ['5000', '10000', '30000', '50000', '100000'].map((e) {
              return GestureDetector(
                onTap: () {
                  _ref.read(spendYearDayItemSelectTextProvider.notifier).setSpendYearDayItemSelectText(text: e);
                },
                child: Container(
                  margin: const EdgeInsets.all(3),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (spendYearDayItemSelectTextState == e)
                        ? Colors.yellowAccent.withOpacity(0.2)
                        : Colors.indigo.withOpacity(0.2),
                  ),
                  child: Text('$e〜', style: const TextStyle(fontSize: 8)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  ///
  Widget displaySpendYearDayItem() {
    final spendYearDayItemSelectTextState = _ref.watch(spendYearDayItemSelectTextProvider);

    final list = <Widget>[];

    final spendZeroUseDateState = _ref.watch(spendZeroUseDateProvider);

    var yearTotal = 0;

    // forで仕方ない

    var maxNum = 0;

    final spendYearlyList = _ref.watch(spendYearlyProvider(date).select((value) => value.spendYearlyList));

    return spendYearlyList.when(
      data: (value) {
        for (var i = 0; i < value.length; i++) {
          final listDate = value[i].date.mmdd;

          final youbi = value[i].date.youbiStr;

          for (var j = 0; j < value[i].item.length; j++) {
            final item = value[i].item[j];

            if (spendYearDayItemSelectTextState != '') {
              if (item.price.toString().toInt() < spendYearDayItemSelectTextState.toInt()) {
                continue;
              }
            }

            final linePrice = item.price.toString().toInt();

            yearTotal += linePrice;

            list.add(AutoScrollTag(
              key: ValueKey(maxNum),
              index: maxNum,
              controller: autoScrollController,
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                child: Row(
                  children: [
                    if (getSpendZeroFlag(date: value[i].date.yyyymmdd, spend: spendZeroUseDateState) == 1) ...[
                      const Icon(Icons.star, color: Colors.yellowAccent, size: 10),
                      const SizedBox(width: 10),
                    ],
                    if (getSpendZeroFlag(date: value[i].date.yyyymmdd, spend: spendZeroUseDateState) == 0) ...[
                      const Icon(Icons.check_box_outline_blank, color: Colors.transparent, size: 10),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      flex: 3,
                      child: Text('$listDate (${youbi.substring(0, 3)})'),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(item.item, overflow: TextOverflow.ellipsis, maxLines: 1),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(linePrice.toString().toCurrency()),
                            Text(yearTotal.toString().toCurrency(), style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));

            maxNum++;
          }
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
        final spendYearDayState = _ref.watch(spendYearlyProvider(date));

    for (var i = 0; i < spendYearDayState.length; i++) {
      final listDate = spendYearDayState[i].date.mmdd;

      final youbi = spendYearDayState[i].date.youbiStr;

      for (var j = 0; j < spendYearDayState[i].item.length; j++) {
        final item = spendYearDayState[i].item[j];

        if (spendYearDayItemSelectTextState != '') {
          if (item.price.toString().toInt() < spendYearDayItemSelectTextState.toInt()) {
            continue;
          }
        }

        final linePrice = item.price.toString().toInt();

        yearTotal += linePrice;

        list.add(AutoScrollTag(
          key: ValueKey(maxNum),
          index: maxNum,
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
            ),
            child: Row(
              children: [
                if (getSpendZeroFlag(date: spendYearDayState[i].date.yyyymmdd, spend: spendZeroUseDateState) == 1) ...[
                  const Icon(Icons.star, color: Colors.yellowAccent, size: 10),
                  const SizedBox(width: 10),
                ],
                if (getSpendZeroFlag(date: spendYearDayState[i].date.yyyymmdd, spend: spendZeroUseDateState) == 0) ...[
                  const Icon(Icons.check_box_outline_blank, color: Colors.transparent, size: 10),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  flex: 3,
                  child: Text('$listDate (${youbi.substring(0, 3)})'),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    item.item,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(linePrice.toString().toCurrency()),
                        Text(
                          yearTotal.toString().toCurrency(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));

        maxNum++;
      }
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

  ///
  int getSpendZeroFlag({required String date, required ZeroUseDate spend}) {
    for (var i = 0; i < spend.data.length; i++) {
      if (date == spend.data[i].yyyymmdd) {
        return 1;
      }
    }

    return 0;
  }
}

////////////////////////////////////////////////

final spendYearDayItemSelectTextProvider =
    StateNotifierProvider.autoDispose<SpendYearDayItemSelectTextNotifier, String>((ref) {
  return SpendYearDayItemSelectTextNotifier();
});

class SpendYearDayItemSelectTextNotifier extends StateNotifier<String> {
  SpendYearDayItemSelectTextNotifier() : super('');

  ///
  Future<void> setSpendYearDayItemSelectText({required String text}) async {
    state = text;
  }
}
