import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynote4/extensions/extensions.dart';
import 'package:uuid/uuid.dart';

import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';

class WellsReserveAlert extends ConsumerWidget {
  WellsReserveAlert({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  final Utility _utility = Utility();

  Uuid uuid = const Uuid();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    final yearWidgetList = makeYearWidgetList();

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

                Row(children: yearWidgetList),
                
                // const SizedBox(height: 20),
                // displayTrain(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  List<Widget> makeYearWidgetList() {
    final appParamState = _ref.watch(appParamProvider);

    final yearList = <Widget>[];
    for (var i = date.yyyy.toInt(); i >= 2020; i--) {
      yearList.add(
        GestureDetector(
          onTap: () {
            //
            //
            // _ref
            //     .watch(appParamProvider.notifier)
            //     .setTrainAlertSelectYear(year: i);
            //
            // final date = '$i-01-01 00:00:00'.toDateTime();
            //
            // _ref.watch(trainProvider.notifier).getYearTrain(date: date);
            //
            //
            //
            //
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              color: (i == appParamState.TrainAlertSelectYear)
                  ? Colors.yellowAccent.withOpacity(0.2)
                  : null,
            ),
            child: Text(i.toString()),
          ),
        ),
      );
    }

    return yearList;
  }
}
