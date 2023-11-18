import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/state/lifetime/lifetime_item_notifier.dart';

import '../../extensions/extensions.dart';

// ignore: must_be_immutable
class LifetimeRecordInputAlert extends ConsumerWidget {
  LifetimeRecordInputAlert({super.key, required this.date});

  final DateTime date;

  List<TextEditingController> tecs = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeTecs();

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
              Text(date.yyyymmdd),
              Expanded(child: lifetimeInputParts()),
              Divider(
                thickness: 2,
                color: Colors.white.withOpacity(0.4),
              ),
              lifetimeItemSetPanel(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void makeTecs() {
    for (var i = 0; i <= 23; i++) {
      tecs.add(TextEditingController(text: ''));
    }
  }

  ///
  Widget lifetimeInputParts() {
    return Container();
  }

  ///
  Widget lifetimeItemSetPanel() {
    var lifetimeItemState = _ref.watch(lifetimeItemProvider);

    return Wrap(
      // children: spendItem.map((e) {
      //   return ChoiceChip(
      //     label: Text(
      //       (e == '') ? '_ clear _' : e,
      //       style: const TextStyle(fontSize: 12),
      //     ),
      //     backgroundColor: (e == '') ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
      //     selectedColor: Colors.black.withOpacity(0.1),
      //     selected: e == spendItemInputState.spendItem[spendItemInputState.itemPos],
      //     onSelected: (bool isSelected) =>
      //         _ref.read(spendItemInputProvider(diff).notifier).setSpendItem(pos: spendItemInputState.itemPos, item: e),
      //   );
      // }).toList(),

      children: lifetimeItemState.lifetimeItemStringList.map((e) {
        return ChoiceChip(
            label: Text(
              e,
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: Colors.black.withOpacity(0.1),
            selectedColor: Colors.black.withOpacity(0.1),
            selected: e == lifetimeItemState.selectedItem,
            onSelected: (bool isSelected) => _ref.read(lifetimeItemProvider.notifier).setSelectedItem(item: e));
      }).toList(),
    );
  }
}
