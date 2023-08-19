// ignore_for_file: avoid_dynamic_calls, cascade_invocations

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/state/shintaku/shintaku_response_state.dart';

import '../../data/http/client.dart';
import '../../data/http/path.dart';
import '../../extensions/extensions.dart';
import '../../models/assets_data.dart';
import '../../models/shintaku.dart';
import '../../models/shintaku_record.dart';
import '../../utility/utility.dart';

/*
shintakuProvider        Shintaku
shintakuRecordProvider        ShintakuRecord
*/

////////////////////////////////////////////////
final shintakuProvider =
    StateNotifierProvider.autoDispose.family<ShintakuNotifier, ShintakuResponseState, DateTime>((ref, date) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return ShintakuNotifier(
    const ShintakuResponseState(),
    client,
    utility,
  )..getShintaku(date: date);
});

class ShintakuNotifier extends StateNotifier<ShintakuResponseState> {
  ShintakuNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getShintaku({required DateTime date}) async {
    await client.post(
      path: APIPath.getDataShintaku,
      body: {'date': date.yyyymmdd},
    ).then((value) {
      final list = <ShintakuRecord>[];

      for (var i = 0; i < value['data']['record'].length.toString().toInt(); i++) {
        final dt = DateTime(
          value['data']['record'][i]['date'].toString().split('-')[0].toInt(),
          value['data']['record'][i]['date'].toString().split('-')[1].toInt(),
          value['data']['record'][i]['date'].toString().split('-')[2].toInt(),
        );

        list.add(
          ShintakuRecord(
            name: value['data']['record'][i]['name'].toString(),
            date: dt,
            num: value['data']['record'][i]['num'].toString(),
            shutoku: value['data']['record'][i]['shutoku'].toString(),
            cost: value['data']['record'][i]['cost'].toString(),
            price: value['data']['record'][i]['price'].toString(),
            diff: value['data']['record'][i]['diff'].toString().toInt(),
            data: value['data']['record'][i]['data'].toString(),
          ),
        );
      }

      /////////////////////////////////////////

      final shintakuMap = <String, AssetsData>{};

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

        shintakuMap[element.key] = AssetsData(
          cost: sumCost,
          price: sumPrice,
          diff: sumDiff,
          percent: percent,
        );
      });
      /////////////////////////////////////////

      var lastDate = '';
      var lastCost = 0;
      var lastPrice = 0;
      var lastDiff = 0;

      shintakuMap.entries.forEach((element) {
        lastDate = element.key;
        lastCost = element.value.cost;
        lastPrice = element.value.price;
        lastDiff = element.value.diff;
      });

      final shintaku = Shintaku(
        cost: lastCost,
        price: lastPrice,
        diff: lastDiff,
        date: '$lastDate 00:00:00'.toDateTime(),
        record: list,
      );

      state = state.copyWith(lastShintaku: shintaku, shintakuMap: shintakuMap);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final shintakuRecordProvider = StateNotifierProvider.autoDispose<ShintakuRecordNotifier, ShintakuResponseState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return ShintakuRecordNotifier(
    const ShintakuResponseState(),
    client,
    utility,
  )..getShintakuRecord(flag: 0);
});

class ShintakuRecordNotifier extends StateNotifier<ShintakuResponseState> {
  ShintakuRecordNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getShintakuRecord({required int flag}) async {
    await client.post(path: APIPath.getDataShintaku).then((value) {
      var shintakuRecord = ShintakuRecord(
        name: '',
        date: DateTime.now(),
        num: '',
        shutoku: '',
        cost: '',
        price: '',
        diff: 0,
        data: '',
      );

      for (var i = 0; i < value['data']['record'].length.toString().toInt(); i++) {
        if (i == flag) {
          shintakuRecord = ShintakuRecord(
            name: value['data']['record'][i]['name'].toString(),
            date: DateTime(
              value['data']['record'][i]['date'].toString().split('-')[0].toInt(),
              value['data']['record'][i]['date'].toString().split('-')[1].toInt(),
              value['data']['record'][i]['date'].toString().split('-')[2].toInt(),
            ),
            num: value['data']['record'][i]['num'].toString(),
            shutoku: value['data']['record'][i]['shutoku'].toString(),
            cost: value['data']['record'][i]['cost'].toString(),
            price: value['data']['record'][i]['price'].toString(),
            diff: value['data']['record'][i]['diff'].toString().toInt(),
            data: value['data']['record'][i]['data'].toString(),
          );
        }
      }

      state = state.copyWith(lastShintakuRecord: shintakuRecord);
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
