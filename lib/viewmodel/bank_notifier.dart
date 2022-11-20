// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../models/bank_company_all.dart';
import '../models/bank_company_change.dart';

////////////////////////////////////////////////

final bankLastProvider = StateNotifierProvider.autoDispose
    .family<BankLastNotifier, BankCompanyChange, String>((ref, bank) {
  final client = ref.read(httpClientProvider);

  return BankLastNotifier(
    BankCompanyChange(
      date: DateTime.now(),
      price: '',
      diff: 0,
    ),
    client,
  )..getBankCompanyRecord(bank: bank);
});

class BankLastNotifier extends StateNotifier<BankCompanyChange> {
  BankLastNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getBankCompanyRecord({required String bank}) async {
    await client.post(
      path: 'bankSearch',
      body: {'bank': bank},
    ).then((value) {
      var bankCompanyRecord = BankCompanyChange(
        date: DateTime.now(),
        price: '',
        diff: 0,
      );

      for (var i = 0; i < int.parse(value['data'].length.toString()); i++) {
        bankCompanyRecord = BankCompanyChange(
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

////////////////////////////////////////////////

final bankAllProvider = StateNotifierProvider.autoDispose
    .family<BankAllNotifier, List<BankCompanyAll>, String>((ref, bank) {
  final client = ref.read(httpClientProvider);

  return BankAllNotifier(
    [],
    client,
  )..getBankCompanyRecord(bank: bank);
});

class BankAllNotifier extends StateNotifier<List<BankCompanyAll>> {
  BankAllNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getBankCompanyRecord({required String bank}) async {
    await client.post(
      path: 'getAllBank',
      body: {'bank': bank},
    ).then((value) {
      final list = <BankCompanyAll>[];

      for (var i = 0; i < int.parse(value['data'].length.toString()); i++) {
        var mark = '';
        if (i == 0) {
          mark = 'up';
        } else {
          if (int.parse(value['data'][i][bank].toString()) >
              int.parse(value['data'][i - 1][bank].toString())) {
            mark = 'up';
          } else if (int.parse(value['data'][i][bank].toString()) <
              int.parse(value['data'][i - 1][bank].toString())) {
            mark = 'down';
          } else {
            mark = 'equal';
          }
        }

        list.add(
          BankCompanyAll(
            date: DateTime.parse(value['data'][i]['date'].toString()),
            price: value['data'][i][bank].toString(),
            mark: mark,
          ),
        );
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////
