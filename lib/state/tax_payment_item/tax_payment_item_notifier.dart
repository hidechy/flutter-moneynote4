// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../utility/utility.dart';
import '../app_param/app_param_notifier.dart';
import 'tax_payment_item_state.dart';

////////////////////////////////////////////////
final taxPaymentItemProvider = StateNotifierProvider.autoDispose<
    TaxPaymentItemNotifier, TaxPaymentItemState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  final TaxPaymentItemAlertSelectYear = ref.watch(
    appParamProvider.select((value) => value.TaxPaymentItemAlertSelectYear),
  );

  final list = <String>[];
  final list2 = <int>[];
  for (var i = 0; i < 20; i++) {
    list.add('');
    list2.add(0);
  }

  return TaxPaymentItemNotifier(
    TaxPaymentItemState(
      paymentItems: list,
      paymentPrices: list2,
    ),
    client,
    utility,
    TaxPaymentItemAlertSelectYear,
  );
});

class TaxPaymentItemNotifier extends StateNotifier<TaxPaymentItemState> {
  TaxPaymentItemNotifier(super.state, this.client, this.utility,
      this.taxPaymentItemAlertSelectYear);

  final HttpClient client;
  final Utility utility;
  final int taxPaymentItemAlertSelectYear;

  ///
  Future<void> setTaxPaymentItem(
      {required int number,
      required String item,
      required String price}) async {
    final paymentItems = [...state.paymentItems];
    final paymentPrices = [...state.paymentPrices];

    paymentItems[number] = item;
    paymentPrices[number] = price.toInt();

    state = state.copyWith(
      paymentItems: paymentItems,
      paymentPrices: paymentPrices,
    );
  }

  ///
  Future<void> inputTaxPaymentItem() async {
    final paymentItems = [...state.paymentItems];
    final paymentPrices = [...state.paymentPrices];

    final items = <Map<String, String>>[];
    for (var i = 0; i < paymentItems.length; i++) {
      if (paymentItems[i] != '' && paymentPrices[i] != '') {
        items.add({
          'item': paymentItems[i],
          'price': paymentPrices[i].toString(),
        });
      }
    }

    final uploadData = <String, dynamic>{};
    uploadData['date'] = DateTime(taxPaymentItemAlertSelectYear).yyyymmdd;
    uploadData['items'] = items;

    await client
        .post(path: APIPath.inputTaxPaymentItem, body: uploadData)
        .then((value) {})
        .catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
