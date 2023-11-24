// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/spend/spend_notifier.dart';
import '../../state/spend_yearly_item/spend_yearly_item_state.dart';
import '../../utility/utility.dart';
import '_money_dialog.dart';
import 'spend_timeplace_alert.dart';

class SpendYearlyItemAlert extends ConsumerWidget {
  SpendYearlyItemAlert({super.key, required this.date, required this.item});

  final DateTime date;
  final String item;

  final Utility _utility = Utility();

  final timeplaceItem = ['交通費', '遊興費', 'お賽銭', '交際費', '雑費', '教育費', '被服費', '医療費', '美容費', '通信費'];

  late BuildContext _context;
  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
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
                if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
                //----------//

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(date.yyyy), Text(item)],
                ),

                Divider(color: Colors.white.withOpacity(0.5), thickness: 3),

                displaySpendYearlyItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displaySpendYearlyItem() {
    final param = SpendYearlyItemState(date: date, item: item);

    final spendYearlyItemState = _ref.watch(spendYearlyItemProvider(param));

    final list = <Widget>[];

    for (var i = 0; i < spendYearlyItemState.length; i++) {
      final youbi = _utility.getYoubi(youbiStr: spendYearlyItemState[i].date!.youbiStr);

      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.3)))),
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _utility.getLeadingBgColor(month: spendYearlyItemState[i].date!.month.toString()),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    spendYearlyItemState[i].date!.month.toString().padLeft(2, '0'),
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text('${spendYearlyItemState[i].date!.mmdd}\n（$youbi）')),
                Expanded(child: Text(spendYearlyItemState[i].item)),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(spendYearlyItemState[i].price.toString().toCurrency()),
                  ),
                ),
                const SizedBox(width: 20),
                (timeplaceItem.contains(spendYearlyItemState[i].item))
                    ? GestureDetector(
                        onTap: () {
                          MoneyDialog(
                            context: _context,
                            widget: SpendTimeplaceAlert(
                              date: spendYearlyItemState[i].date!,
                              item: item,
                              price: spendYearlyItemState[i].price!,
                            ),
                          );
                        },
                        child: Icon(Icons.pin_drop_rounded, color: Colors.white.withOpacity(0.6)),
                      )
                    : const Icon(Icons.crop_square, color: Colors.transparent),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(children: list));
  }
}
