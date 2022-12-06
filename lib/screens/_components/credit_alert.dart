// ignore_for_file: must_be_immutable, noop_primitive_operations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../models/credit_spend_monthly.dart';
import '../../viewmodel/credit_notifier.dart';

class CreditAlert extends ConsumerWidget {
  CreditAlert({super.key, required this.date});

  final DateTime date;

  Uuid uuid = const Uuid();

  late WidgetRef _ref;
  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;
    _context = context;

    final creditSpendMonthlyState = ref.watch(creditSpendMonthlyProvider(date));

    final selectCreditState = ref.watch(selectCreditProvider);

    final total = makeTotalPrice(data: creditSpendMonthlyState);

    final cardList = makeCardList(data: creditSpendMonthlyState);

    final exDate = date.toString().split(' ');
    final exYmd = exDate[0].split('-');

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(width: context.screenSize.width),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${exYmd[0]}-${exYmd[1]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    total.toString().toCurrency(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: cardList.map((kind) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .watch(selectCreditProvider.notifier)
                                  .setSelectCredit(selectCredit: kind);

                              ref
                                  .watch(
                                      creditSpendMonthlyProvider(date).notifier)
                                  .getCreditSpendMonthly(
                                    date: date,
                                    kind: kind,
                                  );
                            },
                            child: getCreditMark(kind: kind),
                          ),
                        );
                      }).toList(),
                    ),
                    Text(selectCreditState),
                  ],
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
        _ref.watch(creditSpendMonthlyProvider(date));

    final list = <Widget>[];

    for (var i = 0; i < creditSpendMonthlyState.length; i++) {
      list.add(
        Container(
          width: _context.screenSize.width,
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
                        creditSpendMonthlyState[i].price.toCurrency(),
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
      key: PageStorageKey(uuid.v1()),
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
      case 'sumitomo':
        return const Icon(Icons.credit_card, color: Colors.greenAccent);
    }

    return const Icon(Icons.credit_card, color: Colors.white);
  }

  ///
  int makeTotalPrice({required List<CreditSpendMonthly> data}) {
    var ret = 0;

    for (var i = 0; i < data.length; i++) {
      ret += int.parse(data[i].price.toString());
    }

    return ret;
  }

  ///
  List<String> makeCardList({required List<CreditSpendMonthly> data}) {
    final list = <String>[''];

    for (var i = 0; i < data.length; i++) {
      if (!list.contains(data[i].kind)) {
        list.add(data[i].kind);
      }
    }

    return list;
  }
}
