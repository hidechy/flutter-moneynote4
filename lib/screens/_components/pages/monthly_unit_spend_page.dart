// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/spend/spend_notifier.dart';
import '../../../utility/utility.dart';
import '../_money_dialog.dart';
import '../monthly_spend_alert.dart';
import '../monthly_unit_spend_graph_alert.dart';

class MonthlyUnitSpendPage extends ConsumerWidget {
  MonthlyUnitSpendPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

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

              Container(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => MoneyDialog(context: context, widget: MonthlyUnitSpendGraphAlert(date: date)),
                  child: const Icon(Icons.graphic_eq),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(child: displayMonthlyUnitSpend()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayMonthlyUnitSpend() {
    final spendMonthUnitMap = _ref.watch(spendMonthUnitProvider(date).select((value) => value.spendMonthUnitMap));

    return SingleChildScrollView(
      child: (spendMonthUnitMap.value != null)
          ? Column(
              children: spendMonthUnitMap.value!.entries.map((e) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e.key),
                      Row(
                        children: [
                          Text(e.value.toString().toCurrency()),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              final selectedMonth =
                                  DateTime(e.key.split('-')[0].toInt(), e.key.split('-')[1].toInt()).month;
                              final todayMonth = DateTime.now().month;

                              final thisYear = DateTime.now().year;
                              final selectedYear =
                                  DateTime(e.key.split('-')[0].toInt(), e.key.split('-')[1].toInt()).year;
                              final adjustMonth = (thisYear - selectedYear) * 12;

                              MoneyDialog(
                                context: _context,
                                widget: MonthlySpendAlert(
                                  date: DateTime(e.key.split('-')[0].toInt(), e.key.split('-')[1].toInt()),
                                  index: todayMonth - selectedMonth + adjustMonth,
                                ),
                              );
                            },
                            child: Icon(Icons.details, color: Colors.white.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          : Container(),
    );

    /*



    final spendMonthUnitState = _ref.watch(spendMonthUnitProvider(date));

    return SingleChildScrollView(
      child: Column(
        children: spendMonthUnitState.entries.map((e) {
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(e.key),
                Row(
                  children: [
                    Text(e.value.toString().toCurrency()),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        final selectedMonth = DateTime(e.key.split('-')[0].toInt(), e.key.split('-')[1].toInt()).month;
                        final todayMonth = DateTime.now().month;

                        final thisYear = DateTime.now().year;
                        final selectedYear = DateTime(e.key.split('-')[0].toInt(), e.key.split('-')[1].toInt()).year;
                        final adjustMonth = (thisYear - selectedYear) * 12;

                        MoneyDialog(
                          context: _context,
                          widget: MonthlySpendAlert(
                            date: DateTime(e.key.split('-')[0].toInt(), e.key.split('-')[1].toInt()),
                            index: todayMonth - selectedMonth + adjustMonth,
                          ),
                        );
                      },
                      child: Icon(Icons.details, color: Colors.white.withOpacity(0.8)),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );




    */
  }
}
