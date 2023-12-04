// ignore_for_file: must_be_immutable, unnecessary_null_comparison, cascade_invocations

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/screens/_components/money_kind_list_alert.dart';

import '../../../extensions/extensions.dart';
import '../../../models/money.dart';
import '../../../route/routes.dart';
import '../../../state/app_param/app_param_notifier.dart';
import '../../../state/bank/bank_notifier.dart';
import '../../../state/benefit/benefit_notifier.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/gold/gold_notifier.dart';
import '../../../state/money/money_notifier.dart';
import '../../../state/shintaku/shintaku_notifier.dart';
import '../../../state/spend/spend_notifier.dart';
import '../../../state/stock/stock_notifier.dart';
import '../../../utility/utility.dart';
import '../_money_dialog.dart';
import '../assets_list_alert.dart';
import '../bank_alert.dart';
import '../bank_data_list_alert.dart';
import '../gold_alert.dart';
import '../shintaku_alert.dart';
import '../spend_alert.dart';
import '../spend_year_day_alert.dart';
import '../stock_alert.dart';
import 'monthly_spend_page.dart';

class MoneyPage extends ConsumerWidget {
  MoneyPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  Map<int, int> genBenefitMap = {};

  late BuildContext _context;
  late WidgetRef _ref;

  List<int> notMoneyAsset = [];

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    makeYearBenefit();

    //===================================//
    var total = '';

    final money = ref.watch(moneyProvider(date).select((value) => value.money));

    if (money != null) {
      total = (money.sum == '') ? '0' : money.sum;
    }
    //===================================//

    //===================================//
    var diff = '';

    final yesterday = _utility.makeSpecialDate(date: date, usage: 'day', plusminus: 'minus', num: 1);

    final yesterdayMoney = ref.watch(moneyProvider(yesterday!).select((value) => value.money));

    if (money != null && yesterdayMoney != null) {
      diff = (money.sum == '' || yesterdayMoney.sum == '')
          ? '0'
          : (yesterdayMoney.sum.toInt() - money.sum.toInt()).toString();
    }
    //===================================//

    //
    //
    // final moneyState = ref.watch(moneyProvider(date));
    //
    // final total = (moneyState.sum == '') ? '0' : moneyState.sum;
    // final diff = (moneyState.sum == '' || yesterdayMoney.sum == '')
    //     ? '0'
    //     : (yesterdayMoney.sum.toInt() - moneyState.sum.toInt()).toString();
    //
    //

    final deviceInfoState = ref.read(deviceInfoProvider);

    final appParamState = ref.watch(appParamProvider);

    notMoneyAsset = [];

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              ExpansionTile(
                initiallyExpanded: appParamState.openMoneyArea,
                iconColor: Colors.white,
                onExpansionChanged: (value) => ref.read(appParamProvider.notifier).setOpenMoneyArea(value: value),
                title: Text(
                  appParamState.openMoneyArea == false ? 'OPEN' : 'CLOSE',
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => context.goNamed(RouteNames.moneyInput, extra: {'date': date}),
                              icon: const Icon(Icons.input),
                            ),
                            IconButton(
                              onPressed: () =>
                                  context.goNamed(RouteNames.spendItemInput, extra: {'date': date, 'diff': diff}),
                              icon: const Icon(Icons.list),
                            ),
                            IconButton(
                              onPressed: () =>
                                  context.goNamed(RouteNames.timePlaceInput, extra: {'date': date, 'diff': diff}),
                              icon: const Icon(Icons.access_time),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            (total != '' && diff != '')
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(total.toCurrency(), style: const TextStyle(fontSize: 16)),
                                      Text(diff.toCurrency(), style: const TextStyle(fontSize: 16)),
                                    ],
                                  )
                                : Container(),
                            const SizedBox(width: 20),
                            (total == '0')
                                ? Container()
                                : GestureDetector(
                                    onTap: () {
                                      MoneyDialog(
                                        context: context,
                                        widget: SpendAlert(date: date, diff: diff),
                                      );
                                    },
                                    child: const Icon(Icons.info_outline),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  displaySamedaySpendYearly(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      IconButton(
                        onPressed: () {
                          MoneyDialog(
                            context: _context,
                            widget: MonthlySpendPage(
                              date: DateTime(
                                date.yyyymmdd.split('-')[0].toInt(),
                                date.yyyymmdd.split('-')[1].toInt(),
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.calendar_today, color: Colors.white.withOpacity(0.3)),
                      ),
                    ],
                  ),
                  if (money != null) ...[
                    const SizedBox(height: 30),
                    displayMoney(data: money),
                    const SizedBox(height: 30),
                    displayBank(data: money),
                    const SizedBox(height: 30),
                    displayPay(data: money),
                    const SizedBox(height: 30),
                  ],
                ],
              ),

              Divider(color: Colors.deepPurple.withOpacity(0.3), thickness: 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  GestureDetector(
                    onTap: () => MoneyDialog(context: context, widget: AssetsListAlert(date: date)),
                    child: const Icon(Icons.list, color: Colors.deepPurple),
                  ),
                ],
              ),

