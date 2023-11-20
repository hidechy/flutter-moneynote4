// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/stock/stock_notifier.dart';
import '../../utility/utility.dart';

class StockAlert extends ConsumerWidget {
  StockAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  final autoScrollController = AutoScrollController();

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final deviceInfoState = ref.read(deviceInfoProvider);

    //==============================//
    final stockState = _ref.watch(stockProvider(date));

    final selectStockState = _ref.watch(selectStockProvider);

    var exDataLength = 0;
    if (stockState.lastStock != null) {
      exDataLength = (stockState.lastStock!.record.isNotEmpty)
          ? stockState.lastStock!.record[selectStockState].data.split('/').length
          : 0;
    }

    //==============================//

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
              Text(date.yyyymmdd),

              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              displayItemName(),

              Divider(
                color: Colors.yellowAccent.withOpacity(0.2),
                thickness: 5,
              ),

              if (exDataLength > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            autoScrollController.scrollToIndex(exDataLength);
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
  Widget displayItemName() {
    final stockState = _ref.watch(stockProvider(date));

    final selectStockState = _ref.watch(selectStockProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: (stockState.lastStock == null)
            ? Container()
            : Row(
                children: stockState.lastStock!.record.asMap().entries.map((e) {
                  final exData = e.value.data.split('/');

                  var lastDate = '';
                  for (var i = 0; i < exData.length; i++) {
                    final exOne = exData[i].split('|');
                    lastDate = exOne[0];
                  }

                  return GestureDetector(
                    onTap: () async {
                      await _ref.read(selectStockProvider.notifier).setSelectStock(selectStock: e.key);

                      await _ref.read(stockRecordProvider.notifier).getStockRecord(flag: e.key);

                      await autoScrollController.scrollToIndex(0);
                    },
                    child: Container(
                      width: _context.screenSize.width * 0.4,
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
                          minHeight: _context.screenSize.height / 10,
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                lastDate,
                                style: TextStyle(
                                  fontSize: 8,
                                  color: (selectStockState == e.key) ? Colors.yellowAccent : Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              e.value.name,
                              style: TextStyle(
                                color: (selectStockState == e.key) ? Colors.yellowAccent : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }

  ///
  Widget displayStock() {
    final stockState = _ref.watch(stockProvider(date));

    final selectStockState = _ref.watch(selectStockProvider);

    final list = <Widget>[];

    if (stockState.lastStock != null) {
      if (stockState.lastStock!.record.isNotEmpty) {
        final exData = stockState.lastStock!.record[selectStockState].data.split('/');

        for (var i = 0; i < exData.length; i++) {
          final exElement = exData[i].split('|');

          list.add(
            AutoScrollTag(
              key: ValueKey(i),
              index: i,
              controller: autoScrollController,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                child: Table(
                  children: [
                    TableRow(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(exElement[0]),
                          Text('${exElement[1]}-${exElement[2]}'),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(exElement[3].toCurrency()),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(exElement[4].toCurrency()),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(exElement[5].toCurrency()),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          );
        }
      }
    }

    return SingleChildScrollView(
      controller: autoScrollController,
      child: Column(children: list),
    );
  }
}

////////////////////////////////////////////////

final selectStockProvider = StateNotifierProvider.autoDispose<SelectStockStateNotifier, int>((ref) {
  return SelectStockStateNotifier();
});

class SelectStockStateNotifier extends StateNotifier<int> {
  SelectStockStateNotifier() : super(0);

  ///
  Future<void> setSelectStock({required int selectStock}) async {
    state = selectStock;
  }
}
