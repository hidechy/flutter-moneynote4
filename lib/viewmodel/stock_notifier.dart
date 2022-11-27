// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';

import '../data/http/client.dart';
import '../models/stock.dart';
import '../models/stock_record.dart';

////////////////////////////////////////////////
final stockProvider =
    StateNotifierProvider.autoDispose<StockNotifier, Stock>((ref) {
  final client = ref.read(httpClientProvider);

  return StockNotifier(
    Stock(
      cost: 0,
      price: 0,
      diff: 0,
      date: DateTime.now(),
      record: [],
    ),
    client,
  )..getStock();
});

class StockNotifier extends StateNotifier<Stock> {
  StockNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getStock() async {
    await client.post(path: 'getDataStock').then((value) {
      final list = <StockRecord>[];
      for (var i = 0;
          i < value['data']['record'].length.toString().toInt();
          i++) {
        list.add(
          StockRecord(
            name: value['data']['record'][i]['name'].toString(),
            date: DateTime.parse(value['data']['record'][i]['date'].toString()),
            num: int.parse(value['data']['record'][i]['num'].toString()),
            oneStock: value['data']['record'][i]['oneStock'].toString(),
            cost: int.parse(value['data']['record'][i]['cost'].toString()),
            price: value['data']['record'][i]['price'].toString(),
            diff: int.parse(value['data']['record'][i]['diff'].toString()),
            data: value['data']['record'][i]['data'].toString(),
          ),
        );
      }

      final stock = Stock(
        cost: int.parse(value['data']['cost'].toString()),
        price: int.parse(value['data']['price'].toString()),
        diff: int.parse(value['data']['diff'].toString()),
        date: DateTime.parse(value['data']['date'].toString()),
        record: list,
      );

      state = stock;
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////
final stockRecordProvider =
    StateNotifierProvider.autoDispose<StockRecordNotifier, StockRecord>((ref) {
  final client = ref.read(httpClientProvider);

  return StockRecordNotifier(
    StockRecord(
      name: '',
      date: DateTime.now(),
      num: 0,
      oneStock: '',
      cost: 0,
      price: '',
      diff: 0,
      data: '',
    ),
    client,
  )..getStockRecord(flag: 0);
});

class StockRecordNotifier extends StateNotifier<StockRecord> {
  StockRecordNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getStockRecord({required int flag}) async {
    await client.post(path: 'getDataStock').then((value) {
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

      for (var i = 0;
          i < value['data']['record'].length.toString().toInt();
          i++) {
        if (i == flag) {
          stockRecord = StockRecord(
            name: value['data']['record'][i]['name'].toString(),
            date: DateTime.parse(value['data']['record'][i]['date'].toString()),
            num: int.parse(value['data']['record'][i]['num'].toString()),
            oneStock: value['data']['record'][i]['oneStock'].toString(),
            cost: int.parse(value['data']['record'][i]['cost'].toString()),
            price: value['data']['record'][i]['price'].toString(),
            diff: int.parse(value['data']['record'][i]['diff'].toString()),
            data: value['data']['record'][i]['data'].toString(),
          );
        }
      }

      state = stockRecord;
    });
  }
}

////////////////////////////////////////////////
