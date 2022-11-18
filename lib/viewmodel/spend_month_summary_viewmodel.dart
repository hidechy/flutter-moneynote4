// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../models/spend_month_summary.dart';

final spendMonthSummaryProvider = StateNotifierProvider.autoDispose
    .family<SpendMonthSummaryNotifier, List<SpendMonthSummary>, String>(
        (ref, date) {
  final client = ref.read(httpClientProvider);

  return SpendMonthSummaryNotifier(
    [],
    client,
  )..getSpendMonthSummary(date: date);
});

class SpendMonthSummaryNotifier extends StateNotifier<List<SpendMonthSummary>> {
  SpendMonthSummaryNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getSpendMonthSummary({required String date}) async {
    await client.post(
      path: 'monthsummary',
      body: {'date': date},
    ).then((value) {
      final list = <SpendMonthSummary>[];

      for (var i = 0; i < int.parse(value['data'].length.toString()); i++) {
        list.add(
          SpendMonthSummary(
            item: value['data'][i]['item'].toString(),
            sum: int.parse(value['data'][i]['sum'].toString()),
            percent: int.parse(value['data'][i]['percent'].toString()),
          ),
        );
      }

      state = list;
    });
  }
}
