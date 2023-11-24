// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../../state/device_info/device_info_notifier.dart';
import '../../../state/duty/duty_notifier.dart';
import '../../../utility/utility.dart';

class DutyPage extends ConsumerWidget {
  DutyPage({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

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

                displayDuty(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayDuty() {
    final dutyList = _ref.watch(dutyProvider(date).select((value) => value.dutyList));

    return dutyList.when(
      data: (value) {
        final list = <Widget>[];

        var item = '';

        for (var i = 0; i < value.length; i++) {
          if (i != 0) {
            if (item != value[i].duty) {
              list.add(
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Divider(
                    color: Colors.yellowAccent.withOpacity(0.1),
                    thickness: 5,
                  ),
                ),
              );
            }
          }

          list.add(
            Container(
              width: _context.screenSize.width,
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
              child: Table(
                children: [
                  TableRow(children: [
                    Text(value[i].date),
                    Text(value[i].duty),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(value[i].price.toString().toCurrency()),
                    ),
                  ]),
                ],
              ),
            ),
          );

          item = value[i].duty;
        }

        return SingleChildScrollView(
            child: DefaultTextStyle(style: const TextStyle(fontSize: 12), child: Column(children: list)));
      },
      error: (error, stackTrace) => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );

    /*


    final list = <Widget>[];

    var item = '';
    for (var i = 0; i < dutyState.length; i++) {
      if (i != 0) {
        if (item != dutyState[i].duty) {
          list.add(
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                color: Colors.yellowAccent.withOpacity(0.1),
                thickness: 5,
              ),
            ),
          );
        }
      }

      list.add(
        Container(
          width: _context.screenSize.width,
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          child: Table(
            children: [
              TableRow(children: [
                Text(dutyState[i].date),
                Text(dutyState[i].duty),
                Container(
                  alignment: Alignment.topRight,
                  child: Text(dutyState[i].price.toString().toCurrency()),
                ),
              ]),
            ],
          ),
        ),
      );

      item = dutyState[i].duty;
    }

    return SingleChildScrollView(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 12),
        child: Column(children: list),
      ),
    );






    */
  }
}
