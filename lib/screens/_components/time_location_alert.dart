// ignore_for_file: must_be_immutable, cascade_invocations

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/time_location_notifier.dart';

class TimeLocationAlert extends ConsumerWidget {
  TimeLocationAlert({super.key, required this.date});

  final DateTime date;

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

                displayTimeLocation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Widget displayTimeLocation() {
    final list = <Widget>[];

    final timeLocationState = _ref.watch(timeLocationProvider(date));

    timeLocationState.forEach((element) {
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
              Expanded(child: Text(element.time)),
              Expanded(child: Text(element.latitude)),
              Expanded(child: Text(element.longitude)),
            ],
          ),
        ),
      );
    });

    return SingleChildScrollView(
      child: Column(children: list),
    );
  }
}
