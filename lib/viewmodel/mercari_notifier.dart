// ignore_for_file: avoid_dynamic_calls

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/models/mercari_record.dart';

import '../data/http/client.dart';
import '../extensions/extensions.dart';

////////////////////////////////////////////////
final mercariProvider =
    StateNotifierProvider.autoDispose<MercariNotifier, List<MercariRecord>>(
        (ref) {
  final client = ref.read(httpClientProvider);

  return MercariNotifier([], client)..getMercariData();
});

class MercariNotifier extends StateNotifier<List<MercariRecord>> {
  MercariNotifier(super.state, this.client);

  final HttpClient client;

  Future<void> getMercariData() async {
    await client.post(path: 'mercaridata').then((value) {
      final list = <MercariRecord>[];

      for (var i = 0; i < value['data'].length.toString().toInt(); i++) {
        final exRecord = value['data'][i]['record'].toString().split('/');

        for (var j = 0; j < exRecord.length; j++) {
          final exData = exRecord[j].split('|');

          list.add(
            MercariRecord(
              date: '${value['data'][i]['date']} 00:00:00'.toDateTime(),
              buySell: exData[0],
              title: exData[1],
              cellPrice: exData[2].toInt(),
              tesuuryou: exData[3].toInt(),
              shippingFee: exData[4].toInt(),
              price: exData[5].toInt(),
              settlement: '${exData[7]}:00:00'.toDateTime(),
              departure:
                  (exData[6] != '') ? '${exData[6]}:00:00'.toDateTime() : null,
              receive:
                  (exData[8] != '') ? '${exData[8]}:00:00'.toDateTime() : null,
            ),
          );
        }
      }

      state = list;
    });
  }
}

////////////////////////////////////////////////
