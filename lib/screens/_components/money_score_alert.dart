// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/money_notifier.dart';
import '_money_dialog.dart';
import 'money_score_graph_alert.dart';

class MoneyScoreAlert extends ConsumerWidget {
  MoneyScoreAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final moneyScoreState = ref.watch(moneyScoreProvider);

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
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: moneyScoreState.saving,
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

                      displayMoneyScore(),
                    ],
                  ),
                ),
              ),
            ),
            if (moneyScoreState.saving)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  ///
  Widget displayMoneyScore() {
    final moneyScoreState = _ref.watch(moneyScoreProvider);

    //--------------------------------------//
    final yearScore = <int, List<int>>{};
    final yearScore2 = <int, int>{};

    var keepYear = '';
    var scoreList = <int>[];
    final yearList = <int>[];

    for (var i = 0; i < moneyScoreState.list.length; i++) {
      final ymd = '${moneyScoreState.list[i].ym}-01 00:00:00'.toDateTime();

      if (keepYear != ymd.yyyy) {
        yearList.add(ymd.yyyy.toInt());
        scoreList = [];
      }

      scoreList.add(moneyScoreState.list[i].sag);

      yearScore[ymd.yyyy.toInt()] = scoreList;

      keepYear = ymd.yyyy;
    }

    if (yearScore[DateTime.now().yyyy.toInt()] != null) {
      yearScore[DateTime.now().yyyy.toInt()]!.removeLast();

      yearList.forEach((element) {
        var sum = 0;
        yearScore[element]!.forEach((element2) {
          sum += element2;
        });
        yearScore2[element] = sum;
      });
    }

    //--------------------------------------//

    final list = <Widget>[];
    for (var i = 0; i < moneyScoreState.list.length; i++) {
      final price = (moneyScoreState.list[i].price == '-')
          ? '0'
          : moneyScoreState.list[i].price;

      //--------------------------------------//
      final ymd = '${moneyScoreState.list[i].ym}-01 00:00:00'.toDateTime();

      if (ymd.mm == '01') {
        if (yearScore2[ymd.yyyy.toInt()] != null) {
          list.add(
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.all(5),
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                color: Colors.yellowAccent.withOpacity(0.2),
              ),
              child: Text(
                yearScore2[ymd.yyyy.toInt()].toString().toCurrency(),
              ),
            ),
          );
        }
      }
      //--------------------------------------//

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
          child: Row(
            children: [
              Expanded(child: Text(moneyScoreState.list[i].ym)),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(price.toCurrency()),
                ),
              ),
              SizedBox(
                width: 100,
                child: (i == moneyScoreState.list.length - 1)
                    ? Column(children: const [Text(''), Text('')])
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          dispUpDownIcon(mark: moneyScoreState.list[i].updown),
                          Text(moneyScoreState.list[i].sagaku.toCurrency()),
                        ],
                      ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }

  ///
  Widget dispUpDownIcon({required String mark}) {
    switch (mark) {
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
