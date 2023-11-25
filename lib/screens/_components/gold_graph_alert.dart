// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/gold/gold_notifier.dart';
import '../../utility/utility.dart';

class GoldGraphAlert extends ConsumerWidget {
  GoldGraphAlert({super.key});

  final Utility _utility = Utility();

  List<String> dateList = [];

  List<Color> twelveColor = [];

  LineChartData graphData = LineChartData();

  final ScrollController _controller = ScrollController();

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
    dateList = [];

    final flspotsList = <List<FlSpot>>[];

    final flspotsGoldValue = <FlSpot>[];
    final flspotsGoldDiff = <FlSpot>[];

    final points = <int>[];

    var j = 0;

    _ref.watch(goldListProvider.select((value) => value.goldList)).when(
          data: (value) {
            for (var i = 0; i < value.length; i++) {
              if (value[i].goldValue == '-') {
                continue;
              }

              final date = '${value[i].year}-${value[i].month}-${value[i].day}';

              dateList.add(date);

              flspotsGoldValue.add(FlSpot(j.toDouble(), value[i].goldValue.toString().toDouble()));

              flspotsGoldDiff.add(
                FlSpot(
                  j.toDouble(),
                  (value[i].goldValue.toString().toInt() - value[i].payPrice.toString().toInt()).toDouble(),
                ),
              );

              points.add(value[i].goldValue);

              j++;
            }
          },
          error: (error, stackTrace) => Container(),
          loading: Container.new,
        );

    /*

    final goldListState = _ref.watch(goldListProvider);


    for (var i = 0; i < goldListState.goldList.length; i++) {
      if (goldListState.goldList[i].goldValue == '-') {
        continue;
      }

      final date =
          '${goldListState.goldList[i].year}-${goldListState.goldList[i].month}-${goldListState.goldList[i].day}';

      dateList.add(date);

      flspotsGoldValue.add(
        FlSpot(
          j.toDouble(),
          goldListState.goldList[i].goldValue.toString().toDouble(),
        ),
      );

      flspotsGoldDiff.add(
        FlSpot(
          j.toDouble(),
          (goldListState.goldList[i].goldValue.toString().toInt() -
                  goldListState.goldList[i].payPrice.toString().toInt())
              .toDouble(),
        ),
      );

      points.add(goldListState.goldList[i].goldValue);

      j++;
    }



    */

    flspotsList
      ..add(flspotsGoldValue)
      ..add(flspotsGoldDiff);

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
}
