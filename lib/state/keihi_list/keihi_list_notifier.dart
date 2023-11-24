// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/keihi.dart';
import '../../models/tax_payment_item.dart';
import '../../utility/utility.dart';
import 'keihi_list_response_state.dart';

////////////////////////////////////////////////

final keihiListProvider =
    StateNotifierProvider.autoDispose.family<KeihiListNotifier, KeihiListResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return KeihiListNotifier(const KeihiListResponseState(), client, utility)..getKeihiList(date: date);
});

class KeihiListNotifier extends StateNotifier<KeihiListResponseState> {
  KeihiListNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getKeihiList({required DateTime date}) async {
    await client.post(path: APIPath.selectSpendCheckItem, body: {'date': date.yyyymmdd}).then((value) {
      final list = <Keihi>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        list.add(Keihi.fromJson(value['data'][i] as Map<String, dynamic>));
      }

      // state = list;
      //
      //
      //
      //

      state = state.copyWith(keihiList: AsyncValue.data(list));
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final taxPaymentItemProvider =
    StateNotifierProvider.autoDispose.family<TaxPaymentItemNotifier, KeihiListResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return TaxPaymentItemNotifier(const KeihiListResponseState(), client, utility)..getTaxPaymentItem(date: date);
});

class TaxPaymentItemNotifier extends StateNotifier<KeihiListResponseState> {
  TaxPaymentItemNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getTaxPaymentItem({required DateTime date}) async {
    await client.post(
      path: APIPath.getTaxPaymentItem,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      // state = TaxPaymentItem.fromJson(value['data'] as Map<String, dynamic>);
      //
      //
      //
      //

      state = state.copyWith(taxPaymentItem: TaxPaymentItem.fromJson(value['data'] as Map<String, dynamic>));
    });
  }
}

////////////////////////////////////////////////
