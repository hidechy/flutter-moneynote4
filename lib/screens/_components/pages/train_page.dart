// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/holiday/holiday_notifier.dart';
import '../../../state/train/train_notifier.dart';
import '../../../utility/utility.dart';

class TrainPage extends ConsumerWidget {
  TrainPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  List<String> dateList = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeDateList();

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
  void makeDateList() {
    dateList = [];

    final firstDate = DateTime(2020);

    final diff = DateTime.now().difference(firstDate).inDays;

    for (var i = 0; i <= diff; i++) {
      if (firstDate.add(Duration(days: i)).year == date.year) {
        dateList.add(firstDate.add(Duration(days: i)).yyyymmdd);
      }
    }
  }

  ///
  Widget displayTrain() {
    final holidayState = _ref.watch(holidayProvider);

    final list = <Widget>[];

    final trainMap = _ref.watch(trainProvider.select((value) => value.trainMap));

    dateList.forEach((element) {
      final youbi = '$element 00:00:00'.toDateTime().youbiStr;

      list.add((trainMap[element] != null)
          ? Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                color: _utility.getYoubiColor(
                  date: '$element 00:00:00'.toDateTime(),
                  youbiStr: youbi,
                  holiday: holidayState.data,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$element (${youbi.substring(0, 3)})'),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(trainMap[element]!.station),
                      ),
                      Container(
                        width: 60,
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(trainMap[element]!.price.toCurrency()),
                            if (trainMap[element]!.oufuku == '1') ...[
                              const SizedBox(height: 10),
                              Icon(
                                Icons.refresh,
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$element (${youbi.substring(0, 3)})',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Container(),
                ],
              ),
            ));
    });

    return SingleChildScrollView(child: Column(children: list));
  }
}
