// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';

import '../data/http/client.dart';

import '../models/money.dart';

////////////////////////////////////////////////

final moneyProvider = StateNotifierProvider.autoDispose
    .family<MoneyNotifier, Money, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  return MoneyNotifier(
    Money(
      date: DateTime.now(),
      ym: '',
      yen10000: '',
      yen5000: '',
      yen2000: '',
      yen1000: '',
      yen500: '',
      yen100: '',
      yen50: '',
      yen10: '',
      yen5: '',
      yen1: '',
      bankA: '',
      bankB: '',
      bankC: '',
      bankD: '',
      bankE: '',
      payA: '',
      payB: '',
      payC: '',
      payD: '',
      payE: '',
      sum: '',
    ),
    client,
  )..getMoney(date: date);
});

class MoneyNotifier extends StateNotifier<Money> {
  MoneyNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getMoney({required DateTime date}) async {
    await client.post(
      path: 'moneydl',
      body: {'date': date.yyyymmdd},
    ).then((value) {
      state = Money(
        date: date,
        ym: date.yyyymm,
        yen10000: value['data']['yen_10000'].toString(),
        yen5000: value['data']['yen_5000'].toString(),
        yen2000: value['data']['yen_2000'].toString(),
        yen1000: value['data']['yen_1000'].toString(),
        yen500: value['data']['yen_500'].toString(),
        yen100: value['data']['yen_100'].toString(),
        yen50: value['data']['yen_50'].toString(),
        yen10: value['data']['yen_10'].toString(),
        yen5: value['data']['yen_5'].toString(),
        yen1: value['data']['yen_1'].toString(),
        bankA: value['data']['bank_a'].toString(),
        bankB: value['data']['bank_b'].toString(),
        bankC: value['data']['bank_c'].toString(),
        bankD: value['data']['bank_d'].toString(),
        bankE: value['data']['bank_e'].toString(),
        payA: value['data']['pay_a'].toString(),
        payB: value['data']['pay_b'].toString(),
        payC: value['data']['pay_c'].toString(),
        payD: value['data']['pay_d'].toString(),
        payE: value['data']['pay_e'].toString(),
        sum: value['data']['sum'].toString(),
      );
    });
  }
}

////////////////////////////////////////////////
