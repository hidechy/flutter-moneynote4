import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';
import 'package:uuid/uuid.dart';

import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';

class SamedaySpendAlert extends ConsumerWidget {
  SamedaySpendAlert({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  final Utility _utility = Utility();

  Uuid uuid = const Uuid();

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

                Container(
                  height: context.screenSize.height - 230,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: displayDaySelect(),
                      ),
                    ],
                  ),
                ),

                // Row(children: yearWidgetList),
                // const SizedBox(height: 20),
                //
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: categoryWidgetList,
                //   ),
                // ),
                //
                // const SizedBox(height: 20),
                //
                // displayUdemy(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayDaySelect() {
    List<Widget> list = [];

    for (var i = 1; i < 31; i++) {
      list.add(
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
          ),
          child: Text(i.toString()),
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
