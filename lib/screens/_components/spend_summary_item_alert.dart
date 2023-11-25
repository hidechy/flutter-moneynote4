// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import 'pages/spend_summary_item_page.dart';

class TabInfo {
  TabInfo(this.label, this.widget);

  String label;
  Widget widget;
}

class SpendSummaryItemAlert extends StatelessWidget {
  SpendSummaryItemAlert({super.key, required this.date});

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

    final list = <String>[];

    for (var i = 2020; i <= DateTime.now().year; i++) {
      if (i == date.year) {
        for (var j = 1; j <= date.month; j++) {
          list.add('$i-${j.toString().padLeft(2, '0')}');
        }
      } else {
        for (var j = 1; j <= 12; j++) {
          list.add('$i-${j.toString().padLeft(2, '0')}');
        }
      }
    }

    list
      ..sort((a, b) => -1 * a.compareTo(b))
      ..forEach((element) {
        tabs.add(
          TabInfo(
            element,
            SpendSummaryItemPage(
              date: DateTime(element.split('-')[0].toInt(), element.split('-')[1].toInt()),
            ),
          ),
        );
      });
  }
}
