import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';

import '../../data/http/client.dart';
import '../../utility/utility.dart';
import 'spend_item_input_state.dart';

////////////////////////////////////////////////
final spendItemInputProvider = StateNotifierProvider.autoDispose<
    SpendItemInputNotifier, SpendItemInputState>((ref) {
  final client = ref.read(httpClientProvider);

  final utility = Utility();

  final list = <String>[];
  for (var i = 0; i < 10; i++) {
    list.add('');
  }

  return SpendItemInputNotifier(
      SpendItemInputState(
        itemPos: 0,
        spendItem: list,
        spendPrice: list,
      ),
      client,
      utility);
});

class SpendItemInputNotifier extends StateNotifier<SpendItemInputState> {
  SpendItemInputNotifier(super.state, this.client, this.utility);

  final HttpClient client;
  final Utility utility;

  Future<void> setItemPos({required int pos}) async {
    state = state.copyWith(itemPos: pos);
  }

  Future<void> setSpendItem({required int pos, required String item}) async {
    final items = <String>[...state.spendItem];

    items[pos] = item;

    state = state.copyWith(spendItem: items);
  }

  Future<void> setSpendPrice({required int pos, required String price}) async {
    final prices = <String>[...state.spendPrice];
    prices[pos] = price;

    state = state.copyWith(spendPrice: prices);
  }

  Future<void> inputSpendItem({required DateTime date}) async {
    final list = <Map<String, dynamic>>[];
    for (var i = 0; i < 10; i++) {
      if (state.spendItem[i] != '' && state.spendPrice[i] != '') {
        list.add({'item': state.spendItem[i], 'price': state.spendPrice[i]});
      }
    }

    final uploadData = <String, dynamic>{};
    uploadData['date'] = date.yyyymmdd;
    uploadData['spend'] = list;

    print(uploadData);

    /*
flutter: SpendItemInputState(itemPos: 2, spendItem: [食費, 交際費, プラス, , , , , , , ], spendPrice: [1390, 5000, -3, , , , , , , ])
flutter: 2023-01-31 00:00:00.000Z
flutter: [{item: 食費, price: 1390}, {item: 交際費, price: 5000}, {item: プラス, price: -3}]

    */

    /*


{"date":"2023-01-01",
"spend":[
    {"item":"食費", "price":999},
    {"item":"交際費", "price":888}
]
}



    */

    /*

    mysql> desc t_dailyspend;

| year       | varchar(4)       | NO   |     | NULL                |                |
| month      | varchar(2)       | NO   |     | NULL                |                |
| day        | varchar(2)       | NO   |     | NULL                |                |
| ymd        | varchar(8)       | YES  |     | NULL                |                |

| price      | int(11)          | NO   |     | NULL                |                |
| koumoku    | varchar(30)      | NO   |     | NULL                |                |

| created_at | timestamp        | NO   |     | 0000-00-00 00:00:00 |                |
| updated_at | timestamp        | NO   |     | 0000-00-00 00:00:00 |                |
+------------+------------------+------+-----+---------------------+----------------+
10 rows in set (0.00 sec)




    */
  }
}
////////////////////////////////////////////////
