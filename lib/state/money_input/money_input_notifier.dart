import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../utility/utility.dart';
import 'money_input_state.dart';

////////////////////////////////////////////////
final moneyInputProvider =
    StateNotifierProvider.autoDispose<MoneyInputNotifier, MoneyInputState>(
        (ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return MoneyInputNotifier(const MoneyInputState(), client, utility);
});

class MoneyInputNotifier extends StateNotifier<MoneyInputState> {
  MoneyInputNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> setDate({required String date}) async =>
      state = state.copyWith(date: date);

  Future<void> setYen10000({required String yen10000}) async =>
      state = state.copyWith(yen10000: yen10000);

  Future<void> setYen5000({required String yen5000}) async =>
      state = state.copyWith(yen5000: yen5000);

  Future<void> setYen2000({required String yen2000}) async =>
      state = state.copyWith(yen2000: yen2000);

  Future<void> setYen1000({required String yen1000}) async =>
      state = state.copyWith(yen1000: yen1000);

  Future<void> setYen500({required String yen500}) async =>
      state = state.copyWith(yen500: yen500);

  Future<void> setYen100({required String yen100}) async =>
      state = state.copyWith(yen100: yen100);

  Future<void> setYen50({required String yen50}) async =>
      state = state.copyWith(yen50: yen50);

  Future<void> setYen10({required String yen10}) async =>
      state = state.copyWith(yen10: yen10);

  Future<void> setYen5({required String yen5}) async =>
      state = state.copyWith(yen5: yen5);

  Future<void> setYen1({required String yen1}) async =>
      state = state.copyWith(yen1: yen1);

  Future<void> setBankA({required String bankA}) async =>
      state = state.copyWith(bankA: bankA);

  Future<void> setBankB({required String bankB}) async =>
      state = state.copyWith(bankB: bankB);

  Future<void> setBankC({required String bankC}) async =>
      state = state.copyWith(bankC: bankC);

  Future<void> setBankD({required String bankD}) async =>
      state = state.copyWith(bankD: bankD);

  Future<void> setBankE({required String bankE}) async =>
      state = state.copyWith(bankE: bankE);

  Future<void> setPayA({required String payA}) async =>
      state = state.copyWith(payA: payA);

  Future<void> setPayB({required String payB}) async =>
      state = state.copyWith(payB: payB);

  Future<void> setPayC({required String payC}) async =>
      state = state.copyWith(payC: payC);

  Future<void> setPayD({required String payD}) async =>
      state = state.copyWith(payD: payD);

  Future<void> setPayE({required String payE}) async =>
      state = state.copyWith(payE: payE);

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
