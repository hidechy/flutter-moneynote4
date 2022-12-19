// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/bank_company_all.dart';
import '../models/bank_company_change.dart';
import '../models/bank_move.dart';
import '../utility/utility.dart';

/*
bankLastProvider        BankCompanyChange
bankAllProvider       List<BankCompanyAll>
bankMoveProvider        List<BankMove>
*/

////////////////////////////////////////////////

final bankLastProvider = StateNotifierProvider.autoDispose
    .family<BankLastNotifier, BankCompanyChange, String>((ref, bank) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BankLastNotifier(
    BankCompanyChange(date: DateTime.now(), price: '', diff: 0),
    client,
    utility,
  )..getBankCompanyRecord(bank: bank);
});

class BankLastNotifier extends StateNotifier<BankCompanyChange> {
  BankLastNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBankCompanyRecord({required String bank}) async {
    await client.post(
      path: APIPath.bankSearch,
      body: {'bank': bank},
    ).then((value) {
      var bankCompanyRecord = BankCompanyChange(
        date: DateTime.now(),
        price: '',
        diff: 0,
      );

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        bankCompanyRecord = BankCompanyChange(
          date: DateTime.parse(value['data'][i]['date'].toString()),
          price: value['data'][i]['price'].toString(),
          diff: int.parse(value['data'][i]['diff'].toString()),
        );
      }

      state = bankCompanyRecord;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final bankAllProvider = StateNotifierProvider.autoDispose
    .family<BankAllNotifier, List<BankCompanyAll>, String>((ref, bank) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BankAllNotifier([], client, utility)..getBankCompanyRecord(bank: bank);
});

class BankAllNotifier extends StateNotifier<List<BankCompanyAll>> {
  BankAllNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBankCompanyRecord({required String bank}) async {
    if (bank == '') {
      state = [];
      return;
    }

    await client.post(
      path: APIPath.getAllBank,
      body: {'bank': bank},
    ).then((value) {
      final list = <BankCompanyAll>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
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
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final bankMoveProvider =
    StateNotifierProvider.autoDispose<BankMoveNotifier, List<BankMove>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BankMoveNotifier([], client, utility)..getBankMove();
});

class BankMoveNotifier extends StateNotifier<List<BankMove>> {
  BankMoveNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBankMove() async {
    await client.post(path: APIPath.getBankMove).then((value) {
      final list = <BankMove>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          BankMove.fromJson(value['data'][i] as Map<String, dynamic>),
        );
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
