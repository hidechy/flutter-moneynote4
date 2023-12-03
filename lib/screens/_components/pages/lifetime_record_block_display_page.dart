import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../models/lifetime.dart';
import '../../../state/lifetime/lifetime_notifier.dart';
import '../_money_dialog.dart';
import '../_parts/lifetime_display_parts.dart';
import '../monthly_calendar_alert.dart';

// ignore: must_be_immutable
class LifetimeRecordBlockDisplayPage extends ConsumerWidget {
  LifetimeRecordBlockDisplayPage({super.key, required this.date});

  final DateTime date;

  List<String> youbiList = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
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
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),
              Expanded(child: _getCalendarBlock()),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _getCalendarBlock() {
    final lifetimeMap = _ref.watch(lifetimeYearlyProvider(date).select((value) => value.lifetimeMap));

    final onedayWidth = (_context.screenSize.width * 0.75 / 31).floor().toDouble();

    return lifetimeMap.when(
      data: (value) {
        final monthlyLifetimeListMap = <String, List<Lifetime>>{};

        value
          ..forEach((key, value) {
            monthlyLifetimeListMap['${value.year}-${value.month}'] = [];
          })
          ..forEach((key, value) {
            monthlyLifetimeListMap['${value.year}-${value.month}']?.add(value);
          });

        final list = <Widget>[];

        monthlyLifetimeListMap.forEach((key, value) {
          final exKey = key.split('-');

          var index = DateTime.now().month - DateTime(exKey[0].toInt(), exKey[1].toInt()).month;

          if (DateTime.now().year > DateTime(exKey[0].toInt(), exKey[1].toInt()).year) {
            index += 12;
          }

          list.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(key),
              IconButton(
                onPressed: () {
                  MoneyDialog(
                    context: _context,
                    widget: MonthlyCalendarAlert(date: date, index: index),
                  );
                },
                icon: Icon(
                  Icons.ac_unit,
                  size: 14,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ));

          final list2 = <Widget>[];
          for (var i = 0; i <= 30; i++) {
            if (i < value.length) {
              final youbi = DateTime(exKey[0].toInt(), exKey[1].toInt(), i + 1).youbiStr;
              final youbiNum = youbiList.indexWhere((element) => element == youbi);

              list2.add(
                Column(
                  children: [
                    Text(
                      (youbiNum == 0) ? '${(i + 1).toString().padLeft(2, '0')}\n日' : '*\n空',
                      style: TextStyle(
                        color: (youbiNum == 0) ? Colors.yellowAccent : Colors.transparent,
                        fontSize: 7,
                      ),
                    ),
                    const SizedBox(height: 3),
                    SizedBox(
                      width: onedayWidth,
                      child: LifetimeDisplayParts(lifetime: value[i], textDisplay: false),
                    ),
                  ],
                ),
              );
            } else {
              list2.add(SizedBox(width: onedayWidth, child: const Text('')));
            }
          }

          list
            ..add(Row(children: list2))
            ..add(const SizedBox(height: 30));
        });

        return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
