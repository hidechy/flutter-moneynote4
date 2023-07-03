// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';
import 'package:moneynote4/screens/_components/_money_dialog.dart';
import 'package:moneynote4/screens/_components/monthly_spend_alert.dart';
import 'package:moneynote4/screens/_components/sameday_spend_graph_alert.dart';
import 'package:moneynote4/screens/_components/spend_summary_halfyear_alert.dart';
import 'package:uuid/uuid.dart';

import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/money_notifier.dart';
import '../../viewmodel/spend_notifier.dart';

class SamedaySpendAlert extends ConsumerWidget {
  SamedaySpendAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Uuid uuid = const Uuid();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
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
                if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                GestureDetector(
                  onTap: () {
                    MoneyDialog(
                      context: context,
                      widget: SpendSummaryHalfyearAlert(),
                    );
                  },
                  child: const Icon(Icons.line_style),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: context.screenSize.height - 170,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: displayDaySelect(),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: displaySamedaySpendList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayDaySelect() {
    final SamedaySpendAlertDay = _ref.watch(
      appParamProvider.select((value) => value.SamedaySpendAlertDay),
    );

    final list = <Widget>[];

    for (var i = 1; i <= 31; i++) {
      list.add(
        GestureDetector(
          onTap: () {
            _ref.watch(appParamProvider.notifier).setSamedaySpendAlertDay(day: i);

            _ref.watch(samedaySpendProvider(date).notifier).getSamedaySpend(
                  date: DateTime(
                    date.yyyymm.split('-')[0].toInt(),
                    date.yyyymm.split('-')[1].toInt(),
                    i,
                  ),
                );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: (i == SamedaySpendAlertDay) ? Colors.yellowAccent.withOpacity(0.2) : null,
            ),
            child: Text(i.toString()),
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
  Widget displaySamedaySpendList() {
    final samedaySpendState = _ref.watch(samedaySpendProvider(date));

    final list = <Widget>[];

    var j = 0;

    for (var i = samedaySpendState.length - 1; i >= 0; i--) {
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
                        Text(samedaySpendState[i].ym),
                        Text(samedaySpendState[i].sum.toString().toCurrency()),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 3),
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                        color: (j == 0) ? Colors.greenAccent.withOpacity(0.1) : Colors.blueAccent.withOpacity(0.1),
                      ),
                      child: (j == 0)
                          ? displayThisMonthItem(sum: samedaySpendState[i].sum)
                          : displayPastMonthItem(
                              sum: samedaySpendState[i].sum,
                              ym: samedaySpendState[i].ym,
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      final year = samedaySpendState[i].ym.split('-')[0].toInt();
                      final month = samedaySpendState[i].ym.split('-')[1].toInt() + 1;

                      MoneyDialog(
                        context: _context,
                        widget: MonthlySpendAlert(
                          date: DateTime(year, month),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      MoneyDialog(
                        context: _context,
                        widget: SamedaySpendGraphAlert(
                          date: DateTime(
                            samedaySpendState[i].ym.split('-')[0].toInt(),
                            samedaySpendState[i].ym.split('-')[1].toInt(),
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.graphic_eq,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      j++;
    }

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }

  ///
  Widget displayThisMonthItem({required int sum}) {
    final SamedaySpendAlertDay = _ref.watch(
      appParamProvider.select((value) => value.SamedaySpendAlertDay),
    );

    final wari = sum / SamedaySpendAlertDay;

    final monthEnd = DateTime(date.year, date.month + 1, 0);

    final estimate = wari.toString().split('.')[0].toInt() * monthEnd.day;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(wari.toString().split('.')[0].toCurrency()),
        Text(estimate.toString().toCurrency()),
      ],
    );
  }

  ///
  Widget displayPastMonthItem({required int sum, required String ym}) {
    final moneyScoreState = _ref.watch(moneyScoreProvider);

    var spend = 0;

    //forで仕方ない
    for (var i = 1; i < moneyScoreState.length; i++) {
      if (moneyScoreState[i].ym == ym) {
        final sagaku = (moneyScoreState[i].updown == 1) ? moneyScoreState[i].sagaku * -1 : moneyScoreState[i].sagaku;

        spend = (moneyScoreState[i].updown == 1)
            ? (moneyScoreState[i].benefit - sagaku)
            : moneyScoreState[i].benefit + sagaku;
      }
    }

    final wari = ((sum * 100) / spend).toString().split('.')[0];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(spend.toString().toCurrency()),
        Text('$wari %'),
      ],
    );
  }
}
