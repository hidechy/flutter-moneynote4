import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';

////////////////////////////////////////////////

final onedayInputProvider =
    StateNotifierProvider.autoDispose<OnedayInputNotifier, int>((ref) {
  final client = ref.read(httpClientProvider);

  return OnedayInputNotifier(0, client);
});

class OnedayInputNotifier extends StateNotifier<int> {
  OnedayInputNotifier(super.state, this.client);

  final HttpClient client;

  ///
  Future<void> insertMoney({required Map<String, dynamic> uploadData}) async {
    await client.post(path: 'moneyinsert', body: uploadData).then((value) {
      state = 1;
    });
  }
}

////////////////////////////////////////////////
