// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/screens/_components/money_score_graph_alert.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../viewmodel/money_notifier.dart';
import '_money_dialog.dart';

class MoneyScoreAlert extends ConsumerWidget {
  MoneyScoreAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

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
                // Row(children: yearWidgetList),
                // const SizedBox(height: 20),

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
    );
  }

  ///
  Widget displayMoneyScore() {
    final moneyScoreState = _ref.watch(moneyScoreProvider);

    final list = <Widget>[];
    for (var i = 0; i < moneyScoreState.length; i++) {
      final price =
          (moneyScoreState[i].price == '-') ? '0' : moneyScoreState[i].price;

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
              Expanded(child: Text(moneyScoreState[i].ym)),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(price.toCurrency()),
                ),
              ),
              SizedBox(
                width: 100,
                child: (i == moneyScoreState.length - 1)
                    ? Column(children: const [Text(''), Text('')])
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          dispUpDownIcon(mark: moneyScoreState[i].updown),
                          Text(moneyScoreState[i].sagaku.toCurrency()),
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
