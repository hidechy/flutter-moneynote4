// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../utility/utility.dart';
import '../../../viewmodel/holiday_notifier.dart';
import '../../../viewmodel/train_notifier.dart';

class TrainPage extends ConsumerWidget {
  TrainPage({super.key, required this.date});

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

              Expanded(
                child: displayTrain(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayTrain() {
    final holidayState = _ref.watch(holidayProvider);

    final trainState = _ref.watch(trainProvider);

    final list = <Widget>[];

    for (var i = 0; i < trainState.length; i++) {
      if (date.year == trainState[i].date.year) {
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
              color: _utility.getYoubiColor(
                date: trainState[i].date,
                youbiStr: trainState[i].date.youbiStr,
                holiday: holidayState.data,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.8)),
                  ),
                  child: Column(
                    children: [
                      Text(trainState[i].date.yyyy),
                      Text(trainState[i].date.mm),
                      Text(trainState[i].date.dd),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(trainState[i].station),
                ),
                Container(
                  width: 60,
                  alignment: Alignment.topRight,
                  child: Text(trainState[i].price.toCurrency()),
                ),
              ],
            ),
          ),
        );
      }
    }

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
