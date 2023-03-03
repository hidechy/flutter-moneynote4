import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../utility/utility.dart';

import 'bank_input_state.dart';

////////////////////////////////////////////////
final bankInputProvider =
    StateNotifierProvider.autoDispose<BankInputNotifier, BankInputState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return BankInputNotifier(const BankInputState(), client, utility);
});

class BankInputNotifier extends StateNotifier<BankInputState> {
  BankInputNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> setBankMoney({required String bankMoney}) async =>
      state = state.copyWith(bankMoney: bankMoney);

  ///

  Future<void> setSelectDate({required String selectDate}) async =>
      state = state.copyWith(selectDate: selectDate);

  Future<void> setInArrowDate({required String inArrowDate}) async =>
      state = state.copyWith(inArrowDate: inArrowDate);

  Future<void> setOutArrowDate({required String outArrowDate}) async =>
      state = state.copyWith(outArrowDate: outArrowDate);

  ///
  Future<void> onTapSelectBank({required String selectBank}) async {
    state = state.copyWith(
      selectBank: selectBank,
      inArrowBank: '',
      inArrowDate: '',
      outArrowBank: '',
      outArrowDate: '',
      selectInOutFlag: 0,
    );
  }

  ///
  Future<void> onTapInArrowBank({required String inArrowBank}) async {
    state = state.copyWith(
      inArrowBank: inArrowBank,
      selectBank: '',
      selectDate: '',
      selectInOutFlag: 1,
    );
  }

  ///
  Future<void> onTapOutArrowBank({required String outArrowBank}) async {
    state = state.copyWith(
      outArrowBank: outArrowBank,
      selectBank: '',
      selectDate: '',
      selectInOutFlag: 1,
    );
  }

  ///
  Future<void> updateBankMoney(
      {required Map<String, dynamic> uploadData}) async {
    await client
        .post(path: APIPath.updateBankMoney, body: uploadData)
        .then((value) {})
        .catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }

  ///
  Future<void> setBankMove({required Map<String, dynamic> uploadData}) async {
    await client
        .post(path: APIPath.setBankMove, body: uploadData)
        .then((value) {})
        .catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }

  ///
  Future<void> onTapSubmit() async {
    state = state.copyWith(
      bankMoney: '',
      selectBank: '',
      selectDate: '',
      selectInOutFlag: 0,
      outArrowBank: '',
      outArrowDate: '',
      inArrowBank: '',
      inArrowDate: '',
    );
  }
}
