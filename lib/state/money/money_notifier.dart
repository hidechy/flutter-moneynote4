// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/benefit.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/money.dart';
import '../../models/money_everyday.dart';
import '../../models/money_score.dart';
import '../../utility/utility.dart';
import '../benefit/benefit_notifier.dart';
import 'money_response_state.dart';

/*
moneyProvider       MoneyResponseState
moneyEverydayProvider       MoneyResponseState
moneyScoreProvider        MoneyResponseState
*/

////////////////////////////////////////////////

final moneyProvider =
    StateNotifierProvider.autoDispose.family<MoneyNotifier, MoneyResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return MoneyNotifier(const MoneyResponseState(), client, utility)..getMoney(date: date);
});

class MoneyNotifier extends StateNotifier<MoneyResponseState> {
  MoneyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getMoney({required DateTime date}) async {
    await client.post(path: APIPath.moneydl, body: {'date': date.yyyymmdd}).then((value) {
      var currency = 0;

      final currencyVal = <int>[];
      final currencyKey = [10000, 5000, 2000, 1000, 500, 100, 50, 10, 5, 1];
      currencyVal
        ..add(value['data']['yen_10000'] != null ? value['data']['yen_10000'].toString().toInt() : 0)
        ..add(value['data']['yen_5000'] != null ? value['data']['yen_5000'].toString().toInt() : 0)
        ..add(value['data']['yen_2000'] != null ? value['data']['yen_2000'].toString().toInt() : 0)
        ..add(value['data']['yen_1000'] != null ? value['data']['yen_1000'].toString().toInt() : 0)
        ..add(value['data']['yen_500'] != null ? value['data']['yen_500'].toString().toInt() : 0)
        ..add(value['data']['yen_100'] != null ? value['data']['yen_100'].toString().toInt() : 0)
        ..add(value['data']['yen_50'] != null ? value['data']['yen_50'].toString().toInt() : 0)
        ..add(value['data']['yen_10'] != null ? value['data']['yen_10'].toString().toInt() : 0)
        ..add(value['data']['yen_5'] != null ? value['data']['yen_5'].toString().toInt() : 0)
        ..add(value['data']['yen_1'] != null ? value['data']['yen_1'].toString().toInt() : 0);

      var i = 0;
      currencyVal.forEach((element) {
        if (element != 0) {
          currency += currencyKey[i] * element;
        }

        i++;
      });

      state = state.copyWith(
        money: Money(
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
          currency: currency,
        ),
      );
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final moneyEverydayProvider = StateNotifierProvider.autoDispose<MoneyEverydayNotifier, MoneyResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return MoneyEverydayNotifier(const MoneyResponseState(), client, utility)..getMoneyEveryday();
});

class MoneyEverydayNotifier extends StateNotifier<MoneyResponseState> {
  MoneyEverydayNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getMoneyEveryday() async {
    await client.post(path: APIPath.getEverydayMoney).then((value) {
      final list = <MoneyEveryday>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          MoneyEveryday(
            date: DateTime(
              value['data'][i]['date'].toString().split('-')[0].toInt(),
              value['data'][i]['date'].toString().split('-')[1].toInt(),
              value['data'][i]['date'].toString().split('-')[2].toInt(),
            ),
            youbiNum: value['data'][i]['youbiNum'].toString(),
            sum: value['data'][i]['sum'].toString(),
            spend: value['data'][i]['spend'].toString(),
          ),
        );
      }

      state = state.copyWith(moneyEverydayList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final moneyAllProvider = StateNotifierProvider.autoDispose<MoneyAllNotifier, MoneyResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return MoneyAllNotifier(const MoneyResponseState(), client, utility)..getMoneyAll();
});

class MoneyAllNotifier extends StateNotifier<MoneyResponseState> {
  MoneyAllNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getMoneyAll() async {
    await client.post(path: APIPath.getAllMoney).then((value) {
      final list = <Money>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final exValue = value['data'][i].toString().split('|');

        list.add(
          Money(
            date: DateTime.parse(exValue[0]),
            ym: exValue[1],
            yen10000: exValue[2],
            yen5000: exValue[3],
            yen2000: exValue[4],
            yen1000: exValue[5],
            yen500: exValue[6],
            yen100: exValue[7],
            yen50: exValue[8],
            yen10: exValue[9],
            yen5: exValue[10],
            yen1: exValue[11],
            bankA: exValue[12],
            bankB: exValue[13],
            bankC: exValue[14],
            bankD: exValue[15],
            bankE: exValue[16],
            payA: exValue[17],
            payB: exValue[18],
            payC: exValue[19],
            payD: exValue[20],
            payE: exValue[21],
            sum: '',
            currency: 0,
          ),
        );
      }

      state = state.copyWith(moneyList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

final moneyScoreProvider = StateNotifierProvider.autoDispose<MoneyScoreNotifier, MoneyResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final moneyEverydayState = ref.watch(moneyEverydayProvider.select((value) => value.moneyEverydayList));
  final everydayList = (moneyEverydayState.value != null) ? moneyEverydayState.value! : <MoneyEveryday>[];

  final benefitList = ref.watch(benefitProvider.select((value) => value.benefitList));
  final bList = (benefitList.value != null) ? benefitList.value! : <Benefit>[];

  return MoneyScoreNotifier(const MoneyResponseState(), client, everydayList, bList)..getMoneyScore();
});

class MoneyScoreNotifier extends StateNotifier<MoneyResponseState> {
  MoneyScoreNotifier(
    super.state,
    this.client,
    this.moneyEverydayState,
    this.benefitList,
  );

  final HttpClient client;
  final List<MoneyEveryday> moneyEverydayState;
  final List<Benefit> benefitList;

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

    benefitList.forEach((element) {
      if (keepYm != element.ym) {
        beneList = [];
      }

      beneList.add(element.salary.toInt());

      bene[element.ym] = beneList;

      keepYm = element.ym;
    });

    //
    //
    // benefitState.benefitList.forEach((element) {
    //   if (keepYm != element.ym) {
    //     beneList = [];
    //   }
    //
    //   beneList.add(element.salary.toInt());
    //
    //   bene[element.ym] = beneList;
    //
    //   keepYm = element.ym;
    // });
    //
    //
    //
    //

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
              benefit: (benefit[element2.yyyymm] == null) ? 0 : benefit[element2.yyyymm]!,
              updown: (element.sum.toInt() > keepSum) ? 1 : 0,
              sagaku: keepSum - element.sum.toInt(),
            ),
          );

          keepSum = element.sum.toInt();
        }
      });
    });

    state = state.copyWith(moneyScoreList: AsyncValue.data(list));
  }
}

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
