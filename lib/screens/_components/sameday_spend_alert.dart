// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/money/money_notifier.dart';
import '../../state/spend/spend_notifier.dart';
import '../../utility/utility.dart';
import '_money_dialog.dart';
import 'monthly_spend_alert.dart';
import 'sameday_spend_graph_alert.dart';
import 'spend_summary_halfyear_alert.dart';

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
                  onTap: () => MoneyDialog(context: context, widget: SpendSummaryHalfyearAlert()),
                  child: const Icon(Icons.line_style),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: context.screenSize.height - 170,
                  child: Row(
                    children: [
                      SizedBox(width: 30, child: displayDaySelect()),
                      const SizedBox(width: 20),
                      Expanded(child: displaySamedaySpendList()),
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
    final SamedaySpendAlertDay = _ref.watch(appParamProvider.select((value) => value.SamedaySpendAlertDay));

    final list = <Widget>[];

    for (var i = 1; i <= 31; i++) {
      list.add(
        GestureDetector(
          onTap: () {
            _ref.read(appParamProvider.notifier).setSamedaySpendAlertDay(day: i);

            _ref.read(spendSamedayProvider(date).notifier).getSamedaySpend(
                  date: DateTime(date.yyyymm.split('-')[0].toInt(), date.yyyymm.split('-')[1].toInt(), i),
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

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  Widget displaySamedaySpendList() {
    final list = <Widget>[];

    var j = 0;

    final spendSamedayList = _ref.watch(spendSamedayProvider(date).select((value) => value.spendSamedayList));

    return spendSamedayList.when(
      data: (value) {
        for (var i = value.length - 1; i >= 0; i--) {
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
                            Text(value[i].ym),
                            Text(value[i].sum.toString().toCurrency()),
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
                              ? displayThisMonthItem(sum: value[i].sum)
                              : displayPastMonthItem(sum: value[i].sum, ym: value[i].ym),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final year = value[i].ym.split('-')[0].toInt();
                          final month = value[i].ym.split('-')[1].toInt();

                          final selectedMonth = DateTime(year, month).month;
                          final todayMonth = DateTime.now().month;

                          MoneyDialog(
                            context: _context,
                            widget: MonthlySpendAlert(date: DateTime(year, month), index: todayMonth - selectedMonth),
                          );
                        },
                        child: Icon(Icons.info_outline, color: Colors.white.withOpacity(0.6)),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          MoneyDialog(
                            context: _context,
                            widget: SamedaySpendGraphAlert(
                              date: DateTime(value[i].ym.split('-')[0].toInt(), value[i].ym.split('-')[1].toInt()),
                            ),
                          );
                        },
                        child: Icon(Icons.graphic_eq, color: Colors.white.withOpacity(0.6)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );

          j++;
        }

        return SingleChildScrollView(child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  ///
  Widget displayThisMonthItem({required int sum}) {
    final SamedaySpendAlertDay = _ref.watch(appParamProvider.select((value) => value.SamedaySpendAlertDay));

    final wari = sum / SamedaySpendAlertDay;

    final monthEnd = DateTime(date.year, date.month + 1, 0);

    final estimate = wari.round().toString().split('.')[0].toInt() * monthEnd.day;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(wari.round().toString().split('.')[0].toCurrency()),
        Text(estimate.toString().toCurrency()),
      ],
    );
  }

  ///
  Widget displayPastMonthItem({required int sum, required String ym}) {
    var spend = 0;

    return _ref.watch(moneyScoreProvider.select((value) => value.moneyScoreList)).when(
          data: (value) {
            for (var i = 1; i < value.length; i++) {
              if (value[i].ym == ym) {
                final sagaku = (value[i].updown == 1) ? value[i].sagaku * -1 : value[i].sagaku;

                spend = (value[i].updown == 1) ? (value[i].benefit - sagaku) : value[i].benefit + sagaku;
              }
            }

            final wari = ((sum * 100) / spend).toString().split('.')[0];

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(spend.toString().toCurrency()), Text('$wari %')],
            );
          },
          error: (error, stackTrace) => Container(),
          loading: Container.new,
        );
  }
}
