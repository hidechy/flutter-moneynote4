import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
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
}

////////////////////////////////////////////////
