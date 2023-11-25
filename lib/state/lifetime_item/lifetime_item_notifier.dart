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

      // 初期化
      final list3 = <String?>[];
      for (var i = 0; i <= 23; i++) {
        list3.add(null);
      }
      // 初期化

      state = state.copyWith(
        lifetimeItemList: AsyncValue.data(list),
        lifetimeItemStringList: AsyncValue.data(list2),
        lifetimeStringList: list3,
      );
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }

  ///
  Future<void> setSelectedItem({required String item}) async => state = state.copyWith(selectedItem: item);

  ///
  Future<void> setItemPos({required int pos}) async => state = state.copyWith(itemPos: pos);

  ///
  Future<void> setLifetimeStringList({required int pos, required String item}) async {
    final items = <String?>[...state.lifetimeStringList];
    items[pos] = item;
    state = state.copyWith(lifetimeStringList: items);
  }

  ///
  Future<void> inputLifetime({required DateTime date}) async {
    final items = <String?>[...state.lifetimeStringList];

    final uploadData = <String, dynamic>{};
    uploadData['date'] = date.yyyymmdd;
    uploadData['lifetime'] = items.join('|');

    await client.post(path: APIPath.insertLifetime, body: uploadData).then((value) {}).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
