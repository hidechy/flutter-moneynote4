import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/lifetime/lifetime_notifier.dart';
import '../../state/lifetime_item/lifetime_item_notifier.dart';

// ignore: must_be_immutable
class LifetimeRecordInputAlert extends ConsumerWidget {
  LifetimeRecordInputAlert({super.key, required this.date});

  final DateTime date;

  List<TextEditingController> tecs = [];

  int onedayHourNum = 24;

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  Row(
                    children: [
                      Text(date.yyyymmdd),
                      const SizedBox(width: 20),
                      _displayReloadButton(),
                      const SizedBox(width: 10),
                      _displayBetweenInputButton(),
                    ],
                  ),
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
                        onTap: () async {
                          await ref.read(appParamProvider.notifier).setErrorMessage(msg: '');

                          /// null許容リストからnullを削除したnull非許容リストを作成する
                          if (lifetimeStringList.whereType<String>().length == onedayHourNum) {
                            await ref.read(lifetimeItemProvider.notifier).inputLifetime(date: date);

                            await ref.read(lifetimeProvider(date).notifier).getLifetime(date: date);

                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          } else {
                            await ref.read(appParamProvider.notifier).setErrorMessage(msg: 'cant save');
                          }
                        },
                        child: const Icon(Icons.input),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                child: DecoratedBox(
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
                      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      border: InputBorder.none,
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

    final lifetimeItemStringList = _ref.watch(lifetimeItemProvider.select((value) => value.lifetimeItemStringList));

    return Wrap(
      children: (lifetimeItemStringList.value != null)
          ? lifetimeItemStringList.value!.map((e) {
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
            }).toList()
          : [Container()],
    );

    // final lifetimeItemState = _ref.watch(lifetimeItemProvider);
    //
    // return Wrap(
    //   children: lifetimeItemState.lifetimeItemStringList.map((e) {
    //     return ChoiceChip(
    //       label: Text(e, style: const TextStyle(fontSize: 12)),
    //       backgroundColor: Colors.black.withOpacity(0.1),
    //       selectedColor: Colors.yellowAccent.withOpacity(0.1),
    //       selected: e.trim() == lifetimeItemState.selectedItem,
    //       onSelected: (bool isSelected) async {
    //         tecs[lifetimeItemState.itemPos].text = e;
    //
    //         await _ref.read(lifetimeItemProvider.notifier).setSelectedItem(item: e);
    //
    //         await _ref.read(lifetimeItemProvider.notifier).setLifetimeStringList(
    //               pos: lifetimeItemState.itemPos,
    //               item: e,
    //             );
    //       },
    //     );
    //   }).toList(),
    // );
  }

  ///
  Widget _displayReloadButton() {
    final lifetime = _ref.watch(lifetimeProvider(date).select((value) => value.lifetime));

    return GestureDetector(
      onTap: (lifetime != null)
          ? () async {
              final hourDataList = [
                lifetime.hour00,
                lifetime.hour01,
                lifetime.hour02,
                lifetime.hour03,
                lifetime.hour04,
                lifetime.hour05,
                lifetime.hour06,
                lifetime.hour07,
                lifetime.hour08,
                lifetime.hour09,
                lifetime.hour10,
                lifetime.hour11,
                lifetime.hour12,
                lifetime.hour13,
                lifetime.hour14,
                lifetime.hour15,
                lifetime.hour16,
                lifetime.hour17,
                lifetime.hour18,
                lifetime.hour19,
                lifetime.hour20,
                lifetime.hour21,
                lifetime.hour22,
                lifetime.hour23
              ];

              for (var i = 0; i < hourDataList.length; i++) {
                tecs[i].text = hourDataList[i];

                await _ref.read(lifetimeItemProvider.notifier).setLifetimeStringList(pos: i, item: hourDataList[i]);
              }
            }
          : null,
      child: Icon(
        Icons.refresh,
        color: (lifetime != null) ? Colors.yellowAccent.withOpacity(0.6) : Colors.white.withOpacity(0.6),
      ),
    );
  }

  ///
  Widget _displayBetweenInputButton() {
    final lifetimeItemState = _ref.watch(lifetimeItemProvider);

    if (lifetimeItemState.lifetimeStringList.isEmpty) {
      return const Icon(Icons.check_box_outline_blank, color: Colors.transparent);
    }

    return GestureDetector(
      onTap: () async {
        var endPos = 0;
        for (var i = lifetimeItemState.itemPos + 1; i < onedayHourNum; i++) {
          if (lifetimeItemState.lifetimeStringList[i] != null) {
            break;
          }

          endPos = i;
        }

        final lifetimeStringItem = lifetimeItemState.lifetimeStringList[lifetimeItemState.itemPos];

        for (var i = lifetimeItemState.itemPos; i <= endPos; i++) {
          tecs[i].text = lifetimeStringItem!;

          await _ref.read(lifetimeItemProvider.notifier).setLifetimeStringList(pos: i, item: lifetimeStringItem);
        }
      },
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(Icons.download_for_offline_outlined, color: Colors.white.withOpacity(0.6)),
        ],
      ),
    );
  }
}
