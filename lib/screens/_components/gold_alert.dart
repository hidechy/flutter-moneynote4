// ignore_for_file: must_be_immutable, sized_box_shrink_expand

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/screens/_components/_money_dialog.dart';
import 'package:moneynote4/screens/_components/gold_graph_alert.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/gold/gold_notifier.dart';
import '../../utility/utility.dart';

class GoldAlert extends ConsumerWidget {
  GoldAlert({super.key});

  final autoScrollController = AutoScrollController();

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final goldList = ref.watch(goldListProvider.select((value) => value.goldList));

    //
    //
    // final goldListState = ref.watch(goldListProvider);
    //
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
        child: SingleChildScrollView(
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
                    GestureDetector(
                      onTap: () {
                        MoneyDialog(
                          context: context,
                          widget: GoldGraphAlert(),
                        );
                      },
                      child: const Icon(Icons.graphic_eq),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (goldList.value != null) {
                              autoScrollController.scrollToIndex(goldList.value!.length);
                            }
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
    final list = <Widget>[];

    final goldList = _ref.watch(goldListProvider.select((value) => value.goldList));

    return goldList.when(
      data: (value) {
        for (var i = 0; i < value.length; i++) {
          final date = '${value[i].year}-${value[i].month}-${value[i].day}';

          final diff = (value[i].goldValue.toString() == '-')
              ? ''
              : (value[i].goldValue.toString().toInt() - value[i].payPrice.toString().toInt()).toString();

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
                child: (value[i].goldValue.toString() == '-')
                    ? SizedBox(
                        width: double.infinity,
                        child: Text(
                          '$date（${_utility.getYoubi(youbiStr: DateTime.parse(date).youbiStr)}）',
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
                                width: 140,
                                child: Text(
                                  '$date（${_utility.getYoubi(youbiStr: DateTime.parse(date).youbiStr)}）',
                                ),
                              ),
                              const Text('1g'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(value[i].goldTanka),
                                  Text(value[i].diff.toString()),
                                ],
                              ),
                              getGoldMark(mark: value[i].upDown),
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
                                            Text(value[i].goldValue.toString()),
                                            Text(value[i].payPrice.toString()),
                                            Container(
                                              width: double.infinity,
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                diff,
                                                style: TextStyle(
                                                  color: (diff.toInt() >= 0) ? Colors.yellowAccent : Colors.redAccent,
                                                ),
                                              ),
                                            ),
                                            Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(value[i].goldPrice),
                                        Text('${value[i].gramNum} g'),
                                        Text('${value[i].totalGram} g'),
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

        return SingleChildScrollView(controller: autoScrollController, child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*


       final goldListState = _ref.watch(goldListProvider);


    for (var i = 0; i < goldListState.goldList.length; i++) {
      final date =
          '${goldListState.goldList[i].year}-${goldListState.goldList[i].month}-${goldListState.goldList[i].day}';

      final diff = (goldListState.goldList[i].goldValue.toString() == '-')
          ? ''
          : (goldListState.goldList[i].goldValue.toString().toInt() -
                  goldListState.goldList[i].payPrice.toString().toInt())
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
            child: (goldListState.goldList[i].goldValue.toString() == '-')
                ? SizedBox(
                    width: double.infinity,
                    child: Text(
                      '$date（${_utility.getYoubi(youbiStr: DateTime.parse(date).youbiStr)}）',
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
                            width: 140,
                            child: Text(
                              '$date（${_utility.getYoubi(youbiStr: DateTime.parse(date).youbiStr)}）',
                            ),
                          ),
                          const Text('1g'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(goldListState.goldList[i].goldTanka),
                              Text(goldListState.goldList[i].diff.toString()),
                            ],
                          ),
                          getGoldMark(mark: goldListState.goldList[i].upDown),
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
                                        Text(goldListState.goldList[i].goldValue.toString()),
                                        Text(goldListState.goldList[i].payPrice.toString()),
                                        Container(
                                          width: double.infinity,
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            diff,
                                            style: TextStyle(
                                              color: (diff.toInt() >= 0) ? Colors.yellowAccent : Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                        Container(),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(goldListState.goldList[i].goldPrice),
                                    Text(
                                      '${goldListState.goldList[i].gramNum} g',
                                    ),
                                    Text('${goldListState.goldList[i].totalGram} g'),
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




    */
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
          color: Colors.transparent,
        );
    }
  }
}
