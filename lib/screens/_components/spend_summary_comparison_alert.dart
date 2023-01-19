import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/spend_notifier.dart';

class SpendSummaryComparisonAlert extends ConsumerWidget {
  SpendSummaryComparisonAlert({Key? key}) : super(key: key);

  final Utility _utility = Utility();

  Uuid uuid = const Uuid();

  Map<int, dynamic> comparisonMap = {};

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    makeComparisonMap();

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

                const SizedBox(height: 20),

                Text(comparisonMap.entries.length.toString()),

                //
                //
                // displayWellsReserve(),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  void makeComparisonMap() async {
    for (var i = 2020; i <= DateTime.now().yyyy.toInt(); i++) {
      comparisonMap[i] = await _ref.watch(
        spendSummaryProvider(
          '${i}-01-01 00:00:00'.toDateTime(),
        ),
      );
    }
  }
}
