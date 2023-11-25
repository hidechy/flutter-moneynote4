// ignore_for_file: must_be_immutable, avoid_bool_literals_in_conditional_expressions

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/gold/gold_notifier.dart';
import '../../state/shintaku/shintaku_notifier.dart';
import '../../state/stock/stock_notifier.dart';
import '../../utility/utility.dart';

class AssetsListAlert extends ConsumerWidget {
  AssetsListAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  List<String> dateList = [];

  final autoScrollController = AutoScrollController();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    makeDateList();

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: _displayAssetsList(),
      ),
    );
  }

  ///
  void makeDateList() {
    final firstDate = DateTime(2022);

    final diff = date.difference(firstDate).inDays;

    for (var i = 0; i <= diff; i++) {
      dateList.add(firstDate.add(Duration(days: i)).yyyymmdd);
    }
  }

  ///
  Widget _displayAssetsList() {
    final deviceInfoState = _ref.read(deviceInfoProvider);

    final goldMap = _ref.watch(goldLastProvider(date).select((value) => value.goldMap));
    final stockMap = _ref.watch(stockProvider(date).select((value) => value.stockMap));
    final shintakuMap = _ref.watch(shintakuProvider(date).select((value) => value.shintakuMap));

    final list = <Widget>[];

    final goldPercentList = <int>[];
    final stockPercentList = <int>[];
    final shintakuPercentList = <int>[];

    var keepGoldPercent = 0;
    var keepStockPercent = 0;
    var keepShintakuPercent = 0;

    var i = 0;
    dateList.forEach((element) {
      final goldPrice = (goldMap.value != null && goldMap.value![element] == null) ? 0 : goldMap.value![element]!.price;
      final stockPrice = (stockMap[element] == null) ? 0 : stockMap[element]!.price;
      final shintakuPrice = (shintakuMap[element] == null) ? 0 : shintakuMap[element]!.price;

      final goldDiff = (goldMap.value != null && goldMap.value![element] == null) ? 0 : goldMap.value![element]!.diff;
      final stockDiff = (stockMap[element] == null) ? 0 : stockMap[element]!.diff;
      final shintakuDiff = (shintakuMap[element] == null) ? 0 : shintakuMap[element]!.diff;

      final goldPercent =
          (goldMap.value != null && goldMap.value![element] == null) ? 0 : goldMap.value![element]!.percent;
      final stockPercent = (stockMap[element] == null) ? 0 : stockMap[element]!.percent;
      final shintakuPercent = (shintakuMap[element] == null) ? 0 : shintakuMap[element]!.percent;

      final dispFlag = (goldPercent == 0 || stockPercent == 0 || shintakuPercent == 0) ? false : true;

      if (dispFlag) {
        goldPercentList.add(goldPercent);
        stockPercentList.add(stockPercent);
        shintakuPercentList.add(shintakuPercent);
      }

      final youbi = '$element 00:00:00'.toDateTime().youbiStr.substring(0, 3);

      list.add(
        AutoScrollTag(
          key: ValueKey(i),
          index: i,
          controller: autoScrollController,
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 8),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$element ($youbi)',
                        style: TextStyle(
                          color: dispFlag ? Colors.white : Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      Container(),
                    ],
                  ),
                  if (dispFlag) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                (goldMap.value != null && goldMap.value![element] == null)
                                    ? '0'
                                    : goldMap.value![element]!.cost.toString().toCurrency(),
                              ),
                              Text(
                                goldPrice.toString().toCurrency(),
                                style: const TextStyle(color: Colors.yellowAccent),
                              ),
                              Text(
                                goldDiff.toString().toCurrency(),
                                style: const TextStyle(color: Color(0xFFFBB6CE)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text('$goldPercent %'),
                                _dispUpDownMark(before: keepGoldPercent, after: goldPercent),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                (stockMap[element] == null) ? '0' : stockMap[element]!.cost.toString().toCurrency(),
                              ),
                              Text(
                                stockPrice.toString().toCurrency(),
                                style: const TextStyle(color: Colors.yellowAccent),
                              ),
                              Text(
                                stockDiff.toString().toCurrency(),
                                style: const TextStyle(color: Color(0xFFFBB6CE)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text('$stockPercent %'),
                                _dispUpDownMark(before: keepStockPercent, after: stockPercent),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                (shintakuMap[element] == null)
                                    ? '0'
                                    : shintakuMap[element]!.cost.toString().toCurrency(),
                              ),
                              Text(
                                shintakuPrice.toString().toCurrency(),
                                style: const TextStyle(color: Colors.yellowAccent),
                              ),
                              Text(
                                shintakuDiff.toString().toCurrency(),
                                style: const TextStyle(color: Color(0xFFFBB6CE)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text('$shintakuPercent %'),
                                _dispUpDownMark(before: keepShintakuPercent, after: shintakuPercent),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: _context.screenSize.width * 0.4),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (goldPrice + stockPrice + shintakuPrice).toString().toCurrency(),
                                style: const TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                (goldDiff + stockDiff + shintakuDiff).toString().toCurrency(),
                                style: const TextStyle(
                                  color: Color(0xFFFBB6CE),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );

      if (dispFlag) {
        keepGoldPercent = goldPercent;
        keepStockPercent = stockPercent;
        keepShintakuPercent = shintakuPercent;
      }

      i++;
    });

    final minGoldPercent = goldPercentList.reduce(min);
    final maxGoldPercent = goldPercentList.reduce(max);

    final minStockPercent = stockPercentList.reduce(min);
    final maxStockPercent = stockPercentList.reduce(max);

    final minShintakuPercent = shintakuPercentList.reduce(min);
    final maxShintakuPercent = shintakuPercentList.reduce(max);

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(width: _context.screenSize.width),

          //----------//
          if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
          //----------//

          Row(
            children: ['GOLD', 'STOCK', 'SHINTAKU'].map((e) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(e),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: _context.screenSize.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        autoScrollController.scrollToIndex(dateList.length);
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
          ),

          Expanded(
            child: SingleChildScrollView(
              controller: autoScrollController,
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 10),
                child: Column(children: list),
              ),
            ),
          ),

          Row(
            children: [
              '$minGoldPercent 〜 $maxGoldPercent %',
              '$minStockPercent 〜 $maxStockPercent %',
              '$minShintakuPercent 〜 $maxShintakuPercent %'
            ].map((e) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(e),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  ///
  Widget _dispUpDownMark({required int before, required int after}) {
    if (before < after) {
      return const Icon(
        Icons.arrow_upward,
        color: Colors.greenAccent,
        size: 12,
      );
    } else if (before > after) {
      return const Icon(
        Icons.arrow_downward,
        color: Colors.redAccent,
        size: 12,
      );
    } else {
      return const Icon(
        Icons.crop_square,
        color: Colors.transparent,
        size: 12,
      );
    }
  }
}
