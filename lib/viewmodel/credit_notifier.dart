// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';

import '../models/credit_spend_monthly.dart';

////////////////////////////////////////////////

final creditSpendMonthlyProvider = StateNotifierProvider.autoDispose
    .family<CreditSpendMonthlyNotifier, List<CreditSpendMonthly>, String>(
        (ref, date) {
  final client = ref.read(httpClientProvider);

  return CreditSpendMonthlyNotifier(
    [],
    client,
  )..getCreditSpendMonthly(date: date, kind: '');
});

class CreditSpendMonthlyNotifier
    extends StateNotifier<List<CreditSpendMonthly>> {
  CreditSpendMonthlyNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getCreditSpendMonthly(
      {required String date, required String kind}) async {
    await client.post(
      path: 'uccardspend',
      body: {'date': date},
    ).then((value) {
      final list = <CreditSpendMonthly>[];

      for (var i = 0; i < int.parse(value['data'].length.toString()); i++) {
        if (kind == '') {
          list.add(
            CreditSpendMonthly(
              item: value['data'][i]['item'].toString(),
              price: value['data'][i]['price'].toString(),
              date: DateTime.parse(value['data'][i]['date'].toString()),
              kind: value['data'][i]['kind'].toString(),
            ),
          );
        } else {
          if (kind == value['data'][i]['kind'].toString()) {
            list.add(
              CreditSpendMonthly(
                item: value['data'][i]['item'].toString(),
                price: value['data'][i]['price'].toString(),
                date: DateTime.parse(value['data'][i]['date'].toString()),
                kind: value['data'][i]['kind'].toString(),
              ),
            );
          }
        }
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////
