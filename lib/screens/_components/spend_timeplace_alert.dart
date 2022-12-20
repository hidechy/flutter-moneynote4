// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/timeplace_notifier.dart';

class SpendTimeplaceAlert extends ConsumerWidget {
  SpendTimeplaceAlert(
      {super.key, required this.date, required this.item, required this.price});

  final DateTime date;
  final String item;
  final int price;

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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date.yyyymmdd),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(item),
                        Text(price.toString().toCurrency()),
                      ],
                    ),
                  ],
                ),

                Divider(
                  color: Colors.white.withOpacity(0.5),
                  thickness: 3,
                ),

                displaySpendTimeplace(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displaySpendTimeplace() {
    final list = <Widget>[];

    final timeplaceState = _ref.watch(timeplaceProvider(date));

    for (var i = 0; i < timeplaceState.length; i++) {
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
              Expanded(
                child: Text(timeplaceState[i].time),
              ),
              Expanded(
                child: Text(timeplaceState[i].place),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(timeplaceState[i].price.toString().toCurrency()),
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
}
