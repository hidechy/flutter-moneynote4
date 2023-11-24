// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/spend/spend_notifier.dart';
import '../../utility/utility.dart';

class MonthlyUnitSpendGraphAlert extends ConsumerWidget {
  MonthlyUnitSpendGraphAlert({super.key, required this.date});

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

    final spendMonthUnitMap = ref.watch(spendMonthUnitProvider(date).select((value) => value.spendMonthUnitMap));
    final spendMonthUnitMapLength = (spendMonthUnitMap.value != null) ? spendMonthUnitMap.value!.length : 0;
    final width = (spendMonthUnitMapLength / 6).ceil();

    //
    // final spendMonthUnitState = ref.watch(spendMonthUnitProvider(date));
    //
    // final width = (spendMonthUnitState.entries.length / 6).ceil();
    //
    //
    //

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        child: SizedBox(
          width: context.screenSize.width * width,
          height: context.screenSize.height - 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
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
    //----------------------------------//
    final list = <int>[];

    final spendMonthUnitMap = _ref.watch(spendMonthUnitProvider(date).select((value) => value.spendMonthUnitMap));

    spendMonthUnitMap.value?.forEach((key, value) {
      list.add(value);
    });

    //
    //
    //
    // final spendMonthUnitState = _ref.watch(spendMonthUnitProvider(date));
    //
    // spendMonthUnitState.entries.forEach((element) {
    //   list.add(element.value);
    // });
    //
    //

    const warisuu = 50000;
    var graphMax = warisuu;

    if (list.isNotEmpty) {
      final maxValue = list.reduce(max);

      graphMax = ((maxValue / warisuu).ceil() + 3) * warisuu;
    }

    //----------------------------------//

    data = BarChartData(
      maxY: graphMax.toString().toDouble(),
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
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString().toCurrency(),
                style: const TextStyle(fontSize: 12),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString().toCurrency(),
                style: const TextStyle(fontSize: 12),
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

      barGroups: spendMonthUnitMap.value?.entries.map((e) {
        return BarChartGroupData(
          x: DateTime(
            e.key.split('-')[0].toInt(),
            e.key.split('-')[1].toInt(),
          ).month,
          barRods: [
            BarChartRodData(toY: e.value.toString().toDouble()),
          ],
        );
      }).toList(),

      //
      //
      //
      // barGroups: spendMonthUnitState.entries.map(
      //   (e) {
      //     return BarChartGroupData(
      //       x: DateTime(
      //         e.key.split('-')[0].toInt(),
      //         e.key.split('-')[1].toInt(),
      //       ).month,
      //       barRods: [
      //         BarChartRodData(toY: e.value.toString().toDouble()),
      //       ],
      //     );
      //   },
      // ).toList(),
      //
      //
      //
      //
    );
  }
}
