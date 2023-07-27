// ignore_for_file: must_be_immutable
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../state/shintaku/shintaku_notifier.dart';

class ShintakuGraphAlert extends ConsumerWidget {
  ShintakuGraphAlert({super.key, required this.date});

  final DateTime date;

  LineChartData graphData = LineChartData();

  List<Map<String, dynamic>> graphDataList = [];

  final Utility _utility = Utility();

  final ScrollController _controller = ScrollController();

  List<Color> twelveColor = [];

  List<String> usageGuideList = [];

  List<String> dateList = [];

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    twelveColor = _utility.getTwelveColor();

    final deviceInfoState = ref.read(deviceInfoProvider);

    setChartData();

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

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  displayUsage(),
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
    const rakutenIndexBefore = '楽天・全米株式インデックス・ファンド（楽天・バンガード・ファンド（全米株式））';
    const rakutenIndexAfter = '楽天・全米株式インデックス・ファンド(楽天・VTI)';

    final shintakuState = _ref.watch(shintakuProvider(date));

    //------------------------------------------(1)
    final nums = <int>[];

    shintakuState.lastShintaku!.record.forEach((element) {
      final exElement = element.data.split('/');

      nums.add(exElement.length);
    });

    final maxValue = nums.reduce(max);
    final minValue = nums.reduce(min);

    final lengthDiff = maxValue - minValue;
    //------------------------------------------(1)

    //------------------------------------------(2)

    usageGuideList = [];
    dateList = [];

    final dataMap = <String, List<Map<String, String>?>>{};

    final points = <int>[];

    var j = 0;
    shintakuState.lastShintaku!.record.forEach((element) {
      final dataList = <Map<String, String>?>[];
      for (var i = 0; i < maxValue; i++) {
        dataList.add(null);
      }

      final adjuster = (element.name == rakutenIndexAfter) ? lengthDiff : 0;

      final exElementData = element.data.split('/');

      for (var i = 0; i < exElementData.length; i++) {
        final exData = exElementData[i].split('|');

        final map = <String, String>{};
        map['date'] = exData[0];
        map['point'] = exData[5];

        dataList[i + adjuster] = map;

        points.add(exData[5].toInt());

        if (j == 0) {
          dateList.add(exData[0]);
        }
      }

      dataMap[element.name] = dataList;

      usageGuideList.add(element.name);

      if (![rakutenIndexBefore, rakutenIndexAfter].contains(element.name)) {
        j++;
      }
    });
    //------------------------------------------(2)

    //------------------------------------------(3)
    final flspotsList = <List<FlSpot>>[];

    usageGuideList.forEach((element) {
      final flspots = <FlSpot>[];

      for (var i = 0; i < dataMap[element]!.length; i++) {
        flspots.add(
          FlSpot(
            i.toString().toDouble(),
            (dataMap[element]![i] == null) ? 0 : dataMap[element]![i]!['point'].toString().toDouble(),
          ),
        );
      }

      flspotsList.add(flspots);
    });
    //------------------------------------------(3)

    final maxPoint = points.reduce(max);
    final minPoint = points.reduce(min);

    const warisuu = 50000;
    final graphMax = (maxPoint / warisuu).ceil() * warisuu;
    final graphMin = (minPoint * -1 / warisuu).ceil() * warisuu * -1;

    graphData = LineChartData(
      ///
      minX: 0,
      maxX: (dateList.length - 1).toDouble(),
      //
      minY: graphMin.toDouble(),
      maxY: graphMax.toDouble(),

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
                  '${exDate[1]}-${exDate[2]}',
                  style: const TextStyle(fontSize: 12),
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
            style: TextStyle(
              color: twelveColor[list.length],
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      );
    });

    return Row(
      children: list,
    );
  }
}
