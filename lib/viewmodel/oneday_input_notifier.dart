import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';

import '../data/http/path.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////

final onedayInputProvider =
    StateNotifierProvider.autoDispose<OnedayInputNotifier, int>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return OnedayInputNotifier(0, client, utility);
});

class OnedayInputNotifier extends StateNotifier<int> {
  OnedayInputNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> insertMoney({required Map<String, dynamic> uploadData}) async {
    await client
        .post(path: APIPath.moneyinsert, body: uploadData)
        .then((value) {
      state = 1;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
