// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../models/credit_spend_monthly.dart';
import '../state/monthly_spend_check/monthly_spend_check_notifier.dart';
import '../utility/utility.dart';
import '../viewmodel/credit_notifier.dart';
import '../viewmodel/spend_notifier.dart';
import '../viewmodel/timeplace_notifier.dart';

class MonthlySpendCheckScreen extends ConsumerWidget {
  MonthlySpendCheckScreen({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Map<String, List<CreditSpendMonthly>> creditSpendMap = {};

  Map<String, List<Map<int, String>>> monthlySpendMap = {};

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeMonthlySpendMap();

    /*



    print(monthlySpendMap);

    flutter: {2023-01-01: [{116: 食費}, {727: 交通費}, {548: 交際費}, {10670: 交際費}, {200: お賽銭}], 2023-01-02: [{0: 食費}, {100: お賽銭}, {-16: プラス}], 2023-01-03: [{579: 食費}, {923: 交通費}, {-8: プラス}], 2023-01-04: [{1804: 食費}, {566: 交通費}, {26625: 国民年金基金}], 2023-01-05: [{999: 食費}, {566: 交通費}, {23580: credit}, {67000: 住居費}], 2023-01-06: [{0: 食費}, {2519: 水道光熱費}], 2023-01-07: [{767: 食費}, {493: 交通費}, {204: 通信費}, {2591: 水道光熱費}, {3000: 交際費}, {-6: プラス}], 2023-01-08: [{546: 食費}, {942: 交通費}], 2023-01-09: [{0: 食費}, {493: 交通費}, {-13: プラス}], 2023-01-10: [{0: 食費}, {3000: 共済代}], 2023-01-11: [{1090: 食費}, {566: 交通費}], 2023-01-12: [{1357: 食費}, {566: 交通費}, {1995: 牛乳代}], 2023-01-13: [{0: 食費}, {14850: アイアールシー}, {154: 手数料}], 2023-01-14: [{2865: 食費}, {-1: プラス}], 2023-01-15: [{890: 食費}, {1110: <…>


    */

    getNext2MonthCreditSpend();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(width: context.screenSize.width),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date.yyyymm),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            ref
                                .watch(monthlySpendCheckProvider(date).notifier)
                                .inputCheckItem(date: date);
                          },
                          icon: const Icon(Icons.input),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  color: Colors.white.withOpacity(0.4),
                ),
                Expanded(
                  child: displayMonthlySpendCheckList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  void getNext2MonthCreditSpend() {
    var list = <CreditSpendMonthly>[];
    var keepDate = '';

    //---------------------//
    final after1 = _utility.makeSpecialDate(
        date: date, usage: 'month', plusminus: 'plus', num: 1);

    final creditSpendMonthlyState1 =
        _ref.watch(creditSpendMonthlyProvider(after1!));

    list = <CreditSpendMonthly>[];
    keepDate = '';

    for (var i = 0; i < creditSpendMonthlyState1.length; i++) {
      if (keepDate != creditSpendMonthlyState1[i].date.yyyymmdd) {
        list = [];
      }

      if (date.yyyymm == creditSpendMonthlyState1[i].date.yyyymm) {
        list.add(creditSpendMonthlyState1[i]);
      }

      if (list.isNotEmpty) {
        creditSpendMap[creditSpendMonthlyState1[i].date.yyyymmdd] = list;
      }

      keepDate = creditSpendMonthlyState1[i].date.yyyymmdd;
    }
    //---------------------//

    //---------------------//

    final after2 = _utility.makeSpecialDate(
        date: date, usage: 'month', plusminus: 'plus', num: 2);

    final creditSpendMonthlyState2 =
        _ref.watch(creditSpendMonthlyProvider(after2!));

    list = <CreditSpendMonthly>[];
    keepDate = '';

    for (var i = 0; i < creditSpendMonthlyState2.length; i++) {
      if (keepDate != creditSpendMonthlyState2[i].date.yyyymmdd) {
        list = [];
      }

      if (date.yyyymm == creditSpendMonthlyState2[i].date.yyyymm) {
        list.add(creditSpendMonthlyState2[i]);
      }

      if (list.isNotEmpty) {
        creditSpendMap[creditSpendMonthlyState2[i].date.yyyymmdd] = list;
      }

      keepDate = creditSpendMonthlyState2[i].date.yyyymmdd;
    }
    //---------------------//
  }

  ///
  Widget displayMonthlySpendCheckList() {
    final monthlyTimeplaceState = _ref.watch(monthlyTimeplaceProvider(date));

    final monthlySpendCheckState = _ref.watch(monthlySpendCheckProvider(date));

    final list = <Widget>[];

    var keepDate = '';
    var i = 0;
    var j = 0;
    monthlyTimeplaceState.forEach((element) {
      if (keepDate != element.date.yyyymmdd) {
        if (i != 0) {
          list.add(const SizedBox(height: 60));
        }

        j = 0;
      }

      /////////////////////////////////////////// credit
      if (j == 0) {
        if (creditSpendMap[element.date.yyyymmdd] != null) {
          creditSpendMap[element.date.yyyymmdd]?.forEach((element2) {
            //---------------------------------//
            final st = <String>[];
            st.add(element2.date.yyyymmdd.trim());
            st.add(element2.item.trim());
            st.add(element2.price.trim());
            st.add('credit');
            final str = st.join('|');
            //---------------------------------//

            var youbi = _utility.getYoubi(youbiStr: element2.date.youbiStr);

            list.add(GestureDetector(
              onTap: () {
                _ref
                    .watch(monthlySpendCheckProvider(date).notifier)
                    .setSelectItem(item: str);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  color: (monthlySpendCheckState.selectItem.contains(str))
                      ? Colors.yellowAccent.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(color: Color(0xFFFB86CE)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${element2.date.yyyymmdd}（${youbi}）'),
                          Container(),
                        ],
                      ),
                      Text(element2.item),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(element2.price),
                      )
                    ],
                  ),
                ),
              ),
            ));
          });
        }
      }
      /////////////////////////////////////////// credit

      var item = '';
      if (monthlySpendMap[element.date.yyyymmdd] != null) {
        monthlySpendMap[element.date.yyyymmdd]?.forEach((element2) {
          if (element2[element.price.toString().toInt()] != null) {
            item = element2[element.price.toString().toInt()] ?? '';
          }
        });
      }

      //---------------------------------//
      final st2 = <String>[];
      st2.add(element.time.trim());
      st2.add(element.place.trim());

      if (item != '') {
        st2.add(item);
      }
      //---------------------------------//

      //---------------------------------//
      final st = <String>[];
      st.add(element.date.yyyymmdd.trim());
      st.add(st2.join(' - '));
      st.add(element.price.toString().trim());
      st.add('daily');
      final str = st.join('|');
      //---------------------------------//

      //---------------------------------//
      final st3 = <String>[];
      st3.add(element.place);
      if (item != '') {
        st3.add(item);
      }
      //---------------------------------//

      var youbi = _utility.getYoubi(youbiStr: element.date.youbiStr);

      list.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(monthlySpendCheckProvider(date).notifier)
                .setSelectItem(item: str);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              color: (monthlySpendCheckState.selectItem.contains(str))
                  ? Colors.yellowAccent.withOpacity(0.1)
                  : Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('${element.date.yyyymmdd}（${youbi}）'),
                        const SizedBox(width: 20),
                        Text(element.time),
                      ],
                    ),
                    Container(),
                  ],
                ),
                Text(st3.join(' - ')),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(element.price.toString().toCurrency()),
                ),
              ],
            ),
          ),
        ),
      );

      j++;
      i++;
      keepDate = element.date.yyyymmdd;
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }

  ///
  void makeMonthlySpendMap() {
    final spendMonthDetailState = _ref.watch(spendMonthDetailProvider(date));

    spendMonthDetailState.list.forEach((element) {
      final list = <Map<int, String>>[];

      element.item.forEach((element2) {
        list.add({element2.price.toString().toInt(): element2.item});
      });

      monthlySpendMap[element.date.yyyymmdd] = list;
    });
  }
}
