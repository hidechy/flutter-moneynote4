// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../extensions/extensions.dart';
import 'pages/monthly_spend_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class MonthlySpendAlert extends StatelessWidget {
  MonthlySpendAlert({super.key, required this.date});

  final DateTime date;

  List<TabInfo> tabs = [];

  ///
  @override
  Widget build(BuildContext context) {
    makeTab();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            //-------------------------//これを消すと「←」が出てくる（消さない）
            leading: const Icon(
              Icons.check_box_outline_blank,
              color: Colors.transparent,
            ),
            //-------------------------//これを消すと「←」が出てくる（消さない）

            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.blueAccent,
              tabs: tabs.map((TabInfo tab) {
                return Tab(text: tab.label);
              }).toList(),
            ),

            flexibleSpace: const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: tabs.map((tab) => tab.widget).toList(),
        ),
      ),
    );
  }

  ///
  void makeTab() {
    tabs = [];

    final list = <String>[];

    final firstDate = DateTime(2020);

    final diff = DateTime.now().difference(firstDate).inDays;

    for (var i = 0; i <= diff; i++) {
      final genDate = firstDate.add(Duration(days: i));

      if (genDate.day == 1) {
        list.add(genDate.yyyymm);
      }
    }

    list
      ..sort((a, b) => -1 * a.compareTo(b))
      ..forEach((element) {
        tabs.add(
          TabInfo(
            element,
            MonthlySpendPage(
              date: DateTime(
                element.split('-')[0].toInt(),
                element.split('-')[1].toInt(),
              ),
            ),
          ),
        );
      });
  }
}
