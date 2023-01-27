// ignore_for_file: must_be_immutable, avoid_bool_literals_in_conditional_expressions, unnecessary_null_comparison

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../utility/utility.dart';
import '../../viewmodel/money_notifier.dart';

class MoneyScoreGraphAlert extends ConsumerWidget {
  MoneyScoreGraphAlert({super.key, required this.date});

  final DateTime date;

  LineChartData data = LineChartData();

  List<FlSpot> flspots = [];

  final ScrollController _controller = ScrollController();

  double minGraphRate = 0.6;

  List<String> ymList = [];

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    setChartData();

    final moneyScoreState = ref.watch(moneyScoreProvider);

    final graphWidthState = ref.watch(graphWidthProvider);

    final deviceInfoState = ref.read(deviceInfoProvider);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: moneyScoreState.saving,
              child: SizedBox(
                width: context.screenSize.width * graphWidthState,
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
                      child: LineChart(data),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo.withOpacity(0.3),
                              ),
                              onPressed: () {
                                ref
                                    .watch(graphWidthProvider.notifier)
                                    .setGraphWidth(
                                      width: (graphWidthState == minGraphRate)
                                          ? (flspots.length / 5)
                                              .ceil()
                                              .toDouble()
                                          : minGraphRate,
                                    );
                              },
                              child: const Text('width'),
                            ),
                            if (graphWidthState > minGraphRate)
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.pinkAccent.withOpacity(0.3),
                                    ),
                                    onPressed: () {
                                      _controller.jumpTo(
                                          _controller.position.maxScrollExtent);
                                    },
                                    child: const Text('jump'),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        if (graphWidthState > minGraphRate)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.pinkAccent.withOpacity(0.3),
                            ),
                            onPressed: () {
                              _controller
                                  .jumpTo(_controller.position.minScrollExtent);
                            },
                            child: const Text('back'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (moneyScoreState.saving)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  ///
  void setChartData() {
    final graphWidthState = _ref.watch(graphWidthProvider);

    final moneyScoreState = _ref.watch(moneyScoreProvider);

    final list = <int>[];

    flspots = [];

    var j = 0;
    for (var i = 0; i < moneyScoreState.list.length; i++) {
      flspots.add(
        FlSpot(
          (j + 1).toDouble(),
          moneyScoreState.list[i].price.toInt().toDouble(),
        ),
      );

      list.add(moneyScoreState.list[i].price.toInt());

      ymList.add(moneyScoreState.list[i].ym);

      j++;
    }

    final minValue = list.reduce(min);
    final maxValue = list.reduce(max);

    const warisuu = 500000;

    final graphMin = ((minValue / warisuu).floor()) * warisuu;
    final graphMax = ((maxValue / warisuu).ceil()) * warisuu;

    data = LineChartData(
      ///
      minX: 1,
      maxX: flspots.length.toDouble(),
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
          sideTitles: SideTitles(
            showTitles: (graphWidthState == minGraphRate) ? false : true,
            reservedSize: 60,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: (graphWidthState == minGraphRate)
                    ? Container()
                    : (ymList[value.toInt() - 1] == null)
                        ? Container()
                        : Column(
                            children: [
                              Text(
                                '${ymList[value.toInt() - 1]}-01 00:00:00'
                                    .toDateTime()
                                    .yyyy,
                              ),
                              Text(
                                '${ymList[value.toInt() - 1]}-01 00:00:00'
                                    .toDateTime()
                                    .mm,
                              ),
                            ],
                          ),
              );
            },
          ),
        ),
        //-------------------------// 上部の目盛り

        //-------------------------// 下部の目盛り
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: (graphWidthState == minGraphRate)
                    ? Container()
                    : (ymList[value.toInt() - 1] == null)
                        ? Container()
                        : Column(
                            children: [
                              Text(
                                '${ymList[value.toInt() - 1]}-01 00:00:00'
                                    .toDateTime()
                                    .yyyy,
                              ),
                              Text(
                                '${ymList[value.toInt() - 1]}-01 00:00:00'
                                    .toDateTime()
                                    .mm,
                              ),
                            ],
                          ),
              );
            },
          ),
        ),
        //-------------------------// 下部の目盛り

        //-------------------------// 左側の目盛り
        leftTitles: (graphWidthState == minGraphRate)
            ? null
            : AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 100,
                  getTitlesWidget: (value, meta) {
                    return Text(value.toInt().toString());
                  },
                ),
              ),
        //-------------------------// 左側の目盛り

        //-------------------------// 右側の目盛り

        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: (graphWidthState == minGraphRate) ? false : true,
            reservedSize: 100,
            getTitlesWidget: (value, meta) {
              return Text(value.toInt().toString());
            },
          ),
        ),

        //-------------------------// 右側の目盛り
      ),

      ///
      lineBarsData: [
        LineChartBarData(
          spots: flspots,
          barWidth: (graphWidthState == minGraphRate) ? 3 : 5,
          isStrokeCapRound: true,
          color: Colors.yellowAccent,
        ),
      ],
    );
  }
}

///
////////////////////////////////////////////////////////////
final graphWidthProvider =
    StateNotifierProvider.autoDispose<GraphWidthStateNotifier, double>((ref) {
  return GraphWidthStateNotifier();
});

class GraphWidthStateNotifier extends StateNotifier<double> {
  GraphWidthStateNotifier() : super(0.6);

  ///
  Future<void> setGraphWidth({required double width}) async {
    state = width;
  }
}
