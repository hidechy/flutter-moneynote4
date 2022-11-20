// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../models/bank_company_record.dart';

////////////////////////////////////////////////

final bankProvider = StateNotifierProvider.autoDispose
    .family<BankNotifier, BankCompanyRecord, String>((ref, bank) {
  final client = ref.read(httpClientProvider);

  return BankNotifier(
    BankCompanyRecord(
      date: DateTime.now(),
      price: '',
      diff: 0,
    ),
    client,
  )..getBankCompanyRecord(bank: bank);
});

class BankNotifier extends StateNotifier<BankCompanyRecord> {
  BankNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getBankCompanyRecord({required String bank}) async {
    await client.post(
      path: 'bankSearch',
      body: {'bank': bank},
    ).then((value) {
      var bankCompanyRecord = BankCompanyRecord(
        date: DateTime.now(),
        price: '',
        diff: 0,
      );

      for (var i = 0; i < int.parse(value['data'].length.toString()); i++) {
        bankCompanyRecord = BankCompanyRecord(
          date: DateTime.parse(value['data'][i]['date'].toString()),
          price: value['data'][i]['price'].toString(),
          diff: int.parse(value['data'][i]['diff'].toString()),
        );
      }

      state = bankCompanyRecord;
    });
  }
}

////////////////////////////////////////////////
