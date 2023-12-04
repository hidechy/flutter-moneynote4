// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../extensions/extensions.dart';
import '../../state/app_param/app_param_notifier.dart';
import '../../state/device_info/device_info_notifier.dart';
import '../../state/spend/spend_notifier.dart';
import '../../utility/utility.dart';

class SamedaySpendGraphAlert extends ConsumerWidget {
  SamedaySpendGraphAlert({super.key, required this.date});

  final DateTime date;

  List<DateTime> usageGuideList = [];

  LineChartData graphData = LineChartData();

  final Utility _utility = Utility();

  final ScrollController _controller = ScrollController();

  List<Color> twelveColor = [];

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
          width: context.screenSize.width * 3,
          height: context.screenSize.height - 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: context.screenSize.width),

              //----------//
              if (deviceInfoState.model == 'iPhone') _utility.getFileNameDebug(name: runtimeType.toString()),
              //----------//

              Expanded(child: LineChart(graphData)),

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
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.withOpacity(0.3)),
                    onPressed: () => _controller.jumpTo(_controller.position.maxScrollExtent),
                    child: const Text('jump'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent.withOpacity(0.3)),
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
    //---------------------------------------(1)
    usageGuideList = [];

    var flag = 1;
    if (date.year == 2020) {
      flag = (date.month < 6) ? 0 : 1;
    }

    switch (flag) {
      case 0:
        for (var i = 6; i >= 1; i--) {
          usageGuideList.add(DateTime(date.yyyy.toInt(), i));
        }
        break;
      case 1:
        for (var i = 0; i < 6; i++) {
          usageGuideList.add(DateTime(date.yyyy.toInt(), date.mm.toInt() - i));
        }
        break;
    }
    //---------------------------------------(1)

    //---------------------------------------(2)
    final graphValues = <String, List<Map<String, dynamic>>>{};

    usageGuideList.forEach((element) {
      final list2 = <Map<String, int>>[];

      var sum = 0;

      final spendYearlyList = _ref.watch(spendMonthDetailProvider(element).select((value) => value.spendYearlyList));

      spendYearlyList.value?.forEach((element2) {
        sum += element2.spend;

        list2.add({'day': element2.date.day, 'sum': sum});
      });

      graphValues[element.yyyymm] = list2;
    });
    //---------------------------------------(2)

    //---------------------------------------(3)
    final flspotsList = <List<FlSpot>>[];

    final points = <int>[];

    graphValues.entries.forEach((element) {
      final flspots = <FlSpot>[];

      element.value.forEach((element2) {
        flspots.add(FlSpot(element2['day'].toString().toDouble(), element2['sum'].toString().toDouble()));

        points.add(element2['sum']);
      });

      flspotsList.add(flspots);
    });
    //---------------------------------------(3)

    final SamedaySpendAlertDay = _ref.watch(appParamProvider.select((value) => value.SamedaySpendAlertDay));

    final yearmonth = DateTime.now().yyyymm;

    final maxPoint = (points.isNotEmpty) ? points.reduce(max) : 1000000;
    final round = (maxPoint / 500000).round();

    final graphYMax = (round + 1) * 500000;

    graphData = LineChartData(
      ///
      minX: 1,
      maxX: 31,
      //
      minY: 0,
      maxY: graphYMax.toDouble(),

      ///
      lineTouchData: LineTouchData(
        touchTooltipData:
            LineTouchTooltipData(tooltipBgColor: Colors.white.withOpacity(0.3), getTooltipItems: getGraphToolTip),
      ),

      ///
      gridData: _utility.getFlGridData(),

      ///
      titlesData: FlTitlesData(
        show: true,

        //-------------------------// 上部の目盛り
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        //-------------------------// 上部の目盛り

        //-------------------------// 下部の目盛り
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: Column(
                  children: [
                    Text(value.toInt().toString(), style: const TextStyle(fontSize: 12)),
                    if (date.yyyymm == yearmonth && value == SamedaySpendAlertDay)
                      const Text(
                        'today',
                        style: TextStyle(fontSize: 8, color: Colors.yellowAccent),
                      ),
                  ],
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
              return Text(value.toInt().toString(), style: const TextStyle(fontSize: 12));
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
              return Text(value.toInt().toString(), style: const TextStyle(fontSize: 12));
            },
          ),
        ),
        //-------------------------// 右側の目盛り
      ),

      ///
      lineBarsData: [
        //forで仕方ない
        for (var i = 0; i < flspotsList.length; i++)
          LineChartBarData(spots: flspotsList[i], barWidth: 3, isStrokeCapRound: true, color: twelveColor[i]),
      ],
    );
  }

  ///
  List<LineTooltipItem> getGraphToolTip(List<LineBarSpot> touchedSpots) {
    final list = <LineTooltipItem>[];

    touchedSpots.forEach((element) {
      final textStyle = TextStyle(
        color: element.bar.gradient?.colors.first ?? element.bar.color ?? Colors.blueGrey,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      );

      final price = element.y.round().toString().split('.')[0].toCurrency();
      final month = usageGuideList[element.barIndex].mm;

      list.add(LineTooltipItem('$price ($month)', textStyle, textAlign: TextAlign.end));
    });

    return list;
  }

  ///
  Widget displayUsage() {
    final list = <Widget>[];
    usageGuideList.forEach((element) {
      list.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          child: Text(
            element.yyyymm,
            style: TextStyle(color: twelveColor[list.length], fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      );
    });

    return Row(children: list);
  }
}
