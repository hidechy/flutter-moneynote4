// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/http/client.dart';
import '../models/shintaku.dart';

import '../models/shintaku_record.dart';

////////////////////////////////////////////////
final shintakuProvider =
    StateNotifierProvider.autoDispose<ShintakuNotifier, Shintaku>((ref) {
  final client = ref.read(httpClientProvider);

  return ShintakuNotifier(
    Shintaku(
      cost: 0,
      price: 0,
      diff: 0,
      date: DateTime.now(),
      record: [],
    ),
    client,
  )..getShintaku();
});

class ShintakuNotifier extends StateNotifier<Shintaku> {
  ShintakuNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getShintaku() async {
    await client.post(path: 'getDataShintaku').then((value) {
      final list = <ShintakuRecord>[];

      for (var i = 0;
          i < int.parse(value['data']['record'].length.toString());
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
    });
  }
}

////////////////////////////////////////////////
