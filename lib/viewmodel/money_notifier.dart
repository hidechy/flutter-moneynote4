// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/benefit.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/money.dart';
import '../models/money_everyday.dart';
import '../models/money_score.dart';
import '../utility/utility.dart';
import 'benefit_notifier.dart';

/*
moneyProvider       Money
moneyEverydayProvider       List<MoneyEveryday>





//
//
//
// moneyScoreProvider        MoneyScoreState       *
//
//
//









*/

////////////////////////////////////////////////

final moneyProvider = StateNotifierProvider.autoDispose
    .family<MoneyNotifier, Money, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

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
    utility,
  )..getMoney(date: date);
});

class MoneyNotifier extends StateNotifier<Money> {
  MoneyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getMoney({required DateTime date}) async {
    await client.post(
      path: APIPath.moneydl,
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
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final moneyEverydayProvider = StateNotifierProvider.autoDispose<
    MoneyEverydayNotifier, List<MoneyEveryday>>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return MoneyEverydayNotifier([], client, utility)..getMoneyEveryday();
});

class MoneyEverydayNotifier extends StateNotifier<List<MoneyEveryday>> {
  MoneyEverydayNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getMoneyEveryday() async {
    await client.post(path: APIPath.getEverydayMoney).then((value) {
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
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

final moneyScoreProvider =
    StateNotifierProvider.autoDispose<MoneyScoreNotifier, List<MoneyScore>>(
        (ref) {
  final client = ref.read(httpClientProvider);

  final moneyEverydayState = ref.watch(moneyEverydayProvider);

  final benefitState = ref.watch(benefitProvider);

  return MoneyScoreNotifier(
    [],
    client,
    moneyEverydayState,
    benefitState,
  )..getMoneyScore();
});

class MoneyScoreNotifier extends StateNotifier<List<MoneyScore>> {
  MoneyScoreNotifier(
    super.state,
    this.client,
    this.moneyEverydayState,
    this.benefitState,
  );

  final HttpClient client;
  final List<MoneyEveryday> moneyEverydayState;
  final List<Benefit> benefitState;

  Future<void> getMoneyScore() async {
    final list = <MoneyScore>[];

    //--------------------------------------(1)
    final firstDayList = <String>[];

    moneyEverydayState.forEach((element) {
      if (element.date.day == 1) {
        firstDayList.add(element.date.yyyymmdd);
      }
    });

    final lastDayList = <DateTime>[];

    firstDayList.forEach((element) {
      final exElement = element.split('-');
      lastDayList.add(
        DateTime(exElement[0].toInt(), exElement[1].toInt(), 0),
      );
    });
    //--------------------------------------(1)

    //--------------------------------------(2)
    final bene = <String, List<int>>{};
    var beneList = <int>[];
    var keepYm = '';
    benefitState.forEach((element) {
      if (keepYm != element.ym) {
        beneList = [];
      }

      beneList.add(element.salary.toInt());

      bene[element.ym] = beneList;

      keepYm = element.ym;
    });

    final benefit = <String, int>{};
    bene.forEach((key, value) {
      var total = 0;
      value.forEach((element) {
        total += element;
      });

      benefit[key] = total;
    });

    //--------------------------------------(2)

    var keepSum = 0;
    moneyEverydayState.forEach((element) {
      lastDayList.forEach((element2) {
        if (element.date == element2) {
          list.add(
            MoneyScore(
              ym: element2.yyyymm,
              price: element.sum.toInt(),
              benefit: (benefit[element2.yyyymm] == null)
                  ? 0
                  : benefit[element2.yyyymm]!,
              updown: (element.sum.toInt() > keepSum) ? 1 : 0,
              sagaku: keepSum - element.sum.toInt(),
            ),
          );

          keepSum = element.sum.toInt();
        }
      });
    });

    state = list;
  }
}

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
