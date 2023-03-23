// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/credit_notifier.dart';

class CreditSummaryAlert extends ConsumerWidget {
  CreditSummaryAlert({super.key, required this.date});

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

    final CreditSummaryAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.CreditSummaryAlertSelectYear),
    );

    final creditSummaryState = _ref.watch(creditSummaryProvider(
      DateTime(CreditSummaryAlertSelectYear),
    ));

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
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: creditSummaryState.saving,
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
                      displayCreditSummary(),
                    ],
                  ),
                ),
              ),
            ),
            if (creditSummaryState.saving)
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
    final CreditSummaryAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.CreditSummaryAlertSelectYear),
    );

    final yearList = <Widget>[];

    //forで仕方ない
    for (var i = date.yyyy.toInt(); i >= 2020; i--) {
      yearList.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(appParamProvider.notifier)
                .setCreditSummaryAlertSelectYear(year: i);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i == CreditSummaryAlertSelectYear)
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
  Widget displayCreditSummary() {
    final oneWidth = _context.screenSize.width / 6.5;

    final CreditSummaryAlertSelectYear = _ref.watch(
      appParamProvider.select((value) => value.CreditSummaryAlertSelectYear),
    );

    final creditSummaryState = _ref.watch(
      creditSummaryProvider(DateTime(CreditSummaryAlertSelectYear)),
    );

    //--------------------------------------------------//
    final itemSumMap = <String, int>{};
    creditSummaryState.list.forEach((element) {
      var sum = 0;
      element.list.forEach((element2) {
        sum += element2.price.toString().toInt();
      });

      itemSumMap[element.item] = sum;
    });
    //--------------------------------------------------//

    final list = <Widget>[];

    var total = 0;

    creditSummaryState.list.forEach((element) {
      final list2 = <Widget>[];
      element.list.forEach((element2) {
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
                  element2.month,
                  style: const TextStyle(color: Colors.grey),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    element2.price.toString().toCurrency(),
                  ),
                ),
              ],
            ),
          ),
        );
      });

      total += itemSumMap[element.item].toString().toInt();

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
                  children: [
                    Expanded(
                      child: Text(
                        element.item,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: 60,
                      alignment: Alignment.topRight,
                      child: Text(
                        itemSumMap[element.item].toString().toCurrency(),
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(children: list2),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.topRight,
                child: Text(
                  total.toString().toCurrency(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(
      key: PageStorageKey(uuid.v1()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }
}
