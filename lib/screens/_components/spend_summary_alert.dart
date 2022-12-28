// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/spend_notifier.dart';

class SpendSummaryAlert extends ConsumerWidget {
  SpendSummaryAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

    final deviceInfoState = ref.read(deviceInfoProvider);

    final appParamState = ref.watch(appParamProvider);

    final spendSummaryState = ref.watch(spendSummaryProvider(
        '${appParamState.SpendSummaryAlertSelectYear}-01-01 00:00:00'
            .toDateTime()));

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: spendSummaryState.saving,
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

                      Row(children: yearWidgetList),
                      const SizedBox(height: 20),
                      displaySpendSummary(),
                    ],
                  ),
                ),
              ),
            ),
            if (spendSummaryState.saving)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  ///
  List<Widget> makeYearWidgetList() {
    final exYmd = date.yyyymmdd.split('-');

    final appParamState = _ref.watch(appParamProvider);

    final yearList = <Widget>[];
    for (var i = exYmd[0].toInt(); i >= 2020; i--) {
      yearList.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(appParamProvider.notifier)
                .setSpendSummaryAlertSelectYear(year: i);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i == appParamState.SpendSummaryAlertSelectYear)
                  ? Colors.yellowAccent.withOpacity(0.2)
                  : null,
            ),
            child: Text(i.toString()),
          ),
        ),
      );
    }

    return yearList;
  }

  ///
  Widget displaySpendSummary() {
    final oneWidth = _context.screenSize.width / 6.5;

    final appParamState = _ref.watch(appParamProvider);

    final spendSummaryState = _ref.watch(spendSummaryProvider(
        '${appParamState.SpendSummaryAlertSelectYear}-01-01 00:00:00'
            .toDateTime()));

    //--------------------------------------------------//
    final itemSumMap = <String, int>{};
    for (var i = 0; i < spendSummaryState.list.length; i++) {
      var sum = 0;
      for (var j = 0; j < spendSummaryState.list[i].list.length; j++) {
        sum += spendSummaryState.list[i].list[j].price.toString().toInt();
      }
      itemSumMap[spendSummaryState.list[i].item] = sum;
    }
    //--------------------------------------------------//

    final list = <Widget>[];

    for (var i = 0; i < spendSummaryState.list.length; i++) {
      final list2 = <Widget>[];
      for (var j = 0; j < spendSummaryState.list[i].list.length; j++) {
        list2.add(
          Container(
            width: oneWidth,
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Stack(
              children: [
                Text(
                  spendSummaryState.list[i].list[j].month,
                  style: const TextStyle(color: Colors.grey),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(spendSummaryState.list[i].list[j].price
                      .toString()
                      .toCurrency()),
                ),
              ],
            ),
          ),
        );
      }

      list.add(
        Container(
          width: _context.screenSize.width,
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: _context.screenSize.width,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigo.withOpacity(0.8),
                      Colors.transparent
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        spendSummaryState.list[i].item,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: 60,
                      alignment: Alignment.topRight,
                      child: Text(
                        itemSumMap[spendSummaryState.list[i].item]
                            .toString()
                            .toCurrency(),
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(children: list2),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      key: PageStorageKey(uuid.v1()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }
}
