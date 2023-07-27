// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/state/stock/stock_response_state.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/stock.dart';
import '../models/stock_record.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////
final stockProvider =
    StateNotifierProvider.autoDispose.family<StockNotifier, StockResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return StockNotifier(
    const StockResponseState(),
    client,
    utility,
  )..getStock(date: date);
});

class StockNotifier extends StateNotifier<StockResponseState> {
  StockNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getStock({required DateTime date}) async {
    await client.post(
      path: APIPath.getDataStock,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <StockRecord>[];
      for (var i = 0; i < value['data']['record'].length.toString().toInt(); i++) {
        list.add(
          StockRecord(
            name: value['data']['record'][i]['name'].toString(),
            date: DateTime.parse(value['data']['record'][i]['date'].toString()),
            num: value['data']['record'][i]['num'].toString().toInt(),
            oneStock: value['data']['record'][i]['oneStock'].toString(),
            cost: value['data']['record'][i]['cost'].toString().toInt(),
            price: value['data']['record'][i]['price'].toString(),
            diff: value['data']['record'][i]['diff'].toString().toInt(),
            data: value['data']['record'][i]['data'].toString(),
          ),
        );
      }

      final stock = Stock(
        cost: value['data']['cost'].toString().toInt(),
        price: value['data']['price'].toString().toInt(),
        diff: value['data']['diff'].toString().toInt(),
        date: DateTime.parse(value['data']['date'].toString()),
        record: list,
      );

      state = state.copyWith(lastStock: stock);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final stockRecordProvider = StateNotifierProvider.autoDispose<StockRecordNotifier, StockResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return StockRecordNotifier(
    const StockResponseState(),
    client,
    utility,
  )..getStockRecord(flag: 0);
});

class StockRecordNotifier extends StateNotifier<StockResponseState> {
  StockRecordNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getStockRecord({required int flag}) async {
    await client.post(path: APIPath.getDataStock).then((value) {
      var stockRecord = StockRecord(
        name: '',
        date: DateTime.now(),
        num: 0,
        oneStock: '',
        cost: 0,
        price: '',
        diff: 0,
        data: '',
      );

      for (var i = 0; i < value['data']['record'].length.toString().toInt(); i++) {
        if (i == flag) {
          stockRecord = StockRecord(
            name: value['data']['record'][i]['name'].toString(),
            date: DateTime(
              value['data']['record'][i]['date'].toString().split('-')[0].toInt(),
              value['data']['record'][i]['date'].toString().split('-')[1].toInt(),
              value['data']['record'][i]['date'].toString().split('-')[2].toInt(),
            ),
            num: value['data']['record'][i]['num'].toString().toInt(),
            oneStock: value['data']['record'][i]['oneStock'].toString(),
            cost: value['data']['record'][i]['cost'].toString().toInt(),
            price: value['data']['record'][i]['price'].toString(),
            diff: value['data']['record'][i]['diff'].toString().toInt(),
            data: value['data']['record'][i]['data'].toString(),
          );
        }
      }

      state = state.copyWith(lastStockRecord: stockRecord);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
