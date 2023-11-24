// ignore_for_file: must_be_immutable, use_named_constants

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/spend/spend_notifier.dart';
import '../../../state/temple/temple_notifier.dart';
import '../../../state/time_place/time_place_notifier.dart';
import '../../../state/train/train_notifier.dart';
import '../../../utility/utility.dart';
import '../_money_dialog.dart';
import '../temple_display_alert.dart';
import '../time_location_alert.dart';

class SpendPage extends ConsumerWidget {
  SpendPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  int diff = 0;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final deviceInfoState = ref.read(deviceInfoProvider);

    makeDiff();

    final templeMap = ref.watch(templeProvider.select((value) => value.templeMap));

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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Container(), Text(diff.toString().toCurrency())],
              ),

              const SizedBox(height: 20),

              SizedBox(width: double.infinity, height: context.screenSize.height * 0.2, child: displaySpendItem()),

              Divider(color: Colors.yellowAccent.withOpacity(0.2), thickness: 5),

              SizedBox(
                width: double.infinity,
                height: context.screenSize.height * 0.2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => MoneyDialog(context: context, widget: TimeLocationAlert(date: date)),
                            child: Icon(Icons.info_outline, color: Colors.white.withOpacity(0.6), size: 16),
                          ),
                          if (templeMap[date.yyyymmdd] != null) ...[
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () => MoneyDialog(
                                context: context,
                                widget: TempleDisplayAlert(date: date, temple: templeMap[date.yyyymmdd]!),
                              ),
                              child: Icon(FontAwesomeIcons.toriiGate, color: Colors.white.withOpacity(0.6), size: 16),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(child: displayTimeplace()),
                  ],
                ),
              ),

              Divider(color: Colors.yellowAccent.withOpacity(0.2), thickness: 5),

              SizedBox(width: double.infinity, height: context.screenSize.height * 0.2, child: displayTrainRecord()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayTrainRecord() {
    final trainMap = _ref.watch(trainProvider.select((value) => value.trainMap));

    if (trainMap[date.yyyymmdd] != null) {
      return Text(
        trainMap[date.yyyymmdd]!.station,
        style: const TextStyle(color: Colors.greenAccent, fontSize: 10),
      );
    }

    return Container();
  }

  ///
  void makeDiff() {
    diff = 0;

    final spendItemDaily = _ref.watch(spendItemDailyProvider(date).select((value) => value.spendItemDaily));

    spendItemDaily.value?.item.forEach((element) {
      final exValue = element.split('|');

      if (exValue[0] == '収入') {
        diff -= exValue[2].toInt();
      } else {
        diff += exValue[2].toInt();
      }
    });

    //
    //
    // final spendItemDailyState = _ref.watch(spendItemDailyProvider(date));
    //
    // for (var i = 0; i < spendItemDailyState.item.length; i++) {
    //   final exValue = spendItemDailyState.item[i].split('|');
    //
    //   if (exValue[0] == '収入') {
    //     diff -= exValue[2].toInt();
    //   } else {
    //     diff += exValue[2].toInt();
    //   }
    // }
    //
    //
  }

  ///
  Widget displaySpendItem() {
    final list = <Widget>[];

    final spendItemDaily = _ref.watch(spendItemDailyProvider(date).select((value) => value.spendItemDaily));

    return spendItemDaily.when(
      data: (value) {
        for (var i = 0; i < value.item.length; i++) {
          final exValue = value.item[i].split('|');

          final color = getRowTextColor(kind: exValue[1]);

          list.add(
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
              child: DefaultTextStyle(
                style: TextStyle(color: color, fontSize: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(exValue[0]), Text(exValue[2].toCurrency())],
                ),
              ),
            ),
          );
        }

        return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*

    final spendItemDailyState = _ref.watch(spendItemDailyProvider(date));

    for (var i = 0; i < spendItemDailyState.item.length; i++) {
      final exValue = spendItemDailyState.item[i].split('|');

      final color = getRowTextColor(kind: exValue[1]);

      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: DefaultTextStyle(
            style: TextStyle(color: color, fontSize: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(exValue[0]), Text(exValue[2].toCurrency())],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list));


    */
  }

  ///
  Color getRowTextColor({required String kind}) {
    switch (kind) {
      case '(bank)':
        return Colors.lightBlueAccent;
      case '(income)':
        return Colors.yellowAccent;
      default:
        return Colors.white;
    }
  }

  ///
  Widget displayTimeplace() {
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
}
