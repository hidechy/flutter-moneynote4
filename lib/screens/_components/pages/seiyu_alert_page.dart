// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../utility/utility.dart';
import '../../../viewmodel/credit_notifier.dart';
import '../../../viewmodel/seiyu_notifier.dart';
import '../_money_dialog.dart';
import 'seiyu_tab_page.dart';

class SeiyuAlertPage extends ConsumerWidget {
  SeiyuAlertPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  List<String> seiyuDateList = [];
  Map<String, int> seiyuDateSumMap = {};

  Map<String, int> seiyuCreditDataMap = {};

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    getSeiyuCreditMap();

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

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(),
              //     IconButton(
              //       onPressed: () {
              //         MoneyDialog(
              //           context: context,
              //           widget: SeiyuTabPage(list: seiyuDateList),
              //         );
              //       },
              //       icon: Icon(
              //         Icons.copy_sharp,
              //         color: Colors.white.withOpacity(0.6),
              //       ),
              //     ),
              //   ],
              // ),
              //
              //
              //
              //
              //

              Expanded(child: displaySeiyuDateList()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displaySeiyuDateList() {
    final yearDateList = makeYearDateList();

    final list = <Widget>[];

    list.add(
      Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            const Expanded(flex: 2, child: Text('')),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Text(
                  'price',
                  style: TextStyle(color: Colors.yellowAccent.withOpacity(0.6)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Text(
                  'pay',
                  style: TextStyle(color: Colors.yellowAccent.withOpacity(0.6)),
                ),
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.topRight,
              child: Text(
                'point',
                style: TextStyle(color: Colors.yellowAccent.withOpacity(0.6)),
              ),
            )),
          ],
        ),
      ),
    );

    // forで仕方ない
    for (var i = 0; i < yearDateList.length; i++) {
      final hiduke = '${yearDateList[i]} 00:00:00'.toDateTime().mmdd;
      final youbi = _utility.getYoubi(youbiStr: '${yearDateList[i]} 00:00:00'.toDateTime().youbiStr);

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
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: _utility.getLeadingBgColor(month: yearDateList[i].split('-')[1]),
                child: Text(
                  yearDateList[i].split('-')[1],
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Text('$hiduke（$youbi）'),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(seiyuDateSumMap[yearDateList[i]].toString().toCurrency()),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    (seiyuCreditDataMap[yearDateList[i]] != null)
                        ? seiyuCreditDataMap[yearDateList[i]].toString().toCurrency()
                        : '',
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    (seiyuCreditDataMap[yearDateList[i]] != null)
                        ? (seiyuDateSumMap[yearDateList[i]].toString().toInt() -
                                seiyuCreditDataMap[yearDateList[i]].toString().toInt())
                            .toString()
                            .toCurrency()
                        : '',
                  ),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  MoneyDialog(
                    context: _context,
                    widget: SeiyuTabPage(list: seiyuDateList, index: i),
                  );
                },
                child: Icon(
                  Icons.copy_sharp,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }

  ///
  void getSeiyuCreditMap() {
    seiyuCreditDataMap = {};

    final reg = RegExp('西友ネットスーパー');

    for (var i = 1; i <= 12; i++) {
      final creditSpendMonthlyState = _ref.watch(
        creditSpendMonthlyProvider(DateTime(date.year, i)),
      );

      creditSpendMonthlyState.forEach((element) {
        if (reg.firstMatch(element.item) != null) {
          if (element.date.year == date.year) {
            seiyuCreditDataMap[element.date.yyyymmdd] = element.price.toInt();
          }
        }
      });
    }

    //-----------// 1月
    final creditSpendMonthlyState = _ref.watch(
      creditSpendMonthlyProvider(DateTime(date.year + 1)),
    );

    creditSpendMonthlyState.forEach((element) {
      if (reg.firstMatch(element.item) != null) {
        seiyuCreditDataMap[element.date.yyyymmdd] = element.price.toInt();
      }
    });
    //-----------// 1月

    //==============// 仕方ないので
    seiyuCreditDataMap['2020-12-29'] = 2518;
    seiyuCreditDataMap['2021-01-19'] = 4610;
    seiyuCreditDataMap['2021-02-10'] = 5420;
    seiyuCreditDataMap['2021-07-19'] = 5647;
    seiyuCreditDataMap['2021-08-21'] = 7415;
    seiyuCreditDataMap['2021-11-03'] = 5576;
    seiyuCreditDataMap['2021-11-06'] = 5571;
    seiyuCreditDataMap['2021-11-15'] = 5653;
    seiyuCreditDataMap['2021-11-19'] = 5734;
    //==============// 仕方ないので
  }

  ///
  List<String> makeYearDateList() {
    final seiyuAllState = _ref.watch(seiyuAllProvider(date));

    final list = <String>[];
    var keepDate = '';

    final map = <String, List<int>>{};

    for (var i = 0; i < seiyuAllState.length; i++) {
      if (keepDate != seiyuAllState[i].date) {
        list.add(DateTime.parse(seiyuAllState[i].date).yyyymmdd);

        map[seiyuAllState[i].date] = [];
      }

      if (date.year == seiyuAllState[i].date.split('-')[0].toInt()) {
        map[seiyuAllState[i].date]?.add(seiyuAllState[i].price.toInt());
      }

      keepDate = seiyuAllState[i].date;
    }

    seiyuDateSumMap = {};

    map.entries.forEach((element) {
      var sum = 0;
      element.value.forEach((element2) {
        sum += element2;
      });

      seiyuDateSumMap[element.key] = sum;
    });

    seiyuDateList = list;

    return list;
  }
}
