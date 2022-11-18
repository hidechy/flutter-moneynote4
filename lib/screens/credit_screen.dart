// ignore_for_file: must_be_immutable, noop_primitive_operations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/credit_spend_monthly.dart';
import 'package:moneynote4/utility/utility.dart';

import '../viewmodel/credit_spend_monthly_viewmodel.dart';

class CreditScreen extends ConsumerWidget {
  CreditScreen({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exDate = date.toString().split(' ');
    final exYmd = exDate[0].split('-');

    final creditSpendMonthlyState =
        ref.watch(creditSpendMonthlyProvider(date.toString()));

    final total = makeTotalPrice(data: creditSpendMonthlyState);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: Column(
              children: [
                const SizedBox(height: 70),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${exYmd[0]}-${exYmd[1]}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 30),
                          Text(
                            _utility.makeCurrencyDisplay(total.toString()),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 10),
                      itemBuilder: (context, index) {
                        final credit = creditSpendMonthlyState[index];

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(credit.date.toString().split(' ')[0]),
                                  Text(credit.item),
                                  Container(
                                    alignment: Alignment.topRight,
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      _utility
                                          .makeCurrencyDisplay(credit.price),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            getCreditMark(kind: credit.kind),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const Divider(color: Colors.white),
                      itemCount: creditSpendMonthlyState.length,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
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
