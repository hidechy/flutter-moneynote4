// ignore_for_file: must_be_immutable, sized_box_shrink_expand, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/money.dart';
import '../../utility/utility.dart';

import '../../viewmodel/gold_viewmodel.dart';
import '../../viewmodel/money_viewmodel.dart';
import '../../viewmodel/stock_viewmodel.dart';

class MoneyAlert extends ConsumerWidget {
  MoneyAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final moneyState = ref.watch(moneyProvider(date.toString().split(' ')[0]));

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
                  decoration: const BoxDecoration(color: Colors.indigo),
                  alignment: Alignment.center,
                  child: Text(
                    moneyState.date.toString().split(' ')[0],
                    style: const TextStyle(fontSize: 20),
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
                const SizedBox(height: 20),
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
                decoration: const BoxDecoration(color: Colors.indigo),
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
  Widget displayBank({required Money data}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(color: Colors.indigo),
                child: const Text('BANK'),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        const SizedBox(height: 10),
        getMoneyDispRow(key: 'bank_a', value: data.bankA),
        getMoneyDispRow(key: 'bank_b', value: data.bankB),
        getMoneyDispRow(key: 'bank_c', value: data.bankC),
        getMoneyDispRow(key: 'bank_d', value: data.bankD),
        getMoneyDispRow(key: 'bank_e', value: data.bankE),
      ],
    );
  }

  ///
  Widget displayPay({required Money data}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(color: Colors.indigo),
                child: const Text('E-MONEY'),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        const SizedBox(height: 10),
        getMoneyDispRow(key: 'pay_a', value: data.payA),
        getMoneyDispRow(key: 'pay_b', value: data.payB),
        getMoneyDispRow(key: 'pay_c', value: data.payC),
        getMoneyDispRow(key: 'pay_d', value: data.payD),
        getMoneyDispRow(key: 'pay_e', value: data.payE),
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
            Text(_utility.makeCurrencyDisplay(value)),
          ],
        ),
      ),
    );
  }

  ///
  Widget displayGold() {
    final goldState = _ref.watch(goldProvider);

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
      child: Container(
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
                    decoration: const BoxDecoration(color: Colors.indigo),
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
                    : Text(_utility
                        .makeCurrencyDisplay(goldState.payPrice.toString())),
                (goldState.goldValue == null)
                    ? Container()
                    : Text(_utility
                        .makeCurrencyDisplay(goldState.goldValue.toString())),
                Text(_utility.makeCurrencyDisplay(goldDiff.toString())),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  Widget displayStock() {
    final stockListState = _ref.watch(stockListProvider);

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
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(color: Colors.indigo),
                    child: const Text('STOCK'),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(stockListState.date.toString().split(' ')[0]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_utility
                    .makeCurrencyDisplay(stockListState.cost.toString())),
                Text(_utility
                    .makeCurrencyDisplay(stockListState.price.toString())),
                Text(_utility
                    .makeCurrencyDisplay(stockListState.diff.toString())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
