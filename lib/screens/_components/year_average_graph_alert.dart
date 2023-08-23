// ignore_for_file: must_be_immutable
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';

class YearAverageGraphAlert extends ConsumerWidget {
  YearAverageGraphAlert({super.key, required this.date, required this.yearDateAverageMap, required this.yearDateMap});

  final DateTime date;
  final Map<int, int> yearDateAverageMap;
  final Map<int, String> yearDateMap;

  final Utility _utility = Utility();

  final ScrollController _controller = ScrollController();

  LineChartData graphData = LineChartData();

  List<String> usageGuideList = [];

  List<String> dateList = [];

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    setChartData();

    final deviceInfoState = ref.read(deviceInfoProvider);

    var widthAdjust = (yearDateAverageMap.length / 10).round();
    if (widthAdjust < 1) {
      widthAdjust = 1;
    }

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        child: SizedBox(
          width: context.screenSize.width * widthAdjust,
          height: context.screenSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Expanded(
                child: LineChart(graphData),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent.withOpacity(0.3),
                    ),
                    onPressed: () {
                      _controller.jumpTo(_controller.position.maxScrollExtent);
                    },
                    child: const Text('jump'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent.withOpacity(0.3),
                    ),
                    onPressed: () {
                      _controller.jumpTo(_controller.position.minScrollExtent);
                    },
                    child: const Text('back'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void setChartData() {
    final nums = <int>[];

    final flspotsList = <FlSpot>[];

    yearDateAverageMap.entries.forEach((element) {
      nums.add(element.value);

      flspotsList.add(
        FlSpot(
          (element.key - 1).toDouble(),
          element.value.toDouble(),
        ),
      );
    });

    final maxValue = nums.reduce(max);
    final minValue = nums.reduce(min);

    const warisuu = 5000;
    final graphMax = (maxValue / warisuu).ceil() * warisuu;
    final graphMin = (minValue * -1 / warisuu).ceil() * warisuu * -1;

    graphData = LineChartData(
      ///
      minX: 0,
      maxX: (yearDateAverageMap.length - 1).toDouble(),
      //
      minY: graphMin.toDouble(),
      maxY: graphMax.toDouble(),

      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

        //-------------------------// 左側の目盛り
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 12),
              );
            },
          ),
        ),
        //-------------------------// 左側の目盛り

        //-------------------------// 右側の目盛り
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 12),
              );
            },
          ),
        ),
        //-------------------------// 右側の目盛り

        //-------------------------// 下部の目盛り
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            getTitlesWidget: (value, meta) {
              final num = value.toInt() + 1;

              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(
                  num.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
              );
            },
          ),
        ),
        //-------------------------// 下部の目盛り
      ),

      ///
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white.withOpacity(0.3),
          getTooltipItems: _utility.getGraphToolTip,
        ),
      ),

      lineBarsData: [LineChartBarData(spots: flspotsList)],
    );
  }
}
