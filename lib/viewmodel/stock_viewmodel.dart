// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../models/stock.dart';
import '../models/stock_record.dart';

////////////////////////////////////////////////

final stockListProvider =
    StateNotifierProvider.autoDispose<StockListNotifier, Stock>((ref) {
  final client = ref.read(httpClientProvider);

  return StockListNotifier(
    Stock(
      cost: 0,
      price: 0,
      diff: 0,
      date: DateTime.now(),
      record: [],
    ),
    client,
  )..getStockList();
});

class StockListNotifier extends StateNotifier<Stock> {
  StockListNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getStockList() async {
    await client.post(path: 'getDataStock').then((value) {
      final list = <StockRecord>[];
      for (var i = 0;
          i < int.parse(value['data']['record'].length.toString());
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
