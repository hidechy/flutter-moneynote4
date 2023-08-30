// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/shintaku/shintaku_notifier.dart';
import '../../utility/utility.dart';

class ShintakuGraphAlert extends ConsumerWidget {
  ShintakuGraphAlert({super.key, required this.date});

  final DateTime date;

  final Utility _utility = Utility();

  List<String> dateList = [];

  LineChartData graphData = LineChartData();

  List<Color> twelveColor = [];

  final ScrollController _controller = ScrollController();

  List<String> usageGuideList = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    twelveColor = _utility.getTwelveColor();

    setChartData();

    final deviceInfoState = ref.read(deviceInfoProvider);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        child: SizedBox(
          width: context.screenSize.width * (dateList.length / 10),
          height: context.screenSize.height - 50,
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
                  Container(),
                  displayUsage(),
                ],
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
    usageGuideList = [];

    final shintakuState = _ref.watch(shintakuProvider(date));

    final dataMap = <int, Map<String, int>>{};

    for (var i = 0; i < shintakuState.lastShintaku!.record.length; i++) {
      final exData = shintakuState.lastShintaku!.record[i].data.split('/');

      final map = <String, int>{};
      for (var j = 0; j < exData.length; j++) {
        final exDt = exData[j].split('|');
        map[exDt[0]] = exDt[5].toInt();

        if (!dateList.contains(exDt[0])) {
          dateList.add(exDt[0]);
        }
      }

      dataMap[i] = map;

      usageGuideList.add(shintakuState.lastShintaku!.record[i].name);
    }

    dateList.sort();

    final dataMap2 = <int, List<int>>{};

    for (var i = 0; i < dataMap.length; i++) {
      final list = <int>[];
      dateList.forEach((element) {
        list.add(((dataMap[i]![element] != null) ? dataMap[i]![element] : 0)!);
      });

      dataMap2[i] = list;
    }

    //------------------------------------------(3)
    final flspotsList = <List<FlSpot>>[];

    final points = <int>[];

    dataMap2.forEach((key, value) {
      final flspots = <FlSpot>[];
      for (var i = 0; i < value.length; i++) {
        flspots.add(FlSpot(i.toDouble(), value[i].toDouble()));

        points.add(value[i]);
      }
      flspotsList.add(flspots);
    });
    //------------------------------------------(3)

    final maxPoint = points.reduce(max);
    final minPoint = points.reduce(min);

    const warisuu = 50000;
    final graphMax = (maxPoint / warisuu).ceil() * warisuu * 1.5;
    final graphMin = (minPoint * -1 / warisuu).ceil() * warisuu * -1;

    graphData = LineChartData(
      ///
      minX: 0,
      maxX: (dateList.length - 1).toDouble(),
      //
      minY: graphMin.toDouble(),
      maxY: graphMax,

      ///
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white.withOpacity(0.3),
          getTooltipItems: _utility.getGraphToolTip,
        ),
      ),

      ///
      gridData: _utility.getFlGridData(),

      ///
      titlesData: FlTitlesData(
        show: true,

        //-------------------------// 上部の目盛り
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        //-------------------------// 上部の目盛り

        //-------------------------// 下部の目盛り
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            getTitlesWidget: (value, meta) {
              final exValue = value.toString().split('.');

              final exDate = dateList[exValue[0].toInt()].split('-');

              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(
                  '${exDate[0]}\n${exDate[1]}-${exDate[2]}',
                  style: const TextStyle(fontSize: 10),
                ),
              );
            },
          ),
        ),
        //-------------------------// 下部の目盛り

        //-------------------------// 左側の目盛り
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: const TextStyle(fontSize: 10),
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
      ),

      ///
      lineBarsData: [
        for (var i = 0; i < flspotsList.length; i++)
          LineChartBarData(
            spots: flspotsList[i],
            barWidth: 3,
            isStrokeCapRound: true,
            color: twelveColor[i],
          ),
      ],
    );
  }

  ///
  Widget displayUsage() {
    final list = <Widget>[];
    usageGuideList.forEach((element) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          child: Text(
            element,
            style: TextStyle(color: twelveColor[list.length], fontWeight: FontWeight.bold, fontSize: 8),
          ),
        ),
      );
    });

    return Row(
      children: list,
    );
  }
}
