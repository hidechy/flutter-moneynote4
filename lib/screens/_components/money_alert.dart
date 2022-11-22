// ignore_for_file: must_be_immutable, sized_box_shrink_expand, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/screens/_components/shintaku_alert.dart';

import '../../models/money.dart';
import '../../utility/utility.dart';
import '../../viewmodel/bank_notifier.dart';
import '../../viewmodel/gold_notifier.dart';
import '../../viewmodel/money_notifier.dart';
import '../../viewmodel/shintaku_notifier.dart';
import '../../viewmodel/stock_notifier.dart';
import '_money_dialog.dart';
import 'bank_alert.dart';
import 'gold_alert.dart';
import 'spend_alert.dart';
import 'stock_alert.dart';

class MoneyAlert extends ConsumerWidget {
  MoneyAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final exDate = date.toString().split(' ');

    final moneyState = ref.watch(moneyProvider(exDate[0]));

    final exYmd = exDate[0].split('-');
    final yesterday = DateTime(
      int.parse(exYmd[0]),
      int.parse(exYmd[1]),
      int.parse(exYmd[2]) - 1,
    );

    final yesterdayMoney = ref.watch(
      moneyProvider(yesterday.toString().split(' ')[0]),
    );

    final total = (moneyState.sum == '') ? '0' : moneyState.sum;
    final diff = (moneyState.sum == '' || yesterdayMoney.sum == '')
        ? '0'
        : (int.parse(yesterdayMoney.sum) - int.parse(moneyState.sum))
            .toString();

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    moneyState.date.toString().split(' ')[0],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _utility.makeCurrencyDisplay(total),
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                _utility.makeCurrencyDisplay(diff),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          (total == '0')
                              ? Container()
                              : GestureDetector(
                                  onTap: () {
                                    MoneyDialog(
                                      context: context,
                                      widget: SpendAlert(
                                        date: date,
                                        diff: diff,
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.info_outline),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                displayMoney(data: moneyState),
                const SizedBox(height: 30),
                displayBank(data: moneyState),
                const SizedBox(height: 30),
                displayPay(data: moneyState),
                const SizedBox(height: 30),
                displayGold(),
                const SizedBox(height: 30),
                displayStock(),
                const SizedBox(height: 30),
                displayShintaku(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayMoney({required Money data}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: const Text('CURRENCY'),
              ),
            ),
            Expanded(child: Container()),
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
    );
  }

  ///
  Widget getMoneyDispRow({required String key, required String value}) {
    if (key == '' || value == '') {
      return Container();
    }

    final bankName = _utility.getBankName();

    final dispKey = (bankName[key] != null) ? bankName[key] : key;

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dispKey.toString()),
            Text((value == 'null') ? '0' : _utility.makeCurrencyDisplay(value)),
          ],
        ),
      ),
    );
  }

  ///
  Widget displayBank({required Money data}) {
    final bankStateA = _ref.watch(bankLastProvider('bank_a'));
    final bankStateB = _ref.watch(bankLastProvider('bank_b'));
    final bankStateC = _ref.watch(bankLastProvider('bank_c'));
    final bankStateD = _ref.watch(bankLastProvider('bank_d'));
    final bankStateE = _ref.watch(bankLastProvider('bank_e'));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: const Text('BANK'),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        const SizedBox(height: 10),
        DefaultTextStyle(
          style: const TextStyle(fontSize: 16),
          child: Column(
            children: [
              getBankDispRow(
                name: 'bank_a',
                price: data.bankA,
                date: bankStateA.date.toString(),
              ),
              getBankDispRow(
                name: 'bank_b',
                price: data.bankB,
                date: bankStateB.date.toString(),
              ),
              getBankDispRow(
                name: 'bank_c',
                price: data.bankC,
                date: bankStateC.date.toString(),
              ),
              getBankDispRow(
                name: 'bank_d',
                price: data.bankD,
                date: bankStateD.date.toString(),
              ),
              getBankDispRow(
                name: 'bank_e',
                price: data.bankE,
                date: bankStateE.date.toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  Widget getBankDispRow(
      {required String name, required String price, required String date}) {
    if (name == '' || price == '' || date == '') {
      return Container();
    }

    final bankName = _utility.getBankName();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  MoneyDialog(
                    context: _context,
                    widget: BankAlert(name: name),
                  );
                },
                child: const Icon(Icons.info_outline),
              ),
              const SizedBox(width: 20),
              Text(bankName[name].toString()),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                (price == 'null') ? '0' : _utility.makeCurrencyDisplay(price),
              ),
              Text(date.split(' ')[0]),
            ],
          ),
        ],
      ),
    );
  }

  ///
  Widget displayPay({required Money data}) {
    final payStateA = _ref.watch(bankLastProvider('pay_a'));
    final payStateB = _ref.watch(bankLastProvider('pay_b'));
    final payStateC = _ref.watch(bankLastProvider('pay_c'));
    final payStateD = _ref.watch(bankLastProvider('pay_d'));
    final payStateE = _ref.watch(bankLastProvider('pay_e'));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: const Text('E-MONEY'),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        const SizedBox(height: 10),
        DefaultTextStyle(
          style: const TextStyle(fontSize: 16),
          child: Column(
            children: [
              getBankDispRow(
                name: 'pay_a',
                price: data.payA,
                date: payStateA.date.toString(),
              ),
              getBankDispRow(
                name: 'pay_b',
                price: data.payB,
                date: payStateB.date.toString(),
              ),
              getBankDispRow(
                name: 'pay_c',
                price: data.payC,
                date: payStateC.date.toString(),
              ),
              getBankDispRow(
                name: 'pay_d',
                price: data.payD,
                date: payStateD.date.toString(),
              ),
              getBankDispRow(
                name: 'pay_e',
                price: data.payE,
                date: payStateE.date.toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  Widget displayGold() {
    final goldState = _ref.watch(goldLastProvider);

    if (goldState == null) {
      return Container();
    }

    final goldDate = '${goldState.year}-${goldState.month}-${goldState.day}';

    var goldDiff = 0;
    if (goldState.goldValue != null && goldState.payPrice != null) {
      goldDiff = int.parse(goldState.goldValue.toString()) -
          int.parse(goldState.payPrice.toString());
    }

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: const Text('GOLD'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(goldDate),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (goldState.payPrice == null)
                        ? Container()
                        : Text(_utility.makeCurrencyDisplay(
                            goldState.payPrice.toString())),
                    (goldState.goldValue == null)
                        ? Container()
                        : Text(_utility.makeCurrencyDisplay(
                            goldState.goldValue.toString())),
                    Text(_utility.makeCurrencyDisplay(goldDiff.toString())),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                MoneyDialog(
                  context: _context,
                  widget: GoldAlert(),
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
  Widget displayStock() {
    final stockState = _ref.watch(stockProvider);

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: const Text('STOCK'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Text(stockState.date.toString().split(' ')[0]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_utility
                        .makeCurrencyDisplay(stockState.cost.toString())),
                    Text(_utility
                        .makeCurrencyDisplay(stockState.price.toString())),
                    Text(_utility
                        .makeCurrencyDisplay(stockState.diff.toString())),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                MoneyDialog(
                  context: _context,
                  widget: StockAlert(),
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
  Widget displayShintaku() {
    final shintakuState = _ref.watch(shintakuProvider);

    return DefaultTextStyle(
      style: const TextStyle(fontSize: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: const Text('SHINTAKU'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child:
                            Text(shintakuState.date.toString().split(' ')[0]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_utility
                        .makeCurrencyDisplay(shintakuState.cost.toString())),
                    Text(_utility
                        .makeCurrencyDisplay(shintakuState.price.toString())),
                    Text(_utility
                        .makeCurrencyDisplay(shintakuState.diff.toString())),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                MoneyDialog(
                  context: _context,
                  widget: ShintakuAlert(),
                );
              },
              child: const Icon(Icons.info_outline),
            ),
          ),
        ],
      ),
    );
  }
}
