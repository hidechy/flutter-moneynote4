// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/money_everyday.dart';

import '../data/http/client.dart';
import '../extensions/extensions.dart';
import '../models/money.dart';

import '../models/money_score.dart';

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

////////////////////////////////////////////////

final moneyScoreProvider =
    StateNotifierProvider.autoDispose<MoneyScoreNotifier, List<MoneyScore>>(
        (ref) {
  final client = ref.read(httpClientProvider);

  final moneyEverydayState = ref.watch(moneyEverydayProvider);

  return MoneyScoreNotifier([], client, moneyEverydayState)..getMoneyScore();
});

class MoneyScoreNotifier extends StateNotifier<List<MoneyScore>> {
  MoneyScoreNotifier(super.state, this.client, this.moneyEverydayState);

  final HttpClient client;
  final List<MoneyEveryday> moneyEverydayState;

  Future<void> getMoneyScore() async {
    final list = <MoneyScore>[];

    final allSum = <String, int>{};
    final ymList = <String>[];
    for (var i = 0; i < moneyEverydayState.length; i++) {
      allSum[moneyEverydayState[i].date.yyyymmdd] =
          moneyEverydayState[i].sum.toInt();

      if (moneyEverydayState[i].date.dd == '01') {
        ymList.add(moneyEverydayState[i].date.yyyymm);
      }
    }

    for (var i = 0; i < ymList.length; i++) {
      final price = allSum['${ymList[i]}-01'];

      final nextPrice =
          (i < ymList.length - 1) ? allSum['${ymList[i + 1]}-01'] : 0;

      final sag = nextPrice! - price.toString().toInt();
      final sagaku = (sag < 0) ? sag * -1 : sag;
      final manen = (sagaku / 10000).ceil();
      final updown = (sag < 0) ? 0 : 1;

      list.add(
        MoneyScore(
          ym: ymList[i],
          price: price.toString(),
          manen: manen.toString(),
          updown: updown.toString(),
          sagaku: sagaku.toString(),
        ),
      );
    }

    state = list;
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final moneyEverydayProvider = StateNotifierProvider.autoDispose<
    MoneyEverydayNotifier, List<MoneyEveryday>>((ref) {
  final client = ref.read(httpClientProvider);

  return MoneyEverydayNotifier([], client)..getMoneyEveryday();
});

class MoneyEverydayNotifier extends StateNotifier<List<MoneyEveryday>> {
  MoneyEverydayNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getMoneyEveryday() async {
    await client.post(path: 'getEverydayMoney').then((value) {
      final list = <MoneyEveryday>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          MoneyEveryday(
            date: '${value['data'][i]['date']} 00:00:00'.toDateTime(),
            youbiNum: value['data'][i]['youbiNum'].toString(),
            sum: value['data'][i]['sum'].toString(),
            spend: value['data'][i]['spend'].toString(),
          ),
        );
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////