              displayGold(),
              const SizedBox(height: 30),
              displayStock(),
              const SizedBox(height: 30),
              displayShintaku(),
              const SizedBox(height: 30),
              displayNotMoneyAsset(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void makeYearBenefit() {
    final benefitMap = _ref.watch(benefitProvider.select((value) => value.benefitMap));

    for (var i = 2020; i <= DateTime.now().year; i++) {
      genBenefitMap[i] = 0;

      final yearFirst = DateTime(i);

      final diff = DateTime(i, DateTime.now().month, DateTime.now().day).difference(yearFirst).inDays;

      var sum = 0;
      for (var j = 0; j <= diff; j++) {
        if (benefitMap.value != null) {
          final date = yearFirst.add(Duration(days: j)).yyyymmdd;
          sum += (benefitMap.value![date] != null) ? benefitMap.value![date]!.salary.toInt() : 0;
        }
      }

      genBenefitMap[i] = sum;
    }
  }

  ///
  Widget displaySamedaySpendYearly() {
    final list = <Widget>[];

    ///////////////////////////////////////////
    final yearSpendToToday = <int, int>{};

    final spendSamedayYearlyList =
        _ref.watch(spendSamedayYearlyProvider(date).select((value) => value.spendSamedayYearlyList));

    spendSamedayYearlyList.value?.forEach((element) {
      final bene = genBenefitMap[element.year] ?? 0;
      yearSpendToToday[element.year] = bene + element.spend;
    });

    //
    //
    // _ref.watch(spendSamedayYearlyProvider(date)).forEach((element) {
    //   final bene = genBenefitMap[element.year] ?? 0;
    //   yearSpendToToday[element.year] = bene + element.spend;
    // });
    //
    //
    //

    ///////////////////////////////////////////

    return spendSamedayYearlyList.when(
      data: (value) {
        value.forEach((element) {
          final bene = genBenefitMap[element.year] ?? 0;

          list.add(
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
              ),
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.white),
                child: Row(
                  children: [
                    Expanded(
                        child: Text('${element.year}-01-01\n-> ${date.mmdd}', style: const TextStyle(fontSize: 10))),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(element.spend.toString().toCurrency(), style: const TextStyle(fontSize: 10)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(bene.toString().toCurrency(), style: const TextStyle(fontSize: 10)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          (bene + element.spend).toString().toCurrency(),
                          style: const TextStyle(color: Color(0xFFFBB6CE), fontSize: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        MoneyDialog(
                          context: _context,
                          widget: SpendYearDayAlert(
                            date: DateTime(element.year, date.month, date.day),
                            spend: bene + element.spend,
                            yearSpendToToday: yearSpendToToday,
                          ),
                        );
                      },
                      child: const Icon(Icons.info_outline),
                    ),
                  ],
                ),
              ),
            ),
          );
        });

        return Column(children: list);
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*


    _ref.watch(spendSamedayYearlyProvider(date)).forEach((element) {
      final bene = genBenefitMap[element.year] ?? 0;

      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
          ),
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: Row(
              children: [
                Expanded(child: Text('${element.year}-01-01\n-> ${date.mmdd}', style: const TextStyle(fontSize: 10))),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(element.spend.toString().toCurrency(), style: const TextStyle(fontSize: 10)),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(bene.toString().toCurrency(), style: const TextStyle(fontSize: 10)),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      (bene + element.spend).toString().toCurrency(),
                      style: const TextStyle(color: Color(0xFFFBB6CE), fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    MoneyDialog(
                      context: _context,
                      widget: SpendYearDayAlert(
                        date: DateTime(element.year, date.month, date.day),
                        spend: bene + element.spend,
                        yearSpendToToday: yearSpendToToday,
                      ),
                    );
                  },
                  child: const Icon(Icons.info_outline),
                ),
              ],
            ),
          ),
        ),
      );
    });

    return Column(children: list);




    */
  }

  ///
  Widget displayMoney({required Money data}) {
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    child: const Text('CURRENCY'),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              MoneyDialog(
                                context: _context,
                                widget: MoneyKindListAlert(date: date),
                              );
                            },
                            child: const Icon(Icons.info_outline_rounded),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          data.currency.toString().toCurrency(),
                          style: const TextStyle(color: Colors.yellowAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            getMoneyDispRow(key: '10000', value: data.yen10000),
            getMoneyDispRow(key: '5000', value: data.yen5000),
            getMoneyDispRow(key: '2000', value: data.yen2000),
            getMoneyDispRow(key: '1000', value: data.yen1000),
            getMoneyDispRow(key: '500', value: data.yen500),
            getMoneyDispRow(key: '100', value: data.yen100),
            getMoneyDispRow(key: '50', value: data.yen50),
            getMoneyDispRow(key: '10', value: data.yen10),
            getMoneyDispRow(key: '5', value: data.yen5),
            getMoneyDispRow(key: '1', value: data.yen1),
          ],
        ),
      ),
    );
  }

  ///
  Widget getMoneyDispRow({required String key, required String value}) {
    if (key == '' || value == '') {
      return Container();
    }

    final bankName = _utility.getBankName();

    final dispKey = (bankName[key] != null) ? bankName[key] : key;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(dispKey.toString()),
          Text((value == 'null') ? '0' : value.toCurrency()),
        ],
      ),
    );
  }

  ///
  Widget displayBank({required Money data}) {
    final bankStateA = _ref.watch(bankLastProvider('bank_a').select((value) => value.bankCompanyChange));
    final bankStateB = _ref.watch(bankLastProvider('bank_b').select((value) => value.bankCompanyChange));
    final bankStateC = _ref.watch(bankLastProvider('bank_c').select((value) => value.bankCompanyChange));
    final bankStateD = _ref.watch(bankLastProvider('bank_d').select((value) => value.bankCompanyChange));
    final bankStateE = _ref.watch(bankLastProvider('bank_e').select((value) => value.bankCompanyChange));

    return (bankStateA == null || bankStateB == null || bankStateC == null || bankStateD == null || bankStateE == null)
        ? Container()
        : DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          child: const Text('BANK'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => _context.goNamed(RouteNames.bankInput, extra: {'date': date}),
                                    child: const Icon(Icons.business),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () =>
                                        MoneyDialog(context: _context, widget: BankDataListAlert(flag: 'bank')),
                                    child: const Icon(Icons.list),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DefaultTextStyle(
                    style: const TextStyle(fontSize: 16),
                    child: Column(
                      children: [
                        getBankDispRow(name: 'bank_a', price: data.bankA, dt: bankStateA.date.toString()),
                        getBankDispRow(name: 'bank_b', price: data.bankB, dt: bankStateB.date.toString()),
                        getBankDispRow(name: 'bank_c', price: data.bankC, dt: bankStateC.date.toString()),
                        getBankDispRow(name: 'bank_d', price: data.bankD, dt: bankStateD.date.toString()),
                        getBankDispRow(name: 'bank_e', price: data.bankE, dt: bankStateE.date.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  ///
  Widget getBankDispRow({required String name, required String price, required String dt}) {
    if (name == '' || price == '' || dt == '') {
      return Container();
    }

    final bankName = _utility.getBankName();

    final dayDiff = DateTime.now().difference(DateTime.parse('${dt.split(' ')[0]} 00:00:00')).inDays;

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
        child: DefaultTextStyle(
          style: TextStyle(color: (dayDiff < 365) ? Colors.white : Colors.grey),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => MoneyDialog(context: _context, widget: BankAlert(name: name)),
                    child: Icon(
                      Icons.info_outline,
                      color: (dayDiff < 365) ? Colors.white : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(bankName[name].toString()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text((price == 'null') ? '0' : price.toCurrency()),
                  Text(dt.split(' ')[0]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayPay({required Money data}) {
    final payStateA = _ref.watch(bankLastProvider('pay_a').select((value) => value.bankCompanyChange));
    final payStateB = _ref.watch(bankLastProvider('pay_b').select((value) => value.bankCompanyChange));
    final payStateC = _ref.watch(bankLastProvider('pay_c').select((value) => value.bankCompanyChange));
    final payStateD = _ref.watch(bankLastProvider('pay_d').select((value) => value.bankCompanyChange));
    final payStateE = _ref.watch(bankLastProvider('pay_e').select((value) => value.bankCompanyChange));

    return (payStateA == null || payStateB == null || payStateC == null || payStateD == null || payStateE == null)
        ? Container()
        : DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          child: const Text('E-MONEY'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              GestureDetector(
                                onTap: () => MoneyDialog(context: _context, widget: BankDataListAlert(flag: 'pay')),
                                child: const Icon(Icons.list),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DefaultTextStyle(
                    style: const TextStyle(fontSize: 16),
                    child: Column(
                      children: [
                        getBankDispRow(name: 'pay_a', price: data.payA, dt: payStateA.date.toString()),
                        getBankDispRow(name: 'pay_b', price: data.payB, dt: payStateB.date.toString()),
                        getBankDispRow(name: 'pay_c', price: data.payC, dt: payStateC.date.toString()),
                        getBankDispRow(name: 'pay_d', price: data.payD, dt: payStateD.date.toString()),
                        getBankDispRow(name: 'pay_e', price: data.payE, dt: payStateE.date.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  ///
  Widget displayGold() {
    final goldState = _ref.watch(goldLastProvider(date));

    if (goldState.lastGold == null) {
      return Container();
    }

    final goldDate = '${goldState.lastGold!.year}-${goldState.lastGold!.month}-${goldState.lastGold!.day}';

    var goldDiff = 0;

    var score = 0;

    if (goldState.lastGold!.goldValue != null && goldState.lastGold!.payPrice != null) {
      goldDiff = goldState.lastGold!.goldValue.toString().toInt() - goldState.lastGold!.payPrice.toString().toInt();

      notMoneyAsset.add(goldState.lastGold!.goldValue.toString().toInt());

      score =
          ((goldState.lastGold!.goldValue.toString().toInt() / goldState.lastGold!.payPrice.toString().toInt()) * 100)
              .round();
    }

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          child: const Text('GOLD'),
                        ),
                      ),
                      Expanded(child: Container(alignment: Alignment.topRight, child: Text(goldDate))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (goldState.lastGold!.payPrice == null)
                          ? Container()
                          : Text(goldState.lastGold!.payPrice.toString().toCurrency()),
                      (goldState.lastGold!.goldValue == null)
                          ? Container()
                          : Text(
                              goldState.lastGold!.goldValue.toString().toCurrency(),
                              style: const TextStyle(color: Colors.yellowAccent),
                            ),
                      Text(goldDiff.toString().toCurrency()),
                      Text('$score %'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => MoneyDialog(context: _context, widget: GoldAlert()),
              child: const Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget displayStock() {
    final stockState = _ref.watch(stockProvider(date));

    var score = '';

    if (stockState.lastStock != null) {
      notMoneyAsset.add(stockState.lastStock!.price);

      if (stockState.lastStock!.price != null && stockState.lastStock!.cost != null) {
        score = ((stockState.lastStock!.price.toString().toInt() / stockState.lastStock!.cost.toString().toInt()) * 100)
            .toString()
            .split('.')[0];
      }
    }

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          child: const Text('STOCK'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text((stockState.lastStock == null) ? '' : stockState.lastStock!.date.yyyymmdd),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((stockState.lastStock == null) ? '' : stockState.lastStock!.cost.toString().toCurrency()),
                      (stockState.lastStock == null)
                          ? const Text('')
                          : Text(
                              stockState.lastStock!.price.toString().toCurrency(),
                              style: const TextStyle(color: Colors.yellowAccent),
                            ),
                      Text((stockState.lastStock == null) ? '' : stockState.lastStock!.diff.toString().toCurrency()),
                      Text('$score %'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => MoneyDialog(context: _context, widget: StockAlert(date: stockState.lastStock!.date)),
              child: const Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget displayShintaku() {
    final shintakuState = _ref.watch(shintakuProvider(date));

    var score = '';

    if (shintakuState.lastShintaku != null) {
      notMoneyAsset.add(shintakuState.lastShintaku!.price);

      if (shintakuState.lastShintaku!.price != null && shintakuState.lastShintaku!.cost != null) {
        score = ((shintakuState.lastShintaku!.price.toString().toInt() /
                    shintakuState.lastShintaku!.cost.toString().toInt()) *
                100)
            .toString()
            .split('.')[0];
      }
    }

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3))),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          child: const Text('SHINTAKU'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text(
                              (shintakuState.lastShintaku == null) ? '' : shintakuState.lastShintaku!.date.yyyymmdd),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((shintakuState.lastShintaku == null)
                          ? ''
                          : shintakuState.lastShintaku!.cost.toString().toCurrency()),
                      (shintakuState.lastShintaku == null)
                          ? const Text('')
                          : Text(
                              shintakuState.lastShintaku!.price.toString().toCurrency(),
                              style: const TextStyle(color: Colors.yellowAccent),
                            ),
                      Text((shintakuState.lastShintaku == null)
                          ? ''
                          : shintakuState.lastShintaku!.diff.toString().toCurrency()),
                      Text('$score %'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                MoneyDialog(
                  context: _context,
                  widget: ShintakuAlert(date: shintakuState.lastShintaku!.date),
                );
              },
              child: const Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget displayNotMoneyAsset() {
    var price = 0;
    notMoneyAsset.forEach((element) => price += element);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(color: Colors.deepPurple.withOpacity(0.3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Text(
            price.toString().toCurrency(),
            style: const TextStyle(fontSize: 12, color: Colors.yellowAccent),
          ),
        ],
      ),
    );
  }
}
