// ignore_for_file: must_be_immutable, avoid_bool_literals_in_conditional_expressions
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/money/money_notifier.dart';
import '../../utility/utility.dart';

class MonthlySpendGraphAlert extends ConsumerWidget {
  MonthlySpendGraphAlert({super.key, required this.date});

  final DateTime date;

  LineChartData data = LineChartData();

  List<FlSpot> flspots = [];

  final ScrollController _controller = ScrollController();

  double minGraphRate = 0.6;

  final Utility _utility = Utility();

  late WidgetRef _ref;

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ref = ref;

    setChartData();

    final graphWidthState = ref.watch(graphWidthProvider);

    final deviceInfoState = ref.read(deviceInfoProvider);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        child: SizedBox(
          width: context.screenSize.width * graphWidthState,
          height: context.screenSize.height - 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
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
                        onPressed: () => ref.read(graphWidthProvider.notifier).setGraphWidth(
                              width: (graphWidthState == minGraphRate)
                                  ? (flspots.length / 10).ceil().toDouble()
                                  : minGraphRate,
                            ),
                        child: const Text('width'),
                      ),
                      if (graphWidthState > minGraphRate)
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.withOpacity(0.3)),
                              onPressed: () => _controller.jumpTo(_controller.position.maxScrollExtent),
                              child: const Text('jump'),
                            ),
                          ],
                        ),
                    ],
                  ),
                  if (graphWidthState > minGraphRate)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent.withOpacity(0.3),
                      ),
                      onPressed: () => _controller.jumpTo(_controller.position.minScrollExtent),
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
    final graphWidthState = _ref.watch(graphWidthProvider);

    final list = <int>[];

    flspots = [];

    var j = 0;

    _ref.watch(moneyEverydayProvider.select((value) => value.moneyEverydayList)).when(
          data: (value) {
            for (var i = 0; i < value.length; i++) {
              if (date.yyyymm == value[i].date.yyyymm) {
                flspots.add(
                  FlSpot(
                    (j + 1).toDouble(),
                    value[i].sum.toInt().toDouble(),
                  ),
                );

                list.add(value[i].sum.toInt());

                j++;
              }
            }
          },
          error: (error, stackTrace) => Container(),
          loading: Container.new,
        );

    // final moneyEverydayState = _ref.watch(moneyEverydayProvider);
    //
    // for (var i = 0; i < moneyEverydayState.length; i++) {
    //   if (date.yyyymm == moneyEverydayState[i].date.yyyymm) {
    //     flspots.add(
    //       FlSpot(
    //         (j + 1).toDouble(),
    //         moneyEverydayState[i].sum.toInt().toDouble(),
    //       ),
    //     );
    //
    //     list.add(moneyEverydayState[i].sum.toInt());
    //
    //     j++;
    //   }
    // }
    //
    //
    //

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
            reservedSize: 32,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(value.toInt().toString()),
              );
            },
          ),
        ),
        //-------------------------// 上部の目盛り

        //-------------------------// 下部の目盛り
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
final graphWidthProvider = StateNotifierProvider.autoDispose<GraphWidthStateNotifier, double>((ref) {
  return GraphWidthStateNotifier();
});

class GraphWidthStateNotifier extends StateNotifier<double> {
  GraphWidthStateNotifier() : super(0.6);

  ///
  Future<void> setGraphWidth({required double width}) async {
    state = width;
  }
}
