// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/seiyu_purchase_item/seiyu_purchase_item_request_state.dart';
import '../../utility/utility.dart';
import '../../viewmodel/seiyu_notifier.dart';

class SeiyuItemAlert extends ConsumerWidget {
  SeiyuItemAlert({super.key, required this.date, required this.item});

  final DateTime date;
  final String item;

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

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
        child: SingleChildScrollView(
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

                Text(item),

                const SizedBox(height: 20),
                displaySeiyuItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displaySeiyuItem() {
    final list = <Widget>[];

    for (var i = 2020; i <= date.year; i++) {
      final param = SeiyuPurchaseItemRequestState(
        date: DateTime(i),
        item: item,
      );

      final seiyuPurchaseItemState =
          _ref.watch(seiyuPurchaseItemProvider(param));

      seiyuPurchaseItemState.forEach((element) {
        element.list.forEach((element2) {
          final exValue = element2.split('|');

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
              child: Row(
                children: [
                  Expanded(child: Text(exValue[0])),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(exValue[1].toCurrency()),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(exValue[2]),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(exValue[3].toCurrency()),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
    }

    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }
}
