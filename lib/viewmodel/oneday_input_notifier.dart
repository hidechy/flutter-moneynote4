// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import '../data/http/client.dart';
//
// import '../data/http/path.dart';
// import '../utility/utility.dart';
//
// ////////////////////////////////////////////////
// final onedayInputProvider =
//     StateNotifierProvider.autoDispose<OnedayInputNotifier, int>((ref) {
//   final client = ref.read(httpClientProvider);
//
//   final utility = Utility();
//
//   return OnedayInputNotifier(0, client, utility);
// });
//
// class OnedayInputNotifier extends StateNotifier<int> {
//   OnedayInputNotifier(super.state, this.client, this.utility);
//
//   final HttpClient client;
//   final Utility utility;
//
//   ///
//   Future<void> insertMoney({required Map<String, dynamic> uploadData}) async {
//     await client
//         .post(path: APIPath.moneyinsert, body: uploadData)
//         .then((value) {
//       state = 1;
//     }).catchError((error, _) {
//       utility.showError('予期せぬエラーが発生しました');
//     });
//   }
// }
//
// ////////////////////////////////////////////////

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../state/money_input_state.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////
final moneyInputProvider =
    StateNotifierProvider.autoDispose<MoneyInputNotifier, MoneyInputState>(
        (ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return MoneyInputNotifier(
      const MoneyInputState(
        date: '',
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
      ),
      client,
      utility);
});

class MoneyInputNotifier extends StateNotifier<MoneyInputState> {
  MoneyInputNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  void setDate({required String date}) => state = state.copyWith(date: date);

  void setYen10000({required String yen10000}) =>
      state = state.copyWith(yen10000: yen10000);

  void setYen5000({required String yen5000}) =>
      state = state.copyWith(yen5000: yen5000);

  void setYen2000({required String yen2000}) =>
      state = state.copyWith(yen2000: yen2000);

  void setYen1000({required String yen1000}) =>
      state = state.copyWith(yen1000: yen1000);

  void setYen500({required String yen500}) =>
      state = state.copyWith(yen500: yen500);

  void setYen100({required String yen100}) =>
      state = state.copyWith(yen100: yen100);

  void setYen50({required String yen50}) =>
      state = state.copyWith(yen50: yen50);

  void setYen10({required String yen10}) =>
      state = state.copyWith(yen10: yen10);

  void setYen5({required String yen5}) => state = state.copyWith(yen5: yen5);

  void setYen1({required String yen1}) => state = state.copyWith(yen1: yen1);

  void setBankA({required String bankA}) =>
      state = state.copyWith(bankA: bankA);

  void setBankB({required String bankB}) =>
      state = state.copyWith(bankB: bankB);

  void setBankC({required String bankC}) =>
      state = state.copyWith(bankC: bankC);

  void setBankD({required String bankD}) =>
      state = state.copyWith(bankD: bankD);

  void setBankE({required String bankE}) =>
      state = state.copyWith(bankE: bankE);

  void setPayA({required String payA}) => state = state.copyWith(payA: payA);

  void setPayB({required String payB}) => state = state.copyWith(payB: payB);

  void setPayC({required String payC}) => state = state.copyWith(payC: payC);

  void setPayD({required String payD}) => state = state.copyWith(payD: payD);

  void setPayE({required String payE}) => state = state.copyWith(payE: payE);

  ///
  Future<void> insertMoney({required Map<String, dynamic> uploadData}) async {
    await client
        .post(path: APIPath.moneyinsert, body: uploadData)
        .then((value) {})
        .catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
