// ignore_for_file: must_be_immutable, cascade_invocations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';
import '../models/bank_monthly_spend.dart';
import '../models/credit_spend_monthly.dart';
import '../route/routes.dart';
import '../state/bank/bank_notifier.dart';
import '../state/device_info/device_info_notifier.dart';
import '../state/keihi_list/keihi_list_notifier.dart';
import '../state/monthly_spend_check/monthly_spend_check_notifier.dart';
import '../state/spend/spend_notifier.dart';
import '../state/time_place/time_place_notifier.dart';
import '../utility/function.dart';
import '../utility/utility.dart';
import '_components/_money_dialog.dart';
import '_components/keihi_list_alert.dart';
import '_components/keihi_setting_alert.dart';

class MonthlySpendCheckScreen extends ConsumerWidget {
  MonthlySpendCheckScreen({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Map<String, List<CreditSpendMonthly>> creditSpendMap = {};

  Map<String, List<Map<int, String>>> monthlySpendMap = {};

  Map<String, List<BankMonthlySpend>> bankMonthlySpendMap = {};

  Map<String, dynamic> itemIdsMap = {};

  Map<String, dynamic> itemCategoryMap = {};

  DateTime? prevMonth;
  DateTime? nextMonth;

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    prevMonth = DateTime(date.year, date.month - 1);
    nextMonth = DateTime(date.year, date.month + 1);

    makeItemIdsMap();

    makeMonthlySpendMap();

    creditSpendMap = getNext2MonthCreditSpend(ref: ref, creDate: date);

    makeBankMonthlySpendMap();

    final monthTotal = ref.watch(monthlySpendCheckProvider(date).select((value) => value.monthTotal));

    final deviceInfoState = ref.read(deviceInfoProvider);

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

                //----------//
                if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(date.yyyymm),
                            Text(monthTotal.toString().toCurrency()),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => MonthlySpendCheckScreen(date: prevMonth!)),
                                );
                              },
                              icon: const Icon(Icons.skip_previous),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => MonthlySpendCheckScreen(date: nextMonth!)),
                                );
                              },
                              icon: const Icon(Icons.skip_next),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await ref.read(keihiListProvider(date).notifier).getKeihiList(date: date);

                            await MoneyDialog(context: context, widget: KeihiListAlert(date: date));
                          },
                          icon: const Icon(Icons.list),
                        ),
                        IconButton(
                          onPressed: () {
                            ref.read(monthlySpendCheckProvider(date).notifier).inputCheckItem(date: date);

                            context.goNamed(RouteNames.home);
                          },
                          icon: const Icon(Icons.input),
                        ),
                        IconButton(
                          onPressed: () => context.goNamed(RouteNames.home),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(thickness: 2, color: Colors.white.withOpacity(0.4)),
                Expanded(child: displayMonthlySpendCheckList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget displayMonthlySpendCheckList() {
    final monthlySpendCheckState = _ref.watch(monthlySpendCheckProvider(date));

    final timePlaceList = _ref.watch(timeplaceProvider(date).select((value) => value.timePlaceList));

    return timePlaceList.when(
      data: (value) {
        final list = <Widget>[];

        var keepDate = '';
        var i = 0;
        var j = 0;
        value.forEach((element) {
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
                    border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                    color: (monthlySpendCheckState.selectItems.contains(str))
                        ? Colors.yellowAccent.withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: DefaultTextStyle(
                    style: const TextStyle(color: Color(0xFFFB86CE), fontSize: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${element2.date.yyyymmdd}（$youbi）'),
                            Row(
                              children: [
                                if (itemIdsMap[str] != null) ...[
                                  GestureDetector(
                                    onTap: () async {
                                      await _ref
                                          .read(monthlySpendCheckProvider(date).notifier)
                                          .setSelectCategory(category: '');

                                      await _ref.read(monthlySpendCheckProvider(date).notifier).setErrorMsg(error: '');

                                      // 経費セッティングアラート1
                                      await MoneyDialog(
                                        context: _context,
                                        widget: KeihiSettingAlert(
                                          date: date,
                                          id: itemIdsMap[str].toString().toInt(),
                                          str: str,
                                        ),
                                      );
                                    },
                                    child: Icon(Icons.ac_unit, color: Colors.white.withOpacity(0.8)),
                                  ),
                                  const SizedBox(width: 20),
                                ],
                                GestureDetector(
                                  onTap: () =>
                                      _ref.read(monthlySpendCheckProvider(date).notifier).setSelectItem(item: str),
                                  child: Icon(Icons.input, color: Colors.yellowAccent.withOpacity(0.6)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(element2.item),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (itemCategoryMap[str] != null)
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('[${itemCategoryMap[str].toString().split('|')[0]}]'),
                                      Text('[${itemCategoryMap[str].toString().split('|')[1]}]'),
                                    ],
                                  )
                                : Container(),
                            Text(element2.price.toCurrency()),
                          ],
                        ),
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
                    border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                    color: (monthlySpendCheckState.selectItems.contains(str))
                        ? Colors.yellowAccent.withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: DefaultTextStyle(
                    style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${element.date.yyyymmdd}（$youbi）'),
                            Row(
                              children: [
                                if (itemIdsMap[str] != null) ...[
                                  GestureDetector(
                                    onTap: () async {
                                      await _ref
                                          .read(monthlySpendCheckProvider(date).notifier)
                                          .setSelectCategory(category: '');

                                      await _ref.read(monthlySpendCheckProvider(date).notifier).setErrorMsg(error: '');

                                      // 経費セッティングアラート2
                                      await MoneyDialog(
                                        context: _context,
                                        widget: KeihiSettingAlert(
                                          date: date,
                                          id: itemIdsMap[str].toString().toInt(),
                                          str: str,
                                        ),
                                      );
                                    },
                                    child: Icon(Icons.ac_unit, color: Colors.white.withOpacity(0.8)),
                                  ),
                                  const SizedBox(width: 20),
                                ],
                                GestureDetector(
                                  onTap: () =>
                                      _ref.read(monthlySpendCheckProvider(date).notifier).setSelectItem(item: str),
                                  child: Icon(Icons.input, color: Colors.yellowAccent.withOpacity(0.6)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text('${element2.item} - ${element2.bank}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (itemCategoryMap[str] != null)
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('[${itemCategoryMap[str].toString().split('|')[0]}]'),
                                      Text('[${itemCategoryMap[str].toString().split('|')[1]}]'),
                                    ],
                                  )
                                : Container(),
                            Text(element2.price.toCurrency()),
                          ],
                        ),
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
                border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                color: (monthlySpendCheckState.selectItems.contains(str))
                    ? Colors.yellowAccent.withOpacity(0.2)
                    : Colors.transparent,
              ),
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 12),
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
                        Row(
                          children: [
                            if (itemIdsMap[str] != null) ...[
                              GestureDetector(
                                onTap: () async {
                                  await _ref
                                      .read(monthlySpendCheckProvider(date).notifier)
                                      .setSelectCategory(category: '');

                                  await _ref.read(monthlySpendCheckProvider(date).notifier).setErrorMsg(error: '');

                                  // 経費セッティングアラート3
                                  await MoneyDialog(
                                    context: _context,
                                    widget: KeihiSettingAlert(
                                      date: date,
                                      id: itemIdsMap[str].toString().toInt(),
                                      str: str,
                                    ),
                                  );
                                },
                                child: Icon(Icons.ac_unit, color: Colors.white.withOpacity(0.8)),
                              ),
                              const SizedBox(width: 20),
                            ],
                            GestureDetector(
                              onTap: () => _ref.read(monthlySpendCheckProvider(date).notifier).setSelectItem(item: str),
                              child: Icon(Icons.input, color: Colors.yellowAccent.withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(st3.join(' - ')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (itemCategoryMap[str] != null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('[${itemCategoryMap[str].toString().split('|')[0]}]'),
                                  Text('[${itemCategoryMap[str].toString().split('|')[1]}]'),
                                ],
                              )
                            : Container(),
                        Text(element.price.toString().toCurrency()),
                      ],
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

        return SingleChildScrollView(child: Column(children: list));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*



    final monthlyTimeplaceState = _ref.watch(timeplaceProvider(date));


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
                border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                color: (monthlySpendCheckState.selectItems.contains(str))
                    ? Colors.yellowAccent.withOpacity(0.2)
                    : Colors.transparent,
              ),
              child: DefaultTextStyle(
                style: const TextStyle(color: Color(0xFFFB86CE), fontSize: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${element2.date.yyyymmdd}（$youbi）'),
                        Row(
                          children: [
                            if (itemIdsMap[str] != null) ...[
                              GestureDetector(
                                onTap: () async {
                                  await _ref
                                      .read(monthlySpendCheckProvider(date).notifier)
                                      .setSelectCategory(category: '');

                                  await _ref.read(monthlySpendCheckProvider(date).notifier).setErrorMsg(error: '');

                                  // 経費セッティングアラート1
                                  await MoneyDialog(
                                    context: _context,
                                    widget: KeihiSettingAlert(
                                      date: date,
                                      id: itemIdsMap[str].toString().toInt(),
                                      str: str,
                                    ),
                                  );
                                },
                                child: Icon(Icons.ac_unit, color: Colors.white.withOpacity(0.8)),
                              ),
                              const SizedBox(width: 20),
                            ],
                            GestureDetector(
                              onTap: () => _ref.read(monthlySpendCheckProvider(date).notifier).setSelectItem(item: str),
                              child: Icon(Icons.input, color: Colors.yellowAccent.withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(element2.item),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (itemCategoryMap[str] != null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('[${itemCategoryMap[str].toString().split('|')[0]}]'),
                                  Text('[${itemCategoryMap[str].toString().split('|')[1]}]'),
                                ],
                              )
                            : Container(),
                        Text(element2.price.toCurrency()),
                      ],
                    ),
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
                border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
                color: (monthlySpendCheckState.selectItems.contains(str))
                    ? Colors.yellowAccent.withOpacity(0.2)
                    : Colors.transparent,
              ),
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${element.date.yyyymmdd}（$youbi）'),
                        Row(
                          children: [
                            if (itemIdsMap[str] != null) ...[
                              GestureDetector(
                                onTap: () async {
                                  await _ref
                                      .read(monthlySpendCheckProvider(date).notifier)
                                      .setSelectCategory(category: '');

                                  await _ref.read(monthlySpendCheckProvider(date).notifier).setErrorMsg(error: '');

                                  // 経費セッティングアラート2
                                  await MoneyDialog(
                                    context: _context,
                                    widget: KeihiSettingAlert(
                                      date: date,
                                      id: itemIdsMap[str].toString().toInt(),
                                      str: str,
                                    ),
                                  );
                                },
                                child: Icon(Icons.ac_unit, color: Colors.white.withOpacity(0.8)),
                              ),
                              const SizedBox(width: 20),
                            ],
                            GestureDetector(
                              onTap: () => _ref.read(monthlySpendCheckProvider(date).notifier).setSelectItem(item: str),
                              child: Icon(Icons.input, color: Colors.yellowAccent.withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text('${element2.item} - ${element2.bank}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (itemCategoryMap[str] != null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('[${itemCategoryMap[str].toString().split('|')[0]}]'),
                                  Text('[${itemCategoryMap[str].toString().split('|')[1]}]'),
                                ],
                              )
                            : Container(),
                        Text(element2.price.toCurrency()),
                      ],
                    ),
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
            border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
            color: (monthlySpendCheckState.selectItems.contains(str))
                ? Colors.yellowAccent.withOpacity(0.2)
                : Colors.transparent,
          ),
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
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
                    Row(
                      children: [
                        if (itemIdsMap[str] != null) ...[
                          GestureDetector(
                            onTap: () async {
                              await _ref.read(monthlySpendCheckProvider(date).notifier).setSelectCategory(category: '');

                              await _ref.read(monthlySpendCheckProvider(date).notifier).setErrorMsg(error: '');

                              // 経費セッティングアラート3
                              await MoneyDialog(
                                context: _context,
                                widget: KeihiSettingAlert(
                                  date: date,
                                  id: itemIdsMap[str].toString().toInt(),
                                  str: str,
                                ),
                              );
                            },
                            child: Icon(Icons.ac_unit, color: Colors.white.withOpacity(0.8)),
                          ),
                          const SizedBox(width: 20),
                        ],
                        GestureDetector(
                          onTap: () => _ref.read(monthlySpendCheckProvider(date).notifier).setSelectItem(item: str),
                          child: Icon(Icons.input, color: Colors.yellowAccent.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(st3.join(' - ')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (itemCategoryMap[str] != null)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('[${itemCategoryMap[str].toString().split('|')[0]}]'),
                              Text('[${itemCategoryMap[str].toString().split('|')[1]}]'),
                            ],
                          )
                        : Container(),
                    Text(element.price.toString().toCurrency()),
                  ],
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

    return SingleChildScrollView(child: Column(children: list));




    */
  }

  ///
  void makeMonthlySpendMap() {
    final spendYearlyList = _ref.watch(spendMonthDetailProvider(date).select((value) => value.spendYearlyList));

    spendYearlyList.value?.forEach((element) {
      final list = <Map<int, String>>[];

      element.item.forEach((element2) => list.add({element2.price.toString().toInt(): element2.item}));

      monthlySpendMap[element.date.yyyymmdd] = list;
    });

    //
    //
    // final spendMonthDetailState = _ref.watch(spendMonthDetailProvider(date));
    //
    // spendMonthDetailState.list.forEach((element) {
    //   final list = <Map<int, String>>[];
    //
    //   element.item.forEach((element2) => list.add({element2.price.toString().toInt(): element2.item}));
    //
    //   monthlySpendMap[element.date.yyyymmdd] = list;
    // });
    //
    //
  }

  ///
  void makeBankMonthlySpendMap() {
    final bankMonthlySpendList =
        _ref.watch(bankMonthlySpendProvider(date).select((value) => value.bankMonthlySpendList));

    var list = <BankMonthlySpend>[];
    var keepDay = '';

    bankMonthlySpendList.value?.forEach((element) {
      if (keepDay != element.day) {
        list = [];
      }

      list.add(element);

      bankMonthlySpendMap['${date.yyyymm}-${element.day}'] = list;

      keepDay = element.day;
    });

    //
    //
    // final bankMonthlySpendState = _ref.watch(bankMonthlySpendProvider(date));
    //
    // var list = <BankMonthlySpend>[];
    // var keepDay = '';
    // bankMonthlySpendState.forEach((element) {
    //   if (keepDay != element.day) {
    //     list = [];
    //   }
    //
    //   list.add(element);
    //
    //   bankMonthlySpendMap['${date.yyyymm}-${element.day}'] = list;
    //
    //   keepDay = element.day;
    // });
    //
    //
    //
  }

  ///
  void makeItemIdsMap() {
    final checkItems = _ref.watch(monthlySpendCheckProvider(date).select((value) => value.checkItems));

    final selectItems = _ref.watch(monthlySpendCheckProvider(date).select((value) => value.selectItems));

    checkItems.forEach((element) {
      selectItems.forEach((element2) {
        if (element['item'] == element2) {
          itemIdsMap[element2] = element['id'];

          if (element['cate'] != '' && element['cate'] != '|') {
            itemCategoryMap[element2] = element['cate'];
          }
        }
      });
    });
  }
}
