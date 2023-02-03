// ignore_for_file: cascade_invocations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/extensions.dart';

import '../state/spend_item_input/spend_item_input_notifier.dart';
import '../utility/utility.dart';
import '../viewmodel/spend_notifier.dart';

class SpendItemInputScreen extends ConsumerWidget {
  SpendItemInputScreen({super.key, required this.date, required this.diff});

  final DateTime date;
  final String diff;

  final Utility _utility = Utility();

  List<String> spendItem = [];

  List<TextEditingController> tecs = [];

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final spendItemInputState = _ref.watch(spendItemInputProvider(diff));

    makeTecs();

    makeSpendItem();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _utility.getBackGround(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(width: context.screenSize.width),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date.yyyymmdd),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  color: Colors.white.withOpacity(0.4),
                ),
                Expanded(
                  child: displayInputParts(),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.white.withOpacity(0.4),
                ),
                displayNumSetPanel(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (spendItemInputState.diff != 0)
                          ? spendItemInputState.diff.toString().toCurrency()
                          : spendItemInputState.baseDiff.toCurrency(),
                    ),
                    IconButton(
                      onPressed: () {
                        _ref
                            .watch(spendItemInputProvider(diff).notifier)
                            .inputSpendItem(date: date);
                      },
                      icon: const Icon(Icons.input),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  void makeTecs() {
    for (var i = 0; i < 10; i++) {
      tecs.add(TextEditingController(text: ''));
    }
  }

  ///
  void makeSpendItem() {
    //----------------------------------
    final bankSpend = [
      '牛乳代',
      '弁当代',
      '住居費',
      'credit',
      '保険料',
      '共済代',
      'GOLD',
      '投資信託',
      'アイアールシー',
      '国民年金基金'
    ];

    //----------------------------------

    spendItem = [];

    [DateTime(date.year - 1), DateTime(date.year)].forEach((element) {
      final spendMonthDetailState =
          _ref.watch(spendMonthDetailProvider(element));

      spendMonthDetailState.list.forEach((element2) {
        element2.item.forEach((element3) {
          if (!spendItem.contains(element3.item)) {
            if (!bankSpend.contains(element3.item)) {
              spendItem.add(element3.item);
            }
          }
        });
      });
    });
  }

  ///
  Widget displayInputParts() {
    final spendItemInputState = _ref.watch(spendItemInputProvider(diff));

    final list = <Widget>[];

    for (var i = 0; i < 10; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: _context.screenSize.width * 0.3,
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: spendItemInputState.spendItem[i]),
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: _context.screenSize.width * 0.3,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: tecs[i],
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 4,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    _ref
                        .watch(spendItemInputProvider(diff).notifier)
                        .setSpendPrice(pos: i, price: value.toInt());
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }

  ///
  Widget displayNumSetPanel() {
    final spendItemInputState = _ref.watch(spendItemInputProvider(diff));

    final oneWidth = _context.screenSize.width / 6;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < 10; i++)
                SizedBox(
                  width: oneWidth,
                  child: ChoiceChip(
                    label: Text((i + 1).toString()),
                    backgroundColor: Colors.black.withOpacity(0.4),
                    selectedColor: Colors.yellowAccent.withOpacity(0.4),
                    selected: i == spendItemInputState.itemPos,
                    onSelected: (bool isSelected) {
                      _ref
                          .watch(spendItemInputProvider(diff).notifier)
                          .setItemPos(pos: i);
                    },
                  ),
                )
            ],
          ),
        ),
        Wrap(
          children: spendItem.map((e) {
            return ChoiceChip(
              label: Text((e == '') ? '_ clear _' : e),
              backgroundColor: (e == '')
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
              selectedColor: Colors.black.withOpacity(0.1),
              selected: e ==
                  spendItemInputState.spendItem[spendItemInputState.itemPos],
              onSelected: (bool isSelected) {
                _ref.watch(spendItemInputProvider(diff).notifier).setSpendItem(
                      pos: spendItemInputState.itemPos,
                      item: e,
                    );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
