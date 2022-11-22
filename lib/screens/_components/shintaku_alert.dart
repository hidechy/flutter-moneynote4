import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../utility/utility.dart';
import '../../viewmodel/shintaku_notifier.dart';

class ShintakuAlert extends ConsumerWidget {
  ShintakuAlert({Key? key}) : super(key: key);

  final autoScrollController = AutoScrollController();

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final shintakuState = ref.watch(shintakuProvider);

    final shintakuRecordState = ref.watch(shintakuRecordProvider);

    final exData = shintakuRecordState.data.split('/');

    final selectShintakuState = ref.watch(selectShintakuProvider);

    final size = MediaQuery.of(context).size;

    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.15,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: shintakuState.record.asMap().entries.map((e) {
                        return Container(
                          width: size.width * 0.7,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .watch(selectShintakuProvider.notifier)
                                  .setSelectShintaku(selectShintaku: e.key);

                              ref
                                  .watch(shintakuRecordProvider.notifier)
                                  .getShintakuRecord(flag: e.key);

                              autoScrollController.scrollToIndex(0);
                            },
                            child: Text(
                              e.value.name,
                              style: TextStyle(
                                color: (selectShintakuState == e.key)
                                    ? Colors.yellowAccent
                                    : Colors.white,
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
                SizedBox(
                  height: size.height * 0.55,
                  child: displayShintaku(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayShintaku() {
    final shintakuRecordState = _ref.watch(shintakuRecordProvider);

    final list = <Widget>[];

    final exData = shintakuRecordState.data.split('/');

    for (var i = 0; i < exData.length; i++) {
      final exOne = exData[i].split('|');

      final exDate = exOne[0].split('-');

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
                    child: Text(_utility.makeCurrencyDisplay(exOne[3])),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(_utility.makeCurrencyDisplay(exOne[4])),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(_utility.makeCurrencyDisplay(exOne[5])),
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

////////////////////////////////////////////////

final selectShintakuProvider =
    StateNotifierProvider.autoDispose<SelectShintakuStateNotifier, int>((ref) {
  return SelectShintakuStateNotifier();
});

class SelectShintakuStateNotifier extends StateNotifier<int> {
  SelectShintakuStateNotifier() : super(0);

  ///
  Future<void> setSelectShintaku({required int selectShintaku}) async {
    state = selectShintaku;
  }
}
