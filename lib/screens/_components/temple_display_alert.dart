// ignore_for_file: cascade_invocations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../models/temple.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/station/station_notifier.dart';
import '../../utility/utility.dart';

class TempleDisplayAlert extends ConsumerWidget {
  TempleDisplayAlert({super.key, required this.temple});

  final Temple temple;

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

              Expanded(child: displayTemple()),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Widget displayTemple() {
    final list = <Widget>[];

    final stationMap = _ref.watch(stationProvider.select((value) => value.stationMap));

    list.add(Text(
      '${stationMap[temple.startPoint]?.stationName}',
      style: const TextStyle(color: Colors.greenAccent),
    ));

    list.add(Text(temple.temple));

    if (temple.memo != '') {
      temple.memo.split('、').forEach((element) => list.add(Text(element)));
    }

    list.add(Text(
      '${stationMap[temple.endPoint]?.stationName}',
      style: const TextStyle(color: Colors.greenAccent),
    ));

    return SingleChildScrollView(
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: list),
      ),
    );
  }
}
