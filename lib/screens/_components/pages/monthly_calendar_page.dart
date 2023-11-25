import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../models/walk_record.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/holiday/holiday_notifier.dart';
import '../../../state/lifetime/lifetime_notifier.dart';
import '../../../state/walk_record/walk_record_notifier.dart';
import '../../../utility/utility.dart';
import '../_parts/lifetime_display_parts.dart';

// ignore: must_be_immutable
class MonthlyCalendarPage extends ConsumerWidget {
  MonthlyCalendarPage({super.key, required this.date});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(width: context.screenSize.width),

            //----------//
            if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
            //----------//

            Expanded(child: displayMonthlyLifetimeData()),
          ],
        ),
      ),
    );
  }

  ///
  Widget displayMonthlyLifetimeData() {
    final lifetimeMap = _ref.watch(lifetimeYearlyProvider(date).select((value) => value.lifetimeMap));

    //============================//
    final walkRecordMap = _ref.watch(walkRecordProvider(date).select((value) => value.walkRecordMap));

    final monthlyWalkRecord = <String, WalkRecord>{};

    walkRecordMap.value?.forEach((key, val) {
      if (date.year == val.date.year && date.month == val.date.month) {
        monthlyWalkRecord[val.date.yyyymmdd] = val;
      }
    });

    /*

    walkRecordMap.when(
      data: (value) {
        value.forEach((key, val) {
          if (date.year == val.date.year && date.month == val.date.month) {
            monthlyWalkRecord[val.date.yyyymmdd] = val;
          }
        });

        return Container();
      },
      error: (error, stackTrace) => Container(),
      loading: Container.new,
    );

    */

    //============================//

    final holidayState = _ref.watch(holidayProvider);

    return lifetimeMap.when(
      data: (value) {
        final list = <Widget>[];

        value.forEach((key, val) {
          if (date.year == val.year.toInt() && date.month == val.month.toInt()) {
            final date = '$key（${DateTime.parse('$key 00:00:00').youbiStr.substring(0, 3)}）';

            list.add(
              Container(
                width: _context.screenSize.width / 3,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _utility.getYoubiColor(
                          date: DateTime.parse('$key 00:00:00'),
                          youbiStr: DateTime.parse('$key 00:00:00').youbiStr,
                          holiday: holidayState.data,
                        ),
                      ),
                      padding: const EdgeInsets.all(3),
                      child: Text(date),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: LifetimeDisplayParts(
                        lifetime: val,
                        walkRecord: (monthlyWalkRecord[key] != null) ? monthlyWalkRecord[key] : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DefaultTextStyle(style: const TextStyle(fontSize: 10), child: Row(children: list)),
        );
      },
      error: (error, stackTrace) => Container(),
      loading: Container.new,
    );
  }
}
