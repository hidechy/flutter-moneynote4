// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/shintaku/shintaku_notifier.dart';
import '../../utility/utility.dart';
import '_money_dialog.dart';
import 'shintaku_graph_alert.dart';

class ShintakuAlert extends ConsumerWidget {
  ShintakuAlert({super.key, required this.date});

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
    final shintakuState = _ref.watch(shintakuProvider(date));

    final selectShintakuState = _ref.watch(selectShintakuProvider);

    var exDataLength = 0;

    if (shintakuState.lastShintaku != null) {
      exDataLength = (shintakuState.lastShintaku!.record.isNotEmpty)
          ? shintakuState.lastShintaku!.record[selectShintakuState].data.split('/').length
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
                    GestureDetector(
                      onTap: () {
                        MoneyDialog(
                          context: context,
                          widget: ShintakuGraphAlert(date: date),
                        );
                      },
                      child: const Icon(Icons.graphic_eq),
                    ),
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

              Expanded(child: displayShintaku()),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayItemName() {
    final shintakuState = _ref.watch(shintakuProvider(date));

    final selectShintakuState = _ref.watch(selectShintakuProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: (shintakuState.lastShintaku == null)
            ? Container()
            : Row(
                children: shintakuState.lastShintaku!.record.asMap().entries.map((e) {
                  final exData = e.value.data.split('/');

                  var lastDate = '';
                  for (var i = 0; i < exData.length; i++) {
                    final exOne = exData[i].split('|');
                    lastDate = exOne[0];
                  }

                  final dateDiffInDays = '$lastDate 00:00:00'.toDateTime().difference(DateTime.now()).inDays;

                  return GestureDetector(
                    onTap: () {
                      _ref.read(selectShintakuProvider.notifier).setSelectShintaku(selectShintaku: e.key);

                      _ref.read(shintakuRecordProvider.notifier).getShintakuRecord(flag: e.key);

                      autoScrollController.scrollToIndex(0);
                    },
                    child: Container(
                      width: _context.screenSize.width * 0.4,
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: (selectShintakuState == e.key)
                              ? Colors.yellowAccent.withOpacity(0.6)
                              : Colors.white.withOpacity(0.6),
                        ),
                        color: (dateDiffInDays > -30) ? Colors.transparent : Colors.grey.withOpacity(0.2),
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
                                  color: (selectShintakuState == e.key) ? Colors.yellowAccent : Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              e.value.name,
                              style: TextStyle(
                                color: (selectShintakuState == e.key) ? Colors.yellowAccent : Colors.white,
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
  Widget displayShintaku() {
    final shintakuState = _ref.watch(shintakuProvider(date));

    final selectShintakuState = _ref.watch(selectShintakuProvider);

    final list = <Widget>[];

    if (shintakuState.lastShintaku != null) {
      if (shintakuState.lastShintaku!.record.isNotEmpty) {
        final exData = shintakuState.lastShintaku!.record[selectShintakuState].data.split('/');

        var keepNum = 0;

        //forで仕方ない
        for (var i = 0; i < exData.length; i++) {
          final exOne = exData[i].split('|');

          final exDate = exOne[0].split('-');

          if (exDate.length == 1) {
            continue;
          }

          final diff = exOne[1].toInt() - keepNum;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exOne[0]),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Text(exOne[3].toCurrency()),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Text(exOne[4].toCurrency()),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Text(exOne[5].toCurrency()),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(exOne[1].toCurrency()),
                                Text(
                                  diff.toString(),
                                  style: TextStyle(
                                    color: (diff == 0) ? Colors.grey : Colors.yellowAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );

          keepNum = exOne[1].toInt();
        }
      }
    }

    return SingleChildScrollView(
      controller: autoScrollController,
      child: Column(children: list),
    );
  }
}

///
////////////////////////////////////////////////

final selectShintakuProvider = StateNotifierProvider.autoDispose<SelectShintakuStateNotifier, int>((ref) {
  return SelectShintakuStateNotifier();
});

class SelectShintakuStateNotifier extends StateNotifier<int> {
  SelectShintakuStateNotifier() : super(0);

  ///
  Future<void> setSelectShintaku({required int selectShintaku}) async {
    state = selectShintaku;
  }
}
