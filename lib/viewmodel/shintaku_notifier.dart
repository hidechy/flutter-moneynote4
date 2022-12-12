// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../data/http/path.dart';
import '../extensions/extensions.dart';
import '../models/shintaku.dart';
import '../models/shintaku_record.dart';
import '../utility/utility.dart';

////////////////////////////////////////////////
final shintakuProvider =
    StateNotifierProvider.autoDispose<ShintakuNotifier, Shintaku>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return ShintakuNotifier(
    Shintaku(
      cost: 0,
      price: 0,
      diff: 0,
      date: DateTime.now(),
      record: [],
    ),
    client,
    utility,
  )..getShintaku();
});

class ShintakuNotifier extends StateNotifier<Shintaku> {
  ShintakuNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> getShintaku() async {
    await client.post(path: APIPath.getDataShintaku).then((value) {
      final list = <ShintakuRecord>[];

      for (var i = 0;
          i < value['data']['record'].length.toString().toInt();
          i++) {
        list.add(
          ShintakuRecord(
            name: value['data']['record'][i]['name'].toString(),
            date: DateTime.parse(value['data']['record'][i]['date'].toString()),
            num: value['data']['record'][i]['num'].toString(),
            shutoku: value['data']['record'][i]['shutoku'].toString(),
            cost: value['data']['record'][i]['cost'].toString(),
            price: value['data']['record'][i]['price'].toString(),
            diff: int.parse(value['data']['record'][i]['diff'].toString()),
            data: value['data']['record'][i]['data'].toString(),
          ),
        );
      }

      final shintaku = Shintaku(
        cost: int.parse(value['data']['cost'].toString()),
        price: int.parse(value['data']['price'].toString()),
        diff: int.parse(value['data']['diff'].toString()),
        date: DateTime.parse(value['data']['date'].toString()),
        record: list,
      );

      state = shintaku;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////

////////////////////////////////////////////////

final shintakuRecordProvider =
    StateNotifierProvider.autoDispose<ShintakuRecordNotifier, ShintakuRecord>(
        (ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  return ShintakuRecordNotifier(
    ShintakuRecord(
      name: '',
      date: DateTime.now(),
      num: '',
      shutoku: '',
      cost: '',
      price: '',
      diff: 0,
      data: '',
    ),
    client,
    utility,
  )..getShintakuRecord(flag: 0);
});

class ShintakuRecordNotifier extends StateNotifier<ShintakuRecord> {
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

      for (var i = 0;
          i < value['data']['record'].length.toString().toInt();
          i++) {
        if (i == flag) {
          shintakuRecord = ShintakuRecord(
            name: value['data']['record'][i]['name'].toString(),
            date: '${value['data']['record'][i]['date']} 00:00:00'.toDateTime(),
            num: value['data']['record'][i]['num'].toString(),
            shutoku: value['data']['record'][i]['shutoku'].toString(),
            cost: value['data']['record'][i]['cost'].toString(),
            price: value['data']['record'][i]['price'].toString(),
            diff: value['data']['record'][i]['diff'].toString().toInt(),
            data: value['data']['record'][i]['data'].toString(),
          );
        }
      }

      state = shintakuRecord;
    }).catchError((error, _) {
      utility.showError('予期せぬエラーが発生しました');
    });
  }
}

////////////////////////////////////////////////
