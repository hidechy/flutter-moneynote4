// ignore_for_file: must_be_immutable, sized_box_shrink_expand

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../viewmodel/gold_notifier.dart';

class GoldAlert extends ConsumerWidget {
  GoldAlert({super.key});

  final autoScrollController = AutoScrollController();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final goldListState = ref.watch(goldListProvider);

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(width: context.screenSize.width),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            autoScrollController.scrollToIndex(
                              goldListState.length,
                            );
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: context.screenSize.height * 0.75,
                  child: displayGold(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayGold() {
    final goldListState = _ref.watch(goldListProvider);

    final list = <Widget>[];

    for (var i = 0; i < goldListState.length; i++) {
      final date =
          '${goldListState[i].year}-${goldListState[i].month}-${goldListState[i].day}';

      final diff = (goldListState[i].goldValue.toString() == '-')
          ? ''
          : (int.parse(goldListState[i].goldValue.toString()) -
                  int.parse(goldListState[i].payPrice.toString()))
              .toString();

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
          child: AutoScrollTag(
            key: ValueKey(i),
            index: i,
            controller: autoScrollController,
            child: (goldListState[i].goldValue.toString() == '-')
                ? SizedBox(
                    width: double.infinity,
                    child: Text(
                      date,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(date),
                          ),
                          const Text('1g'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(goldListState[i].goldTanka),
                              Text(goldListState[i].diff.toString()),
                            ],
                          ),
                          getGoldMark(mark: goldListState[i].upDown),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 50),
                          Expanded(
                            child: Column(
                              children: [
                                Table(
                                  children: [
                                    TableRow(
                                      children: [
                                        Text(goldListState[i]
                                            .goldValue
                                            .toString()),
                                        Text(goldListState[i]
                                            .payPrice
                                            .toString()),
                                        Container(
                                          width: double.infinity,
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            diff,
                                            style: TextStyle(
                                              color: (int.parse(diff) >= 0)
                                                  ? Colors.yellowAccent
                                                  : Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                        Container(),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(goldListState[i].goldPrice),
                                    Text(
                                      '${goldListState[i].gramNum} g',
                                    ),
                                    Text('${goldListState[i].totalGram} g'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      controller: autoScrollController,
      child: Column(
        children: list,
      ),
    );
  }

  Widget getGoldMark({required dynamic mark}) {
    switch (mark.toString()) {
      case '1':
        return const Icon(
          Icons.arrow_upward,
          color: Colors.greenAccent,
        );
      case '0':
        return const Icon(
          Icons.arrow_downward,
          color: Colors.redAccent,
        );
      default:
        return const Icon(
          Icons.crop_square,
          color: Colors.black,
        );
    }
  }
}
