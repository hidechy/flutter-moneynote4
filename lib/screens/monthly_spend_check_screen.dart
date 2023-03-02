// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../models/bank_monthly_spend.dart';
import '../models/credit_spend_monthly.dart';
import '../state/monthly_spend_check/monthly_spend_check_notifier.dart';
import '../utility/utility.dart';
import '../viewmodel/bank_notifier.dart';
import '../viewmodel/credit_notifier.dart';
import '../viewmodel/spend_notifier.dart';
import '../viewmodel/timeplace_notifier.dart';

class MonthlySpendCheckScreen extends ConsumerWidget {
  MonthlySpendCheckScreen({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Map<String, List<CreditSpendMonthly>> creditSpendMap = {};

  Map<String, List<Map<int, String>>> monthlySpendMap = {};

  Map<String, List<BankMonthlySpend>> bankMonthlySpendMap = {};

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeMonthlySpendMap();

    getNext2MonthCreditSpend();

    makeBankMonthlySpendMap();

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

                            Navigator.pop(context);
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

      if (j == 0) {
        final youbi = _utility.getYoubi(youbiStr: element.date.youbiStr);

        /////////////////////////////////////////// credit
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

            list.add(Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                color: (monthlySpendCheckState.selectItem.contains(str))
                    ? Colors.yellowAccent.withOpacity(0.2)
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
                        Text('${element2.date.yyyymmdd}（$youbi）'),
                        GestureDetector(
                          onTap: () {
                            _ref
                                .watch(monthlySpendCheckProvider(date).notifier)
                                .setSelectItem(item: str);
                          },
                          child: Icon(
                            Icons.input,
                            color: Colors.yellowAccent.withOpacity(0.6),
                          ),
                        ),
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
            ));
          });
        }
        /////////////////////////////////////////// credit

        /////////////////////////////////////////// bank
        if (bankMonthlySpendMap[element.date.yyyymmdd] != null) {
          bankMonthlySpendMap[element.date.yyyymmdd]?.forEach((element2) {
            //---------------------------------//
            final st = <String>[];
            st.add(element.date.yyyymmdd);
            st.add(element2.item.trim());
            st.add(element2.price.trim());
            st.add('bank');
            final str = st.join('|');
            //---------------------------------//

            list.add(Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                color: (monthlySpendCheckState.selectItem.contains(str))
                    ? Colors.yellowAccent.withOpacity(0.2)
                    : Colors.transparent,
              ),
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.lightBlueAccent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${element.date.yyyymmdd}（$youbi）'),
                        GestureDetector(
                          onTap: () {
                            _ref
                                .watch(monthlySpendCheckProvider(date).notifier)
                                .setSelectItem(item: str);
                          },
                          child: Icon(
                            Icons.input,
                            color: Colors.yellowAccent.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    Text('${element2.item} - ${element2.bank}'),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(element2.price),
                    )
                  ],
                ),
              ),
            ));
          });
        }
        /////////////////////////////////////////// bank

      }

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

      final youbi = _utility.getYoubi(youbiStr: element.date.youbiStr);

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
            color: (monthlySpendCheckState.selectItem.contains(str))
                ? Colors.yellowAccent.withOpacity(0.2)
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
                      Text('${element.date.yyyymmdd}（$youbi）'),
                      const SizedBox(width: 20),
                      Text(element.time),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _ref
                          .watch(monthlySpendCheckProvider(date).notifier)
                          .setSelectItem(item: str);
                    },
                    child: Icon(
                      Icons.input,
                      color: Colors.yellowAccent.withOpacity(0.6),
                    ),
                  ),
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

  ///
  void makeBankMonthlySpendMap() {
    final bankMonthlySpendState = _ref.watch(bankMonthlySpendProvider(date));

    var list = <BankMonthlySpend>[];
    var keepDay = '';
    bankMonthlySpendState.forEach((element) {
      if (keepDay != element.day) {
        list = [];
      }

      list.add(element);

      bankMonthlySpendMap['${date.yyyymm}-${element.day}'] = list;

      keepDay = element.day;
    });
  }
}
