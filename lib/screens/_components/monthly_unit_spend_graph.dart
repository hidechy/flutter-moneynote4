// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/spend_notifier.dart';

class MonthlyUnitSpendGraph extends ConsumerWidget {
  MonthlyUnitSpendGraph({super.key, required this.date});

  final DateTime date;

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
          width: context.screenSize.width * 0.7,
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
    final spendMonthUnitState = _ref.watch(spendMonthUnitProvider(date));

    data = BarChartData(
      borderData: FlBorderData(
          border: const Border(
        left: BorderSide(),
        bottom: BorderSide(),
      )),
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString().toCurrency(),
                style: TextStyle(fontSize: 12),
              );
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(value.toInt().toString()),
              );
            },
          ),
        ),
      ),
      barTouchData: BarTouchData(),
      barGroups: spendMonthUnitState.entries.map(
        (e) {
          return BarChartGroupData(
            x: '${e.key}-01 00:00:00'.toDateTime().mm.toInt(),
            barRods: [
              BarChartRodData(toY: double.parse(e.value.toString())),
            ],
          );
        },
      ).toList(),
    );
  }
}