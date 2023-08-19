// ignore_for_file: avoid_dynamic_calls, cascade_invocations

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/assets_data.dart';
import 'package:moneynote4/state/stock/stock_response_state.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/stock.dart';
import '../../models/stock_record.dart';
import '../../utility/utility.dart';

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

      /////////////////////////////////////////

      final stockMap = <String, AssetsData>{};

      final costMap = <String, List<int>>{};
      final priceMap = <String, List<int>>{};
      final diffMap = <String, List<int>>{};

      //============ 連想配列初期化
      final exList0Data = list[0].data.split('/');
      exList0Data.forEach((element) {
        final exElement = element.split('|');

        costMap[exElement[0]] = [];
        priceMap[exElement[0]] = [];
        diffMap[exElement[0]] = [];
      });
      //============ 連想配列初期化

      list.forEach((element) {
        final exData = element.data.split('/');
        exData.forEach((element2) {
          final exData2 = element2.split('|');

          costMap[exData2[0]]?.add(exData2[3].toInt());
          priceMap[exData2[0]]?.add(exData2[4].toInt());
          diffMap[exData2[0]]?.add(exData2[5].toInt());
        });
      });

      costMap.entries.forEach((element) {
        var sumCost = 0;
        costMap[element.key]?.forEach((element2) {
          sumCost += element2;
        });

        var sumPrice = 0;
        priceMap[element.key]?.forEach((element2) {
          sumPrice += element2;
        });

        var sumDiff = 0;
        diffMap[element.key]?.forEach((element2) {
          sumDiff += element2;
        });

        final percent =
            (sumPrice > 0 && sumCost > 0) ? ((sumPrice / sumCost) * 100).round().toString().split('.')[0].toInt() : 0;

        stockMap[element.key] = AssetsData(
          cost: sumCost,
          price: sumPrice,
          diff: sumDiff,
          percent: percent,
        );
      });
      /////////////////////////////////////////

      state = state.copyWith(lastStock: stock, stockMap: stockMap);
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
