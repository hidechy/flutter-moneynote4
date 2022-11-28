// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/credit_summary_record.dart';

import '../../extensions/extensions.dart';
import '../data/http/client.dart';
import '../models/credit_spend_monthly.dart';
import '../models/credit_summary.dart';

//import '../state/credit_summary_param_state.dart';

////////////////////////////////////////////////

final creditSpendMonthlyProvider = StateNotifierProvider.autoDispose
    .family<CreditSpendMonthlyNotifier, List<CreditSpendMonthly>, DateTime>(
        (ref, date) {
  final client = ref.read(httpClientProvider);

  return CreditSpendMonthlyNotifier([], client)
    ..getCreditSpendMonthly(date: date, kind: '');
});

class CreditSpendMonthlyNotifier
    extends StateNotifier<List<CreditSpendMonthly>> {
  CreditSpendMonthlyNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getCreditSpendMonthly(
      {required DateTime date, required String kind}) async {
    await client.post(
      path: 'uccardspend',
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <CreditSpendMonthly>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
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

////////////////////////////////////////////////

final creditSummaryProvider = StateNotifierProvider.autoDispose
    .family<CreditSummaryNotifier, List<CreditSummary>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  return CreditSummaryNotifier(
    [],
    client,
  )..getCreditSummary(date: date);
});

class CreditSummaryNotifier extends StateNotifier<List<CreditSummary>> {
  CreditSummaryNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getCreditSummary({required DateTime date}) async {
    final year = date.yyyy;

    await client.post(
      path: 'getYearCreditSummarySummary',
      body: {'year': year},
    ).then((value) {
      final list = <CreditSummary>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final list2 = <CreditSummaryRecord>[];
        for (var j = 0;
            j < value['data'][i]['list'].length.toString().toInt();
            j++) {
          list2.add(
            CreditSummaryRecord(
              month: value['data'][i]['list'][j]['month'].toString(),
              price: value['data'][i]['list'][j]['price'].toString().toInt(),
            ),
          );
        }

        list.add(
          CreditSummary(
            item: value['data'][i]['item'].toString(),
            list: list2,
          ),
        );
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////
