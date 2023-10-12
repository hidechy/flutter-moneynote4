// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import 'pages/spend_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class SpendAlert extends StatelessWidget {
  SpendAlert({super.key, required this.date, required this.diff});

  final DateTime date;
  final String diff;

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
              tabs: tabs.map((TabInfo tab) => Tab(text: tab.label)).toList(),
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

    for (var i = 0; i < 7; i++) {
      final day = date.add(Duration(days: i * -1));

      final youbi = day.youbiStr.substring(0, 3);

      tabs.add(
        TabInfo(
          '${day.yyyymmdd}($youbi)',
          SpendPage(date: day),
        ),
      );
    }
  }
}
