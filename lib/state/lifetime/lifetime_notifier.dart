import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/lifetime.dart';
import '../../utility/utility.dart';
import 'lifetime_response_state.dart';

////////////////////////////////////////////////

final lifetimeProvider =
    StateNotifierProvider.autoDispose.family<LifetimeNotifier, LifetimeResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return LifetimeNotifier(const LifetimeResponseState(), client, utility)..getLifetime(date: date);
});

class LifetimeNotifier extends StateNotifier<LifetimeResponseState> {
  LifetimeNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getLifetime({required DateTime date}) async {
    await client.post(
      path: APIPath.getLifetimeDateRecord,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      // ignore: avoid_dynamic_calls
      if (value['data'] != null) {
        // ignore: avoid_dynamic_calls
        final lifetime = Lifetime.fromJson(value['data'] as Map<String, dynamic>);

        state = state.copyWith(lifetime: lifetime);
      }
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
