// ignore_for_file: must_be_immutable, noop_primitive_operations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/credit_spend_monthly.dart';
import '../../utility/utility.dart';
import '../../viewmodel/credit_notifier.dart';

class CreditAlert extends ConsumerWidget {
  CreditAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final exDate = date.toString().split(' ');
    final exYmd = exDate[0].split('-');

    final creditSpendMonthlyState =
        ref.watch(creditSpendMonthlyProvider(date.toString()));

    final total = makeTotalPrice(data: creditSpendMonthlyState);

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40),
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
                    '${exYmd[0]}-${exYmd[1]}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    _utility.makeCurrencyDisplay(total.toString()),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
                dispCredit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget dispCredit() {
    final creditSpendMonthlyState =
        _ref.watch(creditSpendMonthlyProvider(date.toString()));

    final list = <Widget>[];

    for (var i = 0; i < creditSpendMonthlyState.length; i++) {
      list.add(
        Container(
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(creditSpendMonthlyState[i]
                        .date
                        .toString()
                        .split(' ')[0]),
                    Text(creditSpendMonthlyState[i].item),
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        _utility.makeCurrencyDisplay(
                            creditSpendMonthlyState[i].price),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              getCreditMark(kind: creditSpendMonthlyState[i].kind),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }

  ///
  Widget getCreditMark({required String kind}) {
    switch (kind) {
      case 'uc':
        return const Icon(Icons.credit_card, color: Colors.redAccent);
      case 'rakuten':
        return const Icon(Icons.credit_card, color: Colors.orangeAccent);

      case 'amex':
        return const Icon(Icons.credit_card, color: Colors.purpleAccent);
    }

    return Container();
  }

  ///
  int makeTotalPrice({required List<CreditSpendMonthly> data}) {
    var ret = 0;

    for (var i = 0; i < data.length; i++) {
      ret += int.parse(data[i].price.toString());
    }

    return ret;
  }
}
