// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../models/credit_spend_monthly.dart';
import '../state/monthly_spend_check/monthly_spend_check_notifier.dart';
import '../utility/utility.dart';
import '../viewmodel/credit_notifier.dart';
import '../viewmodel/timeplace_notifier.dart';

class MonthlySpendCheckScreen extends ConsumerWidget {
  MonthlySpendCheckScreen({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Map<String, List<CreditSpendMonthly>> creditSpendMap = {};

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

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
                                .watch(monthlySpendCheckProvider.notifier)
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

    final monthlySpendCheckState = _ref.watch(monthlySpendCheckProvider);

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
            final st = <String>[];
            st.add(element2.date.yyyymmdd.trim());
            st.add(element2.item.trim());
            st.add(element2.price.trim());
            st.add('credit');
            final str = st.join('|');

            list.add(GestureDetector(
              onTap: () {
                _ref
                    .watch(monthlySpendCheckProvider.notifier)
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
                          Text(element2.date.yyyymmdd),
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

      final st = <String>[];
      st.add(element.date.yyyymmdd.trim());
      st.add(element.time.trim());
      st.add(element.price.toString().trim());
      st.add('daily');
      final str = st.join('|');

      list.add(
        GestureDetector(
          onTap: () {
            _ref
                .watch(monthlySpendCheckProvider.notifier)
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
                        Text(element.date.yyyymmdd),
                        const SizedBox(width: 20),
                        Text(element.time),
                      ],
                    ),
                    Container(),
                  ],
                ),
                Text(element.place),
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
}
