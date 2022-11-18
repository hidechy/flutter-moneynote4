// ignore_for_file: must_be_immutable, sized_box_shrink_expand

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/money.dart';
import '../../utility/utility.dart';
import '../../viewmodel/money_viewmodel.dart';

class MoneyAlert extends ConsumerWidget {
  MoneyAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moneyState = ref.watch(moneyProvider(date.toString().split(' ')[0]));

    return AlertDialog(
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
                Text(
                  moneyState.date.toString().split(' ')[0],
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 30),
                displayMoney(data: moneyState),
                const SizedBox(height: 30),
                displayBank(data: moneyState),
                const SizedBox(height: 30),
                displayPay(data: moneyState),
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
}
