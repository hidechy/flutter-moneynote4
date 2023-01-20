// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/zero_use_date.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../models/credit_spend_monthly.dart';
import '../../models/spend_yearly.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/bank_notifier.dart';
import '../../viewmodel/benefit_notifier.dart';
import '../../viewmodel/credit_notifier.dart';
import '../../viewmodel/spend_notifier.dart';

class SpendSummaryHalfyearAlert extends ConsumerWidget {
  SpendSummaryHalfyearAlert({super.key});

  final Utility _utility = Utility();

  Uuid uuid = const Uuid();

  Map<int, List<SpendYearly>> comparisonMap = {};

  Map<String, List<CreditSpendMonthly>> creditSpendMap = {};

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
                if (deviceInfoState.model == 'iPhone')
                  _utility.getFileNameDebug(name: runtimeType.toString()),
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
  void makeComparisonMap() {
    final list = <DateTime>[];

    for (var i = 0; i < 6; i++) {
      list.add(
        DateTime(
          DateTime.now().yyyy.toInt(),
          DateTime.now().mm.toInt() - i,
        ),
      );
    }

    final day = DateTime.now().dd.toInt();

    final list2 = <List<SpendYearly>>[];

    list.forEach((element) {
      list2.add(_ref.watch(spendMonthDetailProvider(element)).list);

      //---------------------------- (1)
      final creditSpendMonthlyState =
          _ref.watch(creditSpendMonthlyProvider(element));

      var keepDate = '';
      creditSpendMonthlyState.forEach((element2) {
        if (keepDate != element2.date.yyyymmdd) {
          creditSpendMap[element2.date.yyyymmdd] = [];
        }

        creditSpendMap[element2.date.yyyymmdd]?.add(element2);

        keepDate = element2.date.yyyymmdd;
      });
      //---------------------------- (1)
    });

    for (var i = 1; i <= day; i++) {
      final list3 = <SpendYearly>[];

      list2.forEach((element2) {
        element2.forEach((element3) {
          if (i == element3.date.dd.toInt()) {
            list3.add(element3);
          }
        });
      });

      comparisonMap[i] = list3;
    }
  }

  ///
  Widget displayComparisonData() {
    final benefitState = _ref.watch(benefitProvider);

    final bankMoveState = _ref.watch(bankMoveProvider);

    final spendZeroUseDateState = _ref.watch(spendZeroUseDateProvider);

    final list = <Widget>[];

    final oneWidth = _context.screenSize.width * 0.6;
    final oneHeight = _context.screenSize.height / 4;

    comparisonMap.entries.forEach((element) {
      final list2 = <Widget>[];
      element.value.forEach((element2) {
        final youbi = _utility.getYoubi(
          youbiStr: element2.date.youbiStr,
        );

        final list3 = <Widget>[];
        element2.item.forEach((element3) {
          final color = (element3.flag.toString() == '1')
              ? Colors.lightBlueAccent
              : Colors.white;

          list3.add(
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
              child: DefaultTextStyle(
                style: TextStyle(color: color, fontSize: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        element3.item,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(element3.price.toString().toCurrency()),
                  ],
                ),
              ),
            ),
          );
        });

        if (creditSpendMap[element2.date.yyyymmdd] != null) {
          creditSpendMap[element2.date.yyyymmdd]?.forEach((element3) {
            list3.add(
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Color(0xFFFB86CE),
                    fontSize: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          element3.item,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(element3.price.toCurrency()),
                    ],
                  ),
                ),
              ),
            );
          });
        }

        benefitState.forEach((element3) {
          if (element3.date.yyyymmdd == element2.date.yyyymmdd) {
            list3.add(
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'benefit',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(element3.salary.toCurrency()),
                    ],
                  ),
                ),
              ),
            );
          }
        });

        bankMoveState.forEach((element3) {
          if (element3.date.yyyymmdd == element2.date.yyyymmdd) {
            list3.add(
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Bank Move - ${element3.bank} // ${element3.flag == 0 ? 'out' : 'in'}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(element3.price.toString().toCurrency()),
                    ],
                  ),
                ),
              ),
            );
          }
        });

        final spendZeroFlag = getSpendZeroFlag(
          date: element2.date.yyyymmdd,
          spend: spendZeroUseDateState,
        );

        list2.add(
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            width: oneWidth,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: oneHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('${element2.date.yyyymmdd}（$youbi）'),
                          if (spendZeroFlag == 1)
                            Icon(
                              Icons.star,
                              color: Colors.yellowAccent.withOpacity(0.6),
                            ),
                        ],
                      ),
                      Text(element2.spend.toString().toCurrency()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(children: list3),
                ],
              ),
            ),
          ),
        );
      });

      list.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: _context.screenSize.width,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.withOpacity(0.8), Colors.transparent],
                ),
              ),
              child: Text(element.key.toString()),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list2,
              ),
            ),
          ],
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }

  ///
  int getSpendZeroFlag({required String date, required ZeroUseDate spend}) {
    for (var i = 0; i < spend.data.length; i++) {
      if (date == spend.data[i].yyyymmdd) {
        return 1;
      }
    }

    return 0;
  }
}
