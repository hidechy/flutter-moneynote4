// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../data/http/client.dart';
import '../data/http/path.dart';
import '../models/credit_company.dart';
import '../models/credit_spend_monthly.dart';
import '../models/credit_summary.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////

final creditSpendMonthlyProvider = StateNotifierProvider.autoDispose
    .family<CreditSpendMonthlyNotifier, List<CreditSpendMonthly>, DateTime>(
        (ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return CreditSpendMonthlyNotifier([], client, utility)
    ..getCreditSpendMonthly(date: date, kind: '');
});

class CreditSpendMonthlyNotifier
    extends StateNotifier<List<CreditSpendMonthly>> {
  CreditSpendMonthlyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getCreditSpendMonthly(
      {required DateTime date, required String kind}) async {
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

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final creditSummaryProvider = StateNotifierProvider.autoDispose
    .family<CreditSummaryNotifier, List<CreditSummary>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return CreditSummaryNotifier([], client, utility)
    ..getCreditSummary(date: date);
});

class CreditSummaryNotifier extends StateNotifier<List<CreditSummary>> {
  CreditSummaryNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getCreditSummary({required DateTime date}) async {
    final year = date.yyyy;

    await client.post(
      path: APIPath.getYearCreditSummarySummary,
      body: {'year': year},
    ).then((value) {
      final list = <CreditSummary>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(
          // CreditSummary(
          //   item: value['data'][i]['item'].toString(),
          //   list: list2,
          // ),

          CreditSummary.fromJson(value['data'][i] as Map<String, dynamic>),
        );

        /*



        final list2 = <CreditSummaryRecord>[];
        for (var j = 0;
            j < value['data'][i]['list'].length.toString().toInt();
            j++) {
          list2.add(
            // CreditSummaryRecord(
            //   month: value['data'][i]['list'][j]['month'].toString(),
            //   price: value['data'][i]['list'][j]['price'].toString().toInt(),
            // ),

            CreditSummaryRecord.fromJson(
                value['data'][i] as Map<String, dynamic>),
          );
        }

        list.add(
          CreditSummary(
            item: value['data'][i]['item'].toString(),
            list: list2,
          ),
        );



        */

      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

final creditCompanyProvider = StateNotifierProvider.autoDispose
    .family<CreditCompanyNotifier, List<CreditCompany>, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return CreditCompanyNotifier([], client, utility)
    ..getCreditCompany(date: date);
});

class CreditCompanyNotifier extends StateNotifier<List<CreditCompany>> {
  CreditCompanyNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getCreditCompany({required DateTime date}) async {
    await client.post(
      path: APIPath.getcompanycredit,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <CreditCompany>[];

      var keepYm = '';
      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        //
        // final list2 = <CreditCompanyRecord>[];
        //

        for (var j = 0;
            j < value['data'][i]['list'].length.toString().toInt();
            j++) {
          if (keepYm != value['data'][i]['ym'].toString()) {
            list.add(
              // CreditCompany(
              //   ym: value['data'][i]['ym'].toString(),
              //   list: list2,
              // ),

              CreditCompany.fromJson(value['data'][i] as Map<String, dynamic>),
            );
          }

          keepYm = value['data'][i]['ym'].toString();

          /*



          list2.add(
            CreditCompanyRecord(
              company: value['data'][i]['list'][j]['company'].toString(),
              sum: value['data'][i]['list'][j]['sum'].toString().toInt(),
            ),
          );

          if (keepYm != value['data'][i]['ym'].toString()) {
            list.add(
              CreditCompany(
                ym: value['data'][i]['ym'].toString(),
                list: list2,
              ),
            );
          }

          keepYm = value['data'][i]['ym'].toString();



          */

        }
      }

      state = list;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

final selectCreditProvider =
    StateNotifierProvider.autoDispose<SelectCreditStateNotifier, String>((ref) {
  return SelectCreditStateNotifier();
});

class SelectCreditStateNotifier extends StateNotifier<String> {
  SelectCreditStateNotifier() : super('');

  ///
  Future<void> setSelectCredit({required String selectCredit}) async {
    state = selectCredit;
  }
}
