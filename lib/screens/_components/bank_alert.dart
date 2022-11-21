// ignore_for_file: must_be_immutable, sized_box_shrink_expand

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../utility/utility.dart';
import '../../viewmodel/bank_notifier.dart';

class BankAlert extends ConsumerWidget {
  BankAlert({super.key, required this.name});

  final String name;

  final Utility _utility = Utility();

  final autoScrollController = AutoScrollController();

  late WidgetRef _ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final bankAllState = _ref.watch(bankAllProvider(name));

    final bankName = _utility.getBankName();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(bankName[name].toString()),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            autoScrollController.scrollToIndex(
                              bankAllState.length,
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
                Divider(
                  color: Colors.yellowAccent.withOpacity(0.2),
                  thickness: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.75,
                  child: displayBank(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayBank() {
    final bankAllState = _ref.watch(bankAllProvider(name));

    final list = <Widget>[];

    for (var i = 0; i < bankAllState.length; i++) {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(bankAllState[i].date.toString().split(' ')[0]),
                Row(
                  children: [
                    Text(_utility.makeCurrencyDisplay(bankAllState[i].price)),
                    const SizedBox(width: 20),
                    getBankMark(mark: bankAllState[i].mark),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      controller: autoScrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }

  ///
  Widget getBankMark({required String mark}) {
    switch (mark) {
      case 'up':
        return const Icon(
          Icons.arrow_upward,
          color: Colors.greenAccent,
        );
      case 'down':
        return const Icon(
          Icons.arrow_downward,
          color: Colors.redAccent,
        );
      default:
        return const Icon(
          Icons.crop_square,
          color: Colors.black,
        );
    }
  }
}
