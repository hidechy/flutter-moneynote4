// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/bank_company_all.dart';
import '../../models/bank_company_change.dart';
import '../../models/bank_monthly_spend.dart';
import '../../models/bank_move.dart';
import '../../utility/utility.dart';
import 'bank_response_state.dart';

/*
bankLastProvider        BankResponseState
bankAllProvider       BankResponseState
bankMoveProvider        BankResponseState
bankMonthlySpendProvider        BankResponseState
*/

////////////////////////////////////////////////

final bankLastProvider =
    StateNotifierProvider.autoDispose.family<BankLastNotifier, BankResponseState, String>((ref, bank) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BankLastNotifier(const BankResponseState(), client, utility)..getBankLastRecord(bank: bank);
});

class BankLastNotifier extends StateNotifier<BankResponseState> {
  BankLastNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBankLastRecord({required String bank}) async {
    await client.post(
      path: APIPath.bankSearch,
      body: {'bank': bank},
    ).then((value) {
      var bankCompanyRecord = BankCompanyChange(date: DateTime.now(), price: '', diff: 0);

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        bankCompanyRecord = BankCompanyChange(
          date: DateTime.parse(value['data'][i]['date'].toString()),
          price: value['data'][i]['price'].toString(),
          diff: value['data'][i]['diff'].toString().toInt(),
        );
      }

      state = state.copyWith(bankCompanyChange: bankCompanyRecord);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final bankCompanyListProvider =
    StateNotifierProvider.autoDispose.family<BankCompanyListNotifier, BankResponseState, String>((ref, bank) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BankCompanyListNotifier(const BankResponseState(), client, utility)..getBankCompanyList(bank: bank);
});

class BankCompanyListNotifier extends StateNotifier<BankResponseState> {
  BankCompanyListNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBankCompanyList({required String bank}) async {
    await client.post(path: APIPath.getAllBank, body: {'bank': bank}).then((value) {
      if (bank == '') {
        state = state.copyWith(bankCompanyList: const AsyncValue.data([]));
        return;
      }

      final list = <BankCompanyAll>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        var mark = '';
        if (i == 0) {
          mark = 'up';
        } else {
          if (value['data'][i][bank].toString().toInt() > value['data'][i - 1][bank].toString().toInt()) {
            mark = 'up';
          } else if (value['data'][i][bank].toString().toInt() < value['data'][i - 1][bank].toString().toInt()) {
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

      state = state.copyWith(bankCompanyList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final bankMoveProvider = StateNotifierProvider.autoDispose<BankMoveNotifier, BankResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BankMoveNotifier(const BankResponseState(), client, utility)..getBankMove();
});

class BankMoveNotifier extends StateNotifier<BankResponseState> {
  BankMoveNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBankMove() async {
    await client.post(path: APIPath.getBankMove).then((value) {
      final list = <BankMove>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(BankMove.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = state.copyWith(bankMoveList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final bankMonthlySpendProvider =
    StateNotifierProvider.autoDispose.family<BankMonthlySpendNotifier, BankResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BankMonthlySpendNotifier(const BankResponseState(), client, utility)..getBankMonthlySpend(date: date);
});

class BankMonthlySpendNotifier extends StateNotifier<BankResponseState> {
  BankMonthlySpendNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getBankMonthlySpend({required DateTime date}) async {
    await client.post(path: APIPath.getMonthlyBankRecord, body: {'date': date.yyyymmdd}).then((value) {
      final list = <BankMonthlySpend>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(BankMonthlySpend.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = state.copyWith(bankMonthlySpendList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
