// ignore_for_file: must_be_immutable, sized_box_shrink_expand

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/stock_notifier.dart';

class StockAlert extends ConsumerWidget {
  StockAlert({super.key});

  final autoScrollController = AutoScrollController();

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final stockState = ref.watch(stockProvider(DateTime.now()));

    final stockRecordState = ref.watch(stockRecordProvider);

    final exData = stockRecordState.data.split('/');

    final selectStockState = ref.watch(selectStockProvider);

    final deviceInfoState = ref.read(deviceInfoProvider);

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone')
                _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DefaultTextStyle(
                  style: const TextStyle(fontSize: 10),
                  child: Row(
                    children: stockState.record.asMap().entries.map((e) {
                      return GestureDetector(
                        onTap: () {
                          ref
                              .watch(selectStockProvider.notifier)
                              .setSelectStock(selectStock: e.key);

                          ref
                              .watch(stockRecordProvider.notifier)
                              .getStockRecord(flag: e.key);

                          autoScrollController.scrollToIndex(0);
                        },
                        child: Container(
                          width: context.screenSize.width * 0.4,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: (selectStockState == e.key)
                                  ? Colors.yellowAccent.withOpacity(0.6)
                                  : Colors.white.withOpacity(0.6),
                            ),
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: context.screenSize.height / 10,
                            ),
                            child: Text(
                              e.value.name,
                              style: TextStyle(
                                color: (selectStockState == e.key)
                                    ? Colors.yellowAccent
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              Divider(
                color: Colors.yellowAccent.withOpacity(0.2),
                thickness: 5,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          autoScrollController.scrollToIndex(
                            exData.length,
                          );
                        },
                        child: const Icon(Icons.arrow_downward),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          autoScrollController.scrollToIndex(0);
                        },
                        child: const Icon(Icons.arrow_upward),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Expanded(child: displayStock()),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayStock() {
    final stockRecordState = _ref.watch(stockRecordProvider);

    final list = <Widget>[];

    final exData = stockRecordState.data.split('/');

    for (var i = 0; i < exData.length; i++) {
      final exOne = exData[i].split('|');

      final exDate = exOne[0].split('-');

      if (exDate.length == 1) {
        continue;
      }

      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: AutoScrollTag(
            key: ValueKey(i),
            index: i,
            controller: autoScrollController,
            child: Table(
              children: [
                TableRow(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exDate[0]),
                      Text('${exDate[1]}-${exDate[2]}'),
                    ],
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(exOne[3].toCurrency()),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(exOne[4].toCurrency()),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(exOne[5].toCurrency()),
                  ),
                ]),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      controller: autoScrollController,
      child: Column(
        children: list,
      ),
    );
  }
}

///
////////////////////////////////////////////////

final selectStockProvider =
    StateNotifierProvider.autoDispose<SelectStockStateNotifier, int>((ref) {
  return SelectStockStateNotifier();
});

class SelectStockStateNotifier extends StateNotifier<int> {
  SelectStockStateNotifier() : super(0);

  ///
  Future<void> setSelectStock({required int selectStock}) async {
    state = selectStock;
  }
}
