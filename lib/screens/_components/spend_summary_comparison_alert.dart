// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/spend/spend_notifier.dart';
import '../../utility/utility.dart';

class SpendSummaryComparisonAlert extends ConsumerWidget {
  SpendSummaryComparisonAlert({super.key});

  final Utility _utility = Utility();

  Uuid uuid = const Uuid();

  Map<String, List<Map<int, int>>> comparisonMap = {};

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    makeComparisonMap();

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
                if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                const SizedBox(height: 20),

                displayComparisonData(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Future<void> makeComparisonMap() async {
    final map = <int, Map<String, int>>{};

    final midashi = <String>[];

    for (var i = 2020; i <= DateTime.now().yyyy.toInt(); i++) {
      final map2 = <String, int>{};

      _ref.watch(spendSummaryProvider(DateTime(i)).select((value) => value.spendSummaryList)).when(
            data: (value) {
              for (var j = 0; j < value.length; j++) {
                if (i == 2020) {
                  midashi.add(value[j].item);
                }

                var total = 0;
                for (var k = 0; k < value[j].list.length; k++) {
                  total += value[j].list[k].price;
                }

                map2[value[j].item] = total;
              }
            },
            error: (error, stackTrace) => Container(),
            loading: Container.new,
          );

      //
      // final spendSummaryState = _ref.watch(
      //   spendSummaryProvider(DateTime(i)),
      // );
      //
      // for (var j = 0; j < spendSummaryState.list.length; j++) {
      //   if (i == 2020) {
      //     midashi.add(spendSummaryState.list[j].item);
      //   }
      //
      //   var total = 0;
      //   for (var k = 0; k < spendSummaryState.list[j].list.length; k++) {
      //     total += spendSummaryState.list[j].list[k].price;
      //   }
      //
      //   map2[spendSummaryState.list[j].item] = total;
      // }
      //
      //

      map[i] = map2;
    }

    midashi.forEach((element) {
      final list = <Map<int, int>>[];

      for (var i = 2020; i <= DateTime.now().yyyy.toInt(); i++) {
        map[i]!.entries.forEach((element2) {
          if (element == element2.key) {
            final map3 = <int, int>{};
            map3[i] = element2.value;
            list.add(map3);
          }
        });
      }

      comparisonMap[element] = list;
    });
  }

  ///
  Widget displayComparisonData() {
    final oneWidth = _context.screenSize.width / 5;

    final list = <Widget>[];

    comparisonMap.entries.forEach((element) {
      final list2 = <Widget>[];

      element.value.forEach((element2) {
        element2.entries.forEach((element3) {
          list2.add(
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    element3.key.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  width: oneWidth,
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.all(3),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Text(element3.value.toString().toCurrency()),
                ),
              ],
            ),
          );
        });
      });

      list.add(
        Container(
          width: _context.screenSize.width,
          padding: const EdgeInsets.symmetric(vertical: 3),
          margin: const EdgeInsets.only(bottom: 10),
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
                    colors: [Colors.indigo.withOpacity(0.8), Colors.transparent],
                    stops: const [0.7, 1],
                  ),
                ),
                child: Text(element.key),
              ),
              Wrap(children: list2),
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }
}
