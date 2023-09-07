// ignore_for_file: must_be_immutable, use_named_constants

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tab_container/tab_container.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/train/train_notifier.dart';
import '../../../utility/utility.dart';
import '../../../viewmodel/spend_notifier.dart';
import '../../../viewmodel/time_place_notifier.dart';
import '../_money_dialog.dart';
import '../time_location_alert.dart';
import 'spend_train_page.dart';

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

              SizedBox(
                width: double.infinity,
                height: context.screenSize.height * 0.2,
                child: displaySpendItem(),
              ),

              Divider(color: Colors.yellowAccent.withOpacity(0.2), thickness: 5),

              SizedBox(
                width: double.infinity,
                height: context.screenSize.height * 0.2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () => MoneyDialog(context: context, widget: TimeLocationAlert(date: date)),
                        child: Icon(Icons.info_outline, color: Colors.white.withOpacity(0.6)),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(child: displayTimeplace()),
                  ],
                ),
              ),

              Divider(color: Colors.yellowAccent.withOpacity(0.2), thickness: 5),

              SizedBox(
                width: double.infinity,
                height: context.screenSize.height * 0.2,
                child: displayInPageTabContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayInPageTabContainer() {
    final tabList = <String>[];
    final childList = <Widget>[];

    //======================//
    final trainMap = _ref.watch(trainProvider.select((value) => value.trainMap));

    if (trainMap[date.yyyymmdd] != null) {
      tabList.add('train');
      childList.add(SpendTrainPage(date: date));
    }
    //======================//

    if (tabList.isNotEmpty) {
      return TabContainer(
        radius: 20,
        tabCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
          return SlideTransition(
            position: Tween(begin: const Offset(0.2, 0), end: const Offset(0, 0)).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        selectedTextStyle: const TextStyle(fontSize: 12),
        unselectedTextStyle: const TextStyle(fontSize: 12),
        tabs: tabList,
        children: childList,
      );
    }

    return Container();
  }

  ///
  void makeDiff() {
    diff = 0;

    final spendItemDailyState = _ref.watch(spendItemDailyProvider(date));

    for (var i = 0; i < spendItemDailyState.item.length; i++) {
      final exValue = spendItemDailyState.item[i].split('|');

      if (exValue[0] == '収入') {
        diff -= exValue[2].toInt();
      } else {
        diff += exValue[2].toInt();
      }
    }
  }

  ///
  Widget displaySpendItem() {
    final spendItemDailyState = _ref.watch(spendItemDailyProvider(date));

    final list = <Widget>[];

    for (var i = 0; i < spendItemDailyState.item.length; i++) {
      final exValue = spendItemDailyState.item[i].split('|');

      final color = getRowTextColor(kind: exValue[1]);

      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(exValue[0], style: TextStyle(color: color)),
              Text(exValue[2].toCurrency(), style: TextStyle(color: color)),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list));
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
    final timeplaceState = _ref.watch(onedayTimeplaceProvider(date));

    final list = <Widget>[];

    for (var i = 0; i < timeplaceState.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
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
      );
    }

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list),
    );
  }
}
