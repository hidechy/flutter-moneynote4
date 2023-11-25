// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/money/money_notifier.dart';
import '../../utility/utility.dart';
import '_money_dialog.dart';
import 'money_score_graph_alert.dart';

class MoneyScoreAlert extends ConsumerWidget {
  MoneyScoreAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Map<String, int> graphSagakuMap = {};
  Map<String, int> graphScoreMap = {};

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  GestureDetector(
                    onTap: () {
                      MoneyDialog(
                        context: context,
                        widget: MoneyScoreGraphAlert(
                          date: date,
                          graphSagakuMap: graphSagakuMap,
                          graphScoreMap: graphScoreMap,
                        ),
                      );
                    },
                    child: const Icon(Icons.graphic_eq),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Expanded(child: displayMoneyScore()),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayMoneyScore() {
    final sagakuMap = <String, List<int>>{};

    final moneyScoreList = _ref.watch(moneyScoreProvider.select((value) => value.moneyScoreList));

    moneyScoreList.value?.forEach((element) {
      sagakuMap[DateTime(element.ym.split('-')[0].toInt()).yyyy] = [];
    });

    moneyScoreList.value?.forEach((element) {
      if (element.ym != '2014-06') {
        sagakuMap[DateTime(element.ym.split('-')[0].toInt()).yyyy]?.add(element.sagaku);

        graphSagakuMap[element.ym] = element.sagaku * -1;
      }
    });

    // final moneyScoreState = _ref.watch(moneyScoreProvider);
    //
    // moneyScoreState
    //   ..forEach((element) {
    //     sagakuMap[DateTime(element.ym.split('-')[0].toInt()).yyyy] = [];
    //   })
    //   ..forEach((element) {
    //     if (element.ym != '2014-06') {
    //       sagakuMap[DateTime(element.ym.split('-')[0].toInt()).yyyy]?.add(element.sagaku);
    //
    //       graphSagakuMap[element.ym] = element.sagaku * -1;
    //     }
    //   });
    //
    //
    //

    final yearTotalMap = <String, int>{};
    sagakuMap.entries.forEach((element) {
      var total = 0;
      element.value.forEach((element2) {
        total += element2 * -1;
      });
      yearTotalMap[element.key] = total;
    });

    final list = <Widget>[];

    return moneyScoreList.when(
      data: (value) {
        for (var i = 1; i < value.length; i++) {
          final sagaku = (value[i].updown == 1) ? value[i].sagaku * -1 : value[i].sagaku;

          final spend = (value[i].updown == 1) ? (value[i].benefit - sagaku) : value[i].benefit + sagaku;

          final year = DateTime(value[i].ym.split('-')[0].toInt(), value[i].ym.split('-')[1].toInt()).year;

          final month = DateTime(value[i].ym.split('-')[0].toInt(), value[i].ym.split('-')[1].toInt()).month;

          graphScoreMap[value[i].ym] = value[i].price;

          if ((year != 2014 && month == 1) || (year == 2014 && month == 7)) {
            list.add(
              Column(
                children: [
                  if (i != 1) Container(margin: const EdgeInsets.only(top: 50)),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(color: Colors.yellowAccent.withOpacity(0.3)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(year.toString()),
                        Text(yearTotalMap[year.toString()].toString().toCurrency()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          list.add(
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(value[i].ym, style: const TextStyle(fontSize: 16)),
                            Text(value[i].price.toString().toCurrency()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Text(value[i].benefit.toString().toCurrency()),
                              ],
                            ),
                            Text(spend.toString().toCurrency()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 60,
                    child: Column(
                      children: [
                        dispUpDownIcon(mark: value[i].updown),
                        Text(sagaku.toString().toCurrency()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*





    //forで仕方ない
    for (var i = 1; i < moneyScoreState.length; i++) {
      final sagaku = (moneyScoreState[i].updown == 1) ? moneyScoreState[i].sagaku * -1 : moneyScoreState[i].sagaku;

      final spend = (moneyScoreState[i].updown == 1)
          ? (moneyScoreState[i].benefit - sagaku)
          : moneyScoreState[i].benefit + sagaku;

      final year = DateTime(
        moneyScoreState[i].ym.split('-')[0].toInt(),
        moneyScoreState[i].ym.split('-')[1].toInt(),
      ).year;

      final month = DateTime(
        moneyScoreState[i].ym.split('-')[0].toInt(),
        moneyScoreState[i].ym.split('-')[1].toInt(),
      ).month;

      graphScoreMap[moneyScoreState[i].ym] = moneyScoreState[i].price;

      if ((year != 2014 && month == 1) || (year == 2014 && month == 7)) {
        list.add(
          Column(
            children: [
              if (i != 1)
                Container(
                  margin: const EdgeInsets.only(top: 50),
                ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(year.toString()),
                    Text(yearTotalMap[year.toString()].toString().toCurrency()),
                  ],
                ),
              ),
            ],
          ),
        );
      }

      list.add(
        Container(
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
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(moneyScoreState[i].ym, style: const TextStyle(fontSize: 16)),
                        Text(moneyScoreState[i].price.toString().toCurrency()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Text(
                              moneyScoreState[i].benefit.toString().toCurrency(),
                            ),
                          ],
                        ),
                        Text(spend.toString().toCurrency()),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 60,
                child: Column(
                  children: [
                    dispUpDownIcon(mark: moneyScoreState[i].updown),
                    Text(sagaku.toString().toCurrency()),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(children: list),
    );




    */
  }

  ///
  Widget dispUpDownIcon({required int mark}) {
    switch (mark) {
      case 1:
        return const Icon(
          Icons.arrow_upward,
          color: Colors.greenAccent,
        );
      case 0:
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
