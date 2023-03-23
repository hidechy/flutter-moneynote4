// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/money_notifier.dart';

class MoneyScoreAlert extends ConsumerWidget {
  MoneyScoreAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

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
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(width: context.screenSize.width),

                //----------//
                if (deviceInfoState.model == 'iPhone')
                  _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                /*





                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    GestureDetector(
                      onTap: () {
                        MoneyDialog(
                          context: context,
                          widget: MoneyScoreGraphAlert(date: date),
                        );
                      },
                      child: const Icon(Icons.graphic_eq),
                    ),
                  ],
                ),

                const SizedBox(height: 20),



                */

                displayMoneyScore(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayMoneyScore() {
    final moneyScoreState = _ref.watch(moneyScoreProvider);

    //-----------------------------------------------
    final totalMap = <String, int>{};
    var keepYear = 0;
    var total = 0;

    moneyScoreState.forEach((element) {
      final year = DateTime(
        element.ym.split('-')[0].toInt(),
        element.ym.split('-')[1].toInt(),
      ).year;

      if (year != keepYear) {
        total = 0;
      }

      final sagaku =
          (element.updown == 1) ? element.sagaku * -1 : element.sagaku;

      switch (element.updown) {
        case 0:
          total -= sagaku;
          break;
        case 1:
          total += sagaku;
          break;
      }

      totalMap[year.toString()] = total;

      keepYear = DateTime(
        element.ym.split('-')[0].toInt(),
        element.ym.split('-')[1].toInt(),
      ).year;
    });

    //-----------------------------------------------

    final list = <Widget>[];

    //forで仕方ない
    for (var i = 1; i < moneyScoreState.length; i++) {
      final sagaku = (moneyScoreState[i].updown == 1)
          ? moneyScoreState[i].sagaku * -1
          : moneyScoreState[i].sagaku;

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

      if ((year != 2014 && month == 1) || (year == 2014 && month == 7)) {
        final ttl = totalMap[year.toString()].toString().toCurrency();

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
                    Container(),
                    Text(ttl),
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
                        Text(
                          moneyScoreState[i].ym,
                          style: const TextStyle(fontSize: 16),
                        ),
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
                              moneyScoreState[i]
                                  .benefit
                                  .toString()
                                  .toCurrency(),
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
