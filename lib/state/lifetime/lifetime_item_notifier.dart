import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/lifetime_item.dart';
import '../../utility/utility.dart';
import 'lifetime_item_response_state.dart';

////////////////////////////////////////////////

final lifetimeItemProvider = StateNotifierProvider.autoDispose<LifetimeItemNotifier, LifetimeItemResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return LifetimeItemNotifier(const LifetimeItemResponseState(), client, utility)..getLifetimeItem();
});

class LifetimeItemNotifier extends StateNotifier<LifetimeItemResponseState> {
  LifetimeItemNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  ///
  Future<void> getLifetimeItem() async {
    await client.post(path: APIPath.getLifetimeRecordItem).then((value) {
      final list = <LifetimeItem>[];
      final list2 = <String>[];

      // ignore: avoid_dynamic_calls
      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        // ignore: avoid_dynamic_calls
        final val = LifetimeItem.fromJson(value['data'][i] as Map<String, dynamic>);
        list.add(val);
        list2.add(val.item);
      }

      state = state.copyWith(lifetimeItemList: list, lifetimeItemStringList: list2);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }

  ///
  Future<void> setSelectedItem({required String item}) async => state = state.copyWith(selectedItem: item);
}

////////////////////////////////////////////////
