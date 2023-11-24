// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../models/credit_company.dart';
import '../../models/credit_spend_all.dart';
import '../../models/credit_spend_monthly.dart';
import '../../models/credit_summary.dart';
import '../../utility/utility.dart';
import 'credit_response_state.dart';

/*
creditSpendMonthlyProvider        List<CreditSpendMonthly>
creditSummaryProvider       CreditSummaryState // saving
creditCompanyProvider       List<CreditCompany>
selectCreditProvider        String
creditYearlyTotalProvider       List<CreditSpendAll>
creditSummaryDetailProvider       List<SpendYearlyDetail>       *
creditUdemyProvider       List<CreditSpendMonthly>        *
*/

////////////////////////////////////////////////

final creditSpendMonthlyProvider =
    StateNotifierProvider.autoDispose.family<CreditSpendMonthlyNotifier, CreditResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return CreditSpendMonthlyNotifier(const CreditResponseState(), client, utility)
    ..getCreditSpendMonthly(date: date, kind: '');
});

class CreditSpendMonthlyNotifier extends StateNotifier<CreditResponseState> {
  CreditSpendMonthlyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getCreditSpendMonthly({required DateTime date, required String kind}) async {
    await client.post(
      path: APIPath.uccardspend,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <CreditSpendMonthly>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (kind == '') {
          list.add(
            CreditSpendMonthly(
              item: value['data'][i]['item'].toString(),
              price: value['data'][i]['price'].toString(),
              date: DateTime.parse(value['data'][i]['date'].toString()),
              kind: value['data'][i]['kind'].toString(),
            ),
          );
        } else {
          if (kind == value['data'][i]['kind'].toString()) {
            list.add(
              CreditSpendMonthly(
                item: value['data'][i]['item'].toString(),
                price: value['data'][i]['price'].toString(),
                date: DateTime.parse(value['data'][i]['date'].toString()),
                kind: value['data'][i]['kind'].toString(),
              ),
            );
          }
        }
      }

      state = state.copyWith(creditSpendMonthlyList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final creditSummaryProvider =
    StateNotifierProvider.autoDispose.family<CreditSummaryNotifier, CreditResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return CreditSummaryNotifier(const CreditResponseState(), client, utility)..getCreditSummary(date: date);
});

class CreditSummaryNotifier extends StateNotifier<CreditResponseState> {
  CreditSummaryNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getCreditSummary({required DateTime date}) async {
    await client.post(path: APIPath.getYearCreditSummarySummary, body: {'year': date.yyyy}).then((value) {
      final list = <CreditSummary>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(CreditSummary.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      state = state.copyWith(creditSummaryList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final creditCompanyProvider =
    StateNotifierProvider.autoDispose.family<CreditCompanyNotifier, CreditResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return CreditCompanyNotifier(const CreditResponseState(), client, utility)..getCreditCompany(date: date);
});

class CreditCompanyNotifier extends StateNotifier<CreditResponseState> {
  CreditCompanyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getCreditCompany({required DateTime date}) async {
    await client.post(path: APIPath.getcompanycredit, body: {'date': date.yyyymmdd}).then((value) {
      final list = <CreditCompany>[];

      var keepYm = '';
      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        for (var j = 0; j < value['data'][i]['list'].length.toString().toInt(); j++) {
          if (keepYm != value['data'][i]['ym'].toString()) {
            list.add(
              CreditCompany.fromJson(value['data'][i] as Map<String, dynamic>),
            );
          }

          keepYm = value['data'][i]['ym'].toString();
        }
      }

      state = state.copyWith(creditCompanyList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final selectCreditProvider = StateNotifierProvider.autoDispose<SelectCreditStateNotifier, String>((ref) {
  return SelectCreditStateNotifier();
});

class SelectCreditStateNotifier extends StateNotifier<String> {
  SelectCreditStateNotifier() : super('');

  ///
  Future<void> setSelectCredit({required String selectCredit}) async {
    state = selectCredit;
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final creditYearlyTotalProvider =
    StateNotifierProvider.autoDispose.family<CreditYearlyTotalNotifier, CreditResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return CreditYearlyTotalNotifier(const CreditResponseState(), client, utility)..getCreditYearlyTotal(date: date);
});

class CreditYearlyTotalNotifier extends StateNotifier<CreditResponseState> {
  CreditYearlyTotalNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getCreditYearlyTotal({required DateTime date}) async {
    await client.post(path: APIPath.carditemlist).then((value) {
      final list = <CreditSpendAll>[];

      final midashi = <String>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        if (date.yyyy ==
            DateTime(
              value['data'][i]['pay_month'].toString().split('-')[0].toInt(),
              value['data'][i]['pay_month'].toString().split('-')[1].toInt(),
            ).yyyy) {
          final item = value['data'][i]['item'].toString();

          final date = DateTime(
            value['data'][i]['date'].toString().split('-')[0].toInt(),
            value['data'][i]['date'].toString().split('-')[1].toInt(),
            value['data'][i]['date'].toString().split('-')[2].toInt(),
          );

          list.add(
            CreditSpendAll(
              payMonth: value['data'][i]['pay_month'].toString(),
              item: item,
              price: value['data'][i]['price'].toString(),
              date: date,
              kind: value['data'][i]['kind'].toString(),
              monthDiff: (value['data'][i]['monthDiff'] == null) ? 0 : value['data'][i]['monthDiff'].toString().toInt(),
              flag: value['data'][i]['flag'].toString().toInt(),
            ),
          );

          final str = '$item|${date.yyyymm}';

          if (!midashi.contains(str)) {
            midashi.add(str);
          }
        }
      }

      midashi.sort((a, b) => a.compareTo(b));

      final list2 = <CreditSpendAll>[];

      midashi.forEach((element) {
        list.forEach((element2) {
          if (element == '${element2.item}|${element2.date.yyyymm}') {
            list2.add(element2);
          }
        });
      });

      state = state.copyWith(creditSpendAllList: AsyncValue.data(list));
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

//
//
//
// //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
//
// final creditSummaryDetailProvider =
//     StateNotifierProvider.autoDispose.family<CreditSummaryDetailNotifier, CreditResponseState, DateTime>((ref, date) {
//   final client = ref.read(httpClientProvider);
//
//   final utility = Utility();
//
//   // final creditSummaryState = ref.watch(creditSummaryProvider(date));
//   //
//   //
//   //
//
//   final creditSummaryList = ref.watch(creditSummaryProvider(date).select((value) => value.creditSummaryList));
//
//   final summaryList = (creditSummaryList.value != null) ? creditSummaryList.value! : <CreditSummary>[];
//
//   return CreditSummaryDetailNotifier(const CreditResponseState(), client, utility, summaryList)
//     ..getCreditSummaryDetail(date: date);
// });
//
// class CreditSummaryDetailNotifier extends StateNotifier<CreditResponseState> {
// //  List<CreditSpendYearlyDetail>
//
//   CreditSummaryDetailNotifier(
//     super.state,
//     this.client,
//     this.utility,
//     this.summaryList,
//   );
//
//   final HttpClient client;
//   final Utility utility;
//   final List<CreditSummary> summaryList;
//
//   Future<void> getCreditSummaryDetail({required DateTime date}) async {
//     final month = date.mm;
//
//     final list = <CreditSpendYearlyDetail>[];
//
//     for (var i = 0; i < summaryList.length; i++) {
//       for (var j = 0; j < summaryList[i].list.length; j++) {
//         if (month == summaryList[i].list[j].month) {
//           if (summaryList[i].list[j].price > 0) {
//             list.add(
//               CreditSpendYearlyDetail(
//                 item: summaryList[i].item,
//                 month: summaryList[i].list[j].month,
//                 price: summaryList[i].list[j].price,
//               ),
//             );
//           }
//         }
//       }
//     }
//
//     state = state.copyWith(creditSpendYearlyDetailList: AsyncValue.data(list));
//   }
// }
//
// //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
//
//
//
//

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

final creditUdemyProvider =
    StateNotifierProvider.autoDispose.family<CreditUdemyNotifier, CreditResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  // final creditSpendMonthlyState = ref.watch(creditSpendMonthlyProvider(date));
  //
  //
  //
  //

  final creditSpendMonthlyList =
      ref.watch(creditSpendMonthlyProvider(date).select((value) => value.creditSpendMonthlyList));

  final spendMonthlyList =
      (creditSpendMonthlyList.value != null) ? creditSpendMonthlyList.value! : <CreditSpendMonthly>[];

  return CreditUdemyNotifier(const CreditResponseState(), client, utility, spendMonthlyList)
    ..getCreditUdemy(date: date);
});

class CreditUdemyNotifier extends StateNotifier<CreditResponseState> {
//  List<CreditSpendMonthly>

  CreditUdemyNotifier(super.state, this.client, this.utility, this.spendMonthlyList);

  final HttpClient client;
  final Utility utility;
  final List<CreditSpendMonthly> spendMonthlyList;

  Future<void> getCreditUdemy({required DateTime date}) async {
    final reg = RegExp('UDEMY');

    final list = <CreditSpendMonthly>[];
    for (var i = 0; i < spendMonthlyList.length; i++) {
      final match = reg.firstMatch(spendMonthlyList[i].item);

      if (match != null) {
        list.add(spendMonthlyList[i]);
      }
    }

//    state = list;

    state = state.copyWith(creditSpendMonthlyList: AsyncValue.data(list));
  }
}

//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
