import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/state/app_param/app_param_notifier.dart';

import '../../extensions/extensions.dart';
import '../../state/lifetime/lifetime_item_notifier.dart';

// ignore: must_be_immutable
class LifetimeRecordInputAlert extends ConsumerWidget {
  LifetimeRecordInputAlert({super.key, required this.date});

  final DateTime date;

  List<TextEditingController> tecs = [];

  int onedayHourNum = 24;

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;

    final lifetimeStringList = ref.watch(lifetimeItemProvider.select((value) => value.lifetimeStringList));

    final errorMessage = ref.watch(appParamProvider.select((value) => value.errorMessage));

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date.yyyymmdd),
                  Row(
                    children: [
                      if (errorMessage != '') ...[
                        Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.yellowAccent),
                        ),
                        const SizedBox(width: 20),
                      ],
                      GestureDetector(
                        onTap: () {
                          ref.watch(appParamProvider.notifier).setErrorMessage(msg: '');

                          /// null許容リストからnullを削除したnull非許容リストを作成する
                          if (lifetimeStringList.whereType<String>().length == onedayHourNum) {
                            ref.read(lifetimeItemProvider.notifier).inputLifetime(date: date);
                          } else {
                            ref.read(appParamProvider.notifier).setErrorMessage(msg: 'cant save');
                          }
                        },
                        child: const Icon(Icons.input),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(child: lifetimeInputParts()),
              Divider(thickness: 2, color: Colors.white.withOpacity(0.4)),
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
    for (var i = 0; i < onedayHourNum; i++) {
      tecs.add(TextEditingController(text: ''));
    }
  }

  ///
  Widget lifetimeInputParts() {
    final list = <Widget>[];

    final lifetimeItemState = _ref.watch(lifetimeItemProvider);

    for (var i = 0; i < onedayHourNum; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: ChoiceChip(
                  label: Text(i.toString()),
                  backgroundColor: Colors.black.withOpacity(0.4),
                  selectedColor: Colors.yellowAccent.withOpacity(0.4),
                  selected: i == lifetimeItemState.itemPos,
                  onSelected: (bool isSelected) => _ref.read(lifetimeItemProvider.notifier).setItemPos(pos: i),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  width: _context.screenSize.width * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          (i == lifetimeItemState.itemPos) ? Colors.yellowAccent.withOpacity(0.4) : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: TextField(
                    style: const TextStyle(fontSize: 12),
                    readOnly: true,
                    controller: tecs[i],
                    decoration: const InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    ),
                  ),
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
  Widget lifetimeItemSetPanel() {
    final lifetimeItemState = _ref.watch(lifetimeItemProvider);

    return Wrap(
      children: lifetimeItemState.lifetimeItemStringList.map((e) {
        return ChoiceChip(
          label: Text(e, style: const TextStyle(fontSize: 12)),
          backgroundColor: Colors.black.withOpacity(0.1),
          selectedColor: Colors.yellowAccent.withOpacity(0.1),
          selected: e.trim() == lifetimeItemState.selectedItem,
          onSelected: (bool isSelected) async {
            tecs[lifetimeItemState.itemPos].text = e;

            await _ref.read(lifetimeItemProvider.notifier).setSelectedItem(item: e);

            await _ref.read(lifetimeItemProvider.notifier).setLifetimeStringList(
                  pos: lifetimeItemState.itemPos,
                  item: e,
                );
          },
        );
      }).toList(),
    );
  }
}
