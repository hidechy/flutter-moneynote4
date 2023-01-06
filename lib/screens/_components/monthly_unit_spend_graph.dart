import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';

import '../../extensions/extensions.dart';

class MonthlyUnitSpendGraph extends ConsumerWidget {
  MonthlyUnitSpendGraph({Key? key}) : super(key: key);

  BarChartData data = BarChartData();

  final ScrollController _controller = ScrollController();

  final Utility _utility = Utility();

  Uuid uuid = const Uuid();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    setChartData();

    final deviceInfoState = ref.read(deviceInfoProvider);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        child: SizedBox(
          width: context.screenSize.width,
          height: context.screenSize.height - 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone')
                _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Expanded(
                child: BarChart(data),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void setChartData() {
    data = BarChartData(
        borderData: FlBorderData(
            border: const Border(
          top: BorderSide.none,
          right: BorderSide.none,
          left: BorderSide(width: 1),
          bottom: BorderSide(width: 1),
        )),
        groupsSpace: 10,
        barGroups: [
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(toY: 10, width: 15),
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(toY: 9, width: 15),
          ]),
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(toY: 4, width: 15),
          ]),
          BarChartGroupData(x: 4, barRods: [
            BarChartRodData(toY: 2, width: 15),
          ]),
          BarChartGroupData(x: 5, barRods: [
            BarChartRodData(toY: 13, width: 15),
          ]),
          BarChartGroupData(x: 6, barRods: [
            BarChartRodData(toY: 17, width: 15),
          ]),
          BarChartGroupData(x: 7, barRods: [
            BarChartRodData(toY: 19, width: 15),
          ]),
          BarChartGroupData(x: 8, barRods: [
            BarChartRodData(toY: 21, width: 15),
          ]),
        ]);
  }
}
