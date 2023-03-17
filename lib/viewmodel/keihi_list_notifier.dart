// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/tax_payment_item.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/keihi.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////

final keihiListProvider = StateNotifierProvider.autoDispose
    .family<KeihiListNotifier, List<Keihi>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return KeihiListNotifier([], client, utility)..getKeihiList(date: date);
});

class KeihiListNotifier extends StateNotifier<List<Keihi>> {
  KeihiListNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getKeihiList({required DateTime date}) async {
    await client.post(
      path: APIPath.selectSpendCheckItem,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <Keihi>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(Keihi.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final taxPaymentItemProvider = StateNotifierProvider.autoDispose
    .family<TaxPaymentItemNotifier, TaxPaymentItem, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return TaxPaymentItemNotifier(
      TaxPaymentItem(
          year: '',
          businessIncome: 0,
          incomeDividend: 0,
          salaryIncome: 0,
          expenses: 0,
          incomeAmountDividend: 0,
          employmentIncome: 0,
          socialInsuranceDeduction: 0,
          smallBusinessDeduction: 0,
          lifeInsuranceDeduction: 0,
          donationDeduction: 0,
          dividendDeduction: 0,
          withholdingTaxAmount: 0,
          blueSpecialDeduction: 0),
      client,
      utility)
    ..getTaxPaymentItem(date: date);
});

class TaxPaymentItemNotifier extends StateNotifier<TaxPaymentItem> {
  TaxPaymentItemNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getTaxPaymentItem({required DateTime date}) async {
    await client.post(
      path: APIPath.getTaxPaymentItem,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      state = TaxPaymentItem.fromJson(value['data'] as Map<String, dynamic>);
    });
  }
}

////////////////////////////////////////////////
