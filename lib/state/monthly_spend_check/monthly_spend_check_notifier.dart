import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../utility/utility.dart';
import 'monthly_spend_check_state.dart';

////////////////////////////////////////////////
final monthlySpendCheckProvider = StateNotifierProvider.autoDispose<
    MonthlySpendCheckNotifier, MonthlySpendCheckState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return MonthlySpendCheckNotifier(
    const MonthlySpendCheckState(selectItem: []),
    client,
    utility,
  );
});

class MonthlySpendCheckNotifier extends StateNotifier<MonthlySpendCheckState> {
  MonthlySpendCheckNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> setSelectItem({required String item}) async {
    final items = [...state.selectItem];
    if (items.contains(item)) {
      items.remove(item);
    } else {
      items.add(item);
    }
    state = state.copyWith(selectItem: items);
  }

  ///
  Future<void> inputCheckItem({required DateTime date}) async {
    final items = [...state.selectItem];

    final uploadData = <String, dynamic>{};
    uploadData['date'] = date.yyyymmdd;
    uploadData['items'] = items;

    print(uploadData);

    // await client
    //     .post(path: APIPath.inputSpendCheckItem, body: uploadData)
    //     .then((value) {})
    //     .catchError((error, _) {
    //   utility.showError('予期せぬエラーが発生しました');
    // });
  }
}

////////////////////////////////////////////////
