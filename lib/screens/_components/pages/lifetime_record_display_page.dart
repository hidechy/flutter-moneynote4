import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../models/walk_record.dart';
import '../../../state/app_param/app_param_notifier.dart';
import '../../../state/lifetime/lifetime_notifier.dart';
import '../../../state/time_place/time_place_notifier.dart';
import '../../../state/walk_record/walk_record_notifier.dart';
import '../_money_dialog.dart';
import '../_parts/lifetime_display_parts.dart';
import '../lifetime_record_display_alert.dart';
import '../lifetime_record_input_alert.dart';

// ignore: must_be_immutable
class LifetimeRecordDisplayPage extends ConsumerWidget {
  LifetimeRecordDisplayPage({super.key, required this.date});

  final DateTime date;

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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(width: context.screenSize.width),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${date.yyyymmdd}（${date.youbiStr.substring(0, 3)}）'),
                      GestureDetector(
                        onTap: () => MoneyDialog(context: context, widget: LifetimeRecordInputAlert(date: date)),
                        child: Icon(Icons.input, color: Colors.white.withOpacity(0.6)),
                      ),
                    ],
                  ),
                  Expanded(child: _displayLifetime()),
                ],
              ),
              Column(
                children: [
                  Expanded(child: Container()),
                  _displayNextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget _displayNextButton() {
    final selectedYearlyCalendarDate = _ref.watch(appParamProvider.select((value) => value.selectedYearlyCalendarDate));

    var dayDiff = 0;

    if (selectedYearlyCalendarDate != null) {
      dayDiff = date.difference(selectedYearlyCalendarDate).inDays;
    }

    return Column(
      children: [
        if (dayDiff == -3 && selectedYearlyCalendarDate != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () async {
                  await _ref.read(appParamProvider.notifier).setSelectedYearlyCalendarDate(
                        date: selectedYearlyCalendarDate.add(const Duration(days: -7)),
                      );

                  if (_context.mounted) {
                    Navigator.pop(_context);
                  }

                  if (_context.mounted) {
                    await MoneyDialog(
                      context: _context,
                      widget: LifetimeRecordDisplayAlert(
                        date: selectedYearlyCalendarDate.add(const Duration(days: -7)),
                        beforeNextPageIndex: 6,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.navigate_before, color: Colors.greenAccent),
              ),
              Container(),
            ],
          ),
        ],
        if (dayDiff == 3 && selectedYearlyCalendarDate != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              IconButton(
                onPressed: () async {
                  await _ref.read(appParamProvider.notifier).setSelectedYearlyCalendarDate(
                        date: selectedYearlyCalendarDate.add(const Duration(days: 7)),
                      );

                  if (_context.mounted) {
                    Navigator.pop(_context);
                  }

                  if (_context.mounted) {
                    await MoneyDialog(
                      context: _context,
                      widget: LifetimeRecordDisplayAlert(
                        date: selectedYearlyCalendarDate.add(const Duration(days: 7)),
                        beforeNextPageIndex: 0,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.navigate_next, color: Colors.greenAccent),
              ),
            ],
          ),
        ],
      ],
    );
  }

  ///
  Widget _displayLifetime() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _displayLifetimeRecord()),
        Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(5),
                  child: _displayTimeplace(),
                ),
              ],
            )),
      ],
    );
  }

  ///
  Widget _displayTimeplace() {
    final timePlaceList = _ref.watch(timeplaceProvider(date).select((value) => value.timePlaceList));

    return timePlaceList.when(
      data: (value) {
        final list = <Widget>[];

        for (var i = 0; i < value.length; i++) {
          if (value[i].date.yyyymmdd == date.yyyymmdd) {
            final color = (value[i].place == '移動中') ? Colors.greenAccent : Colors.white;

            list.add(
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
                child: DefaultTextStyle(
                  style: TextStyle(color: color, fontSize: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 60, child: Text(value[i].time)),
                      Expanded(child: Text(value[i].place)),
                      Container(
                        width: 50,
                        alignment: Alignment.topRight,
                        child: Text(value[i].price.toString().toCurrency()),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }

        return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*




    final monthlyTimeplaceState = _ref.watch(timeplaceProvider(date));

    final timeplaceState = monthlyTimeplaceState.where((element) => element.date.yyyymmdd == date.yyyymmdd).toList();

    final list = <Widget>[];

    for (var i = 0; i < timeplaceState.length; i++) {
      final color = (timeplaceState[i].place == '移動中') ? Colors.greenAccent : Colors.white;

      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: DefaultTextStyle(
            style: TextStyle(color: color, fontSize: 10),
            child: Row(
              children: [
                SizedBox(width: 60, child: Text(timeplaceState[i].time)),
                Expanded(child: Text(timeplaceState[i].place)),
                Container(
                  width: 50,
                  alignment: Alignment.topRight,
                  child: Text(timeplaceState[i].price.toString().toCurrency()),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list));




    */
  }

  ///
  Widget _displayLifetimeRecord() {
    final lifetimeState = _ref.watch(lifetimeProvider(date));

    //============================//
    final walkRecordMap = _ref.watch(walkRecordProvider(date).select((value) => value.walkRecordMap));

    var walkRecord =
        WalkRecord(date: date, step: 0, distance: 0, timeplace: '', temple: '', mercari: '', train: '', spend: '');

    walkRecordMap.value?.forEach((key, val) {
      if (date.yyyymmdd == val.date.yyyymmdd) {
        walkRecord = val;
      }
    });

    /*


    walkRecordMap.when(
      data: (value) {
        value.forEach((key, val) {
          if (date.yyyymmdd == val.date.yyyymmdd) {
            walkRecord = val;
          }
        });

        return Container();
      },
      error: (error, stackTrace) => Container(),
      loading: Container.new,
    );



    */

    //============================//

    if (lifetimeState.lifetime == null) {
      return Container();
    } else {
      return LifetimeDisplayParts(
        lifetime: lifetimeState.lifetime!,
        walkRecord: (walkRecord.step > 0) ? walkRecord : null,
      );
    }
  }
}
