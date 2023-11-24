// ignore_for_file: cascade_invocations, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vibration/vibration.dart';

import '../extensions/extensions.dart';
import '../route/routes.dart';
import '../state/spend/spend_notifier.dart';
import '../state/spend_item_input/spend_item_input_notifier.dart';
import '../utility/utility.dart';

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
      resizeToAvoidBottomInset: false,
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
                    Row(
                      children: [
                        Text(
                          (spendItemInputState.diff != 0)
                              ? spendItemInputState.diff.toString().toCurrency()
                              : spendItemInputState.baseDiff.toCurrency(),
                          style: TextStyle(
                            color: (spendItemInputState.diff == 0) ? Colors.yellowAccent : Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await _ref.read(spendItemInputProvider(diff).notifier).inputSpendItem(date: date);

                            await Vibration.vibrate(pattern: [500, 1000, 500, 2000]);

                            context.goNamed(RouteNames.home);
                          },
                          icon: const Icon(Icons.input, color: Colors.pinkAccent),
                        ),
                        IconButton(
                          onPressed: () => context.goNamed(RouteNames.home),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(thickness: 2, color: Colors.white.withOpacity(0.4)),
                Expanded(child: displayInputParts()),
                Divider(thickness: 2, color: Colors.white.withOpacity(0.4)),
                spendItemSetPanel(),
                const SizedBox(height: 20),
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
      '国民年金基金',
      'ジム会費',
      '国民健康保険'
    ];

    //----------------------------------

    spendItem = [];

    [DateTime(date.year - 1), DateTime(date.year)].forEach((element) {
      final spendYearlyList = _ref.watch(spendMonthDetailProvider(element).select((value) => value.spendYearlyList));

      spendYearlyList.value?.forEach((element2) {
        element2.item.forEach((element3) {
          if (!spendItem.contains(element3.item)) {
            if (!bankSpend.contains(element3.item)) {
              spendItem.add(element3.item);
            }
          }
        });
      });

      //
      //
      // final spendMonthDetailState = _ref.watch(spendMonthDetailProvider(element));
      //
      // spendMonthDetailState.list.forEach((element2) {
      //   element2.item.forEach((element3) {
      //     if (!spendItem.contains(element3.item)) {
      //       if (!bankSpend.contains(element3.item)) {
      //         spendItem.add(element3.item);
      //       }
      //     }
      //   });
      // });
      //
      //
      //
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
              SizedBox(
                width: 40,
                child: ChoiceChip(
                  label: Text((i + 1).toString()),
                  backgroundColor: Colors.black.withOpacity(0.4),
                  selectedColor: Colors.yellowAccent.withOpacity(0.4),
                  selected: i == spendItemInputState.itemPos,
                  onSelected: (bool isSelected) => _ref.read(spendItemInputProvider(diff).notifier).setItemPos(pos: i),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  width: _context.screenSize.width * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: (i == spendItemInputState.itemPos)
                          ? Colors.yellowAccent.withOpacity(0.4)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: TextField(
                    style: const TextStyle(fontSize: 12),
                    readOnly: true,
                    controller: TextEditingController(text: spendItemInputState.spendItem[i]),
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    ),
                  ),
                ),
              ),
              Checkbox(
                activeColor: Colors.orangeAccent,
                value: spendItemInputState.minusCheck[i],
                onChanged: (check) => _ref.read(spendItemInputProvider(diff).notifier).setMinusCheck(pos: i),
                side: BorderSide(color: Colors.white.withOpacity(0.8)),
              ),
              SizedBox(
                width: _context.screenSize.width * 0.3,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: tecs[i],
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  ),
                  style: const TextStyle(fontSize: 12),
                  onChanged: (value) =>
                      _ref.read(spendItemInputProvider(diff).notifier).setSpendPrice(pos: i, price: value.toInt()),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(children: list));
  }

  ///
  Widget spendItemSetPanel() {
    final spendItemInputState = _ref.watch(spendItemInputProvider(diff));

    return Wrap(
      children: spendItem.map((e) {
        return ChoiceChip(
          label: Text(
            (e == '') ? '_ clear _' : e,
            style: const TextStyle(fontSize: 12),
          ),
          backgroundColor: (e == '') ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
          selectedColor: Colors.yellowAccent.withOpacity(0.1),
          selected: e == spendItemInputState.spendItem[spendItemInputState.itemPos],
          onSelected: (bool isSelected) =>
              _ref.read(spendItemInputProvider(diff).notifier).setSpendItem(pos: spendItemInputState.itemPos, item: e),
        );
      }).toList(),
    );
  }
}
