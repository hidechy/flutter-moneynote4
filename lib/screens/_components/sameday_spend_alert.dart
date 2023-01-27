// ignore_for_file: must_be_immutable

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
                if (deviceInfoState.model == 'iPhone')
                  _utility.getFileNameDebug(name: runtimeType.toString()),
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
                  height: context.screenSize.height - 270,
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
    final appParamState = _ref.watch(appParamProvider);

    final list = <Widget>[];

    for (var i = 1; i <= 31; i++) {
      list.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(appParamProvider.notifier)
                .setSamedaySpendAlertDay(day: i);

            _ref.watch(samedaySpendProvider(date).notifier).getSamedaySpend(
                  date:
                      '${date.yyyymm}-${i.toString().padLeft(2, '0')} 00:00:00'
                          .toDateTime(),
                );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: (i == appParamState.SamedaySpendAlertDay)
                  ? Colors.yellowAccent.withOpacity(0.2)
                  : null,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(samedaySpendState[i].ym),
              Row(
                children: [
                  Text(samedaySpendState[i].sum.toString().toCurrency()),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          MoneyDialog(
                            context: _context,
                            widget: MonthlySpendAlert(
                              date: '${samedaySpendState[i].ym}-01 00:00:00'
                                  .toDateTime(),
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
                              date: '${samedaySpendState[i].ym}-01 00:00:00'
                                  .toDateTime(),
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
}
